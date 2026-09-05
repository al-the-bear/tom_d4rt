import 'dart:async';

import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/callable.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';

/// Represents the state of an ongoing asynchronous function execution.
/// This object tracks the progress and context needed for resumption.
class AsyncExecutionState {
  /// The unique environment for this specific function call.
  final Environment environment;

  /// The completer associated with the Future returned to the caller.
  final Completer<Object?> completer;

  /// An identifier for the next block of code (state) to execute.
  /// This could be an integer index, an AST node reference, etc.
  /// (Needs further definition based on the state machine implementation).
  SAstNode? nextStateIdentifier;

  /// The result value from the most recently completed Future (from await).
  ///
  /// Note this is the *most recent* result, not "the result of the await site
  /// being resumed" — those coincide only when a statement contains a single
  /// await. For per-site replay use [resolvedAwaitResults]; this slot remains
  /// the completion value the state machine falls back to.
  Object? lastAwaitResult;

  /// Results of the await sites already resolved while resuming the statement
  /// currently in flight, keyed by the `AwaitExpression` node itself.
  ///
  /// SCC40: resuming a statement means re-evaluating it from the top, so every
  /// await it contains is visited again. With only [lastAwaitResult] to consult,
  /// each of those visits returned the same value — so `(await a) + (await b)`
  /// evaluated to `'AA'`, a silent wrong answer rather than a crash. Keying by
  /// node lets an already-resolved site replay *its own* value while a site that
  /// has not been reached yet still suspends properly.
  ///
  /// Scoped to one evaluation of one statement: [resumingStatementHasMoreAwaits]
  /// says whether that evaluation is still in progress, and the state machine
  /// clears this map as soon as it is not. A loop body re-enters the identical
  /// AST node on every iteration, so a map that outlived the statement would
  /// replay the previous iteration's value.
  ///
  /// Keyed by IDENTITY, deliberately. `SAstNode` overrides `==` with structural
  /// `equals()` and hashes on `(runtimeType, offset, length)`, so a plain map
  /// would treat two await sites as one whenever the mirror tree reuses a
  /// node shape — and this map's whole job is to tell await sites apart.
  final Map<SAstNode, Object?> resolvedAwaitResults =
      Map<SAstNode, Object?>.identity();

  /// Set while resuming a statement that still has an unreached await site.
  ///
  /// The state machine consults it after `_determineNextNodeAfterAwait` to
  /// decide whether [resolvedAwaitResults] survives into the next step.
  bool resumingStatementHasMoreAwaits = false;

  /// The error from the most recently completed Future (if it failed).
  Object? lastAwaitError;

  /// The stack trace from the most recently completed Future (if it failed).
  StackTrace? lastAwaitStackTrace;

  /// Optional: Store the iterator for ongoing for-in loops.
  Iterator<Object?>? currentForInIterator;

  /// Optional: Flag for standard for-loops.
  bool forLoopInitialized = true;

  /// Optional: Environment for the current standard for-loop scope.
  Environment? forLoopEnvironment;

  /// Stack of loop environments for nested loops
  final List<Environment> loopEnvironmentStack = [];

  /// Stack of initialization flags for nested loops
  final List<bool> loopInitializedStack = [];

  /// Stack of SForStatement nodes corresponding to the environments
  final List<SForStatement> loopNodeStack = [];

  /// Map of SForStatement -> Iterator for for-in loops
  final Map<SForStatement, Iterator<Object?>?> forInIteratorMap = {};

  /// Stack of loop nodes (SForStatement, SWhileStatement, etc.) for break/continue.
  final List<SAstNode> loopStack = [];

  /// Flag to indicate that a `continue` is being handled for a `for` loop.
  bool isHandlingContinue = false;

  /// Optional: A reference back to the function definition might be useful.
  final InterpretedFunction function;

  /// NEW FLAG
  bool resumedFromInitializer = false;

  /// Track pending finally block to execute after try/catch
  SBlock? pendingFinallyBlock;

  /// Track the error currently being handled (either from await or sync throw)
  Object? currentError;

  /// Track the stack trace currently being handled (either from await or sync throw)
  StackTrace? currentStackTrace;

  /// Track the STryStatement we are currently inside or handling
  STryStatement? activeTryStatement;

  /// Store return value if a return happens inside a try with a finally.
  Object? returnAfterFinally;

  /// An error that is only *passing through* a `finally` block: it was raised in
  /// a protected region that has no matching catch clause, so it must be
  /// re-raised at the enclosing try once the finally has finished.
  ///
  /// SCC12: it cannot simply be left in [currentError] while the finally runs.
  /// The state machine clears [currentError] after every statement that
  /// completes normally, so an error parked there is erased by the first
  /// statement of the finally block — which is how an exception thrown inside
  /// `try { … } finally { … }` inside an async function used to vanish
  /// altogether, leaving the enclosing `catch` unrun.
  Object? errorAfterFinally;

  /// The stack trace belonging to [errorAfterFinally].
  StackTrace? errorAfterFinallyStackTrace;

  /// The `try` whose finally block [errorAfterFinally] is waiting for. Non-null
  /// exactly while an error is held, and used to recognise the moment the block
  /// ends — the error must resume at the *enclosing* try, not this one.
  STryStatement? errorAfterFinallyTry;

  /// Set when the finally block named by [errorAfterFinallyTry] has finished, so
  /// the next state-machine step re-raises the held error instead of executing
  /// the statement that follows the try.
  bool resumeErrorAfterFinally = false;

  /// Flag to indicate if we are currently executing a catch block body.
  bool isHandlingErrorForRethrow = false;

  /// Store the original exception wrapped for potential rethrow.
  InternalInterpreterD4rtException? originalErrorForRethrow;

  /// Flag to indicate we are currently executing a rethrow statement
  /// (as opposed to just being in a catch block)
  bool isCurrentlyRethrowing = false;

  /// Flag to indicate if we are resuming an invocation with await in arguments
  /// When true, await expressions should return the last resolved value instead of suspending
  bool isInvocationResumptionMode = false;

  /// Fields for await for loop processing
  List<Object?>? currentAwaitForList;

  /// Current index when processing await for loops with stream conversion.
  /// Used to track position in the converted list from a stream.
  int? currentAwaitForIndex;

  /// Flag indicating if the interpreter is currently waiting for stream conversion.
  /// When true, indicates that a stream is being converted to a list for await-for processing.
  bool awaitingStreamConversion = false;

  /// Stack of lists for nested await-for loops
  /// Each level of nesting has its own list
  final List<List<Object?>> awaitForListStack = [];

  /// Stack of indices for nested await-for loops
  /// Each level of nesting has its own index
  final List<int> awaitForIndexStack = [];

  /// Stack of SForStatement nodes for nested await-for loops
  /// Used to track which await-for loop we're in
  final List<SForStatement> awaitForNodeStack = [];

  /// For async* generators: the stream controller to send yields to
  StreamController<Object?>? generatorStreamController;

  /// For async* generators: flag indicating this is a generator execution
  bool get isGenerator => generatorStreamController != null;

  /// Creates a new async execution state.
  ///
  /// [environment] The execution environment for the async function.
  /// [completer] The completer that will complete when the function finishes.
  /// [nextStateIdentifier] The AST node representing the next state to execute.
  /// [function] The interpreted function being executed asynchronously.
  AsyncExecutionState({
    required this.environment,
    required this.completer,
    required this.nextStateIdentifier,
    required this.function,
    this.lastAwaitResult,
    this.lastAwaitError,
    this.lastAwaitStackTrace,
    this.currentForInIterator,
    this.forLoopInitialized = false,
    this.forLoopEnvironment,
    this.pendingFinallyBlock,
    this.currentError,
    this.currentStackTrace,
    this.activeTryStatement,
    this.returnAfterFinally,
    this.isHandlingErrorForRethrow = false,
    this.originalErrorForRethrow,
    this.isHandlingContinue = false,
    this.generatorStreamController,
  });
}

/// Represents a request to suspend execution and wait for a Future.
/// This object is returned by visitor methods when an await is encountered.
class AsyncSuspensionRequest {
  /// The Future that needs to be awaited.
  final Future<Object?> future;

  /// The state object associated with the execution that needs suspension.
  /// This is needed by the scheduler to know which execution to resume later.
  final AsyncExecutionState asyncState;

  /// Flag indicating if this suspension is from a yield statement
  final bool isYieldSuspension;

  /// The `await` site that produced this suspension, when there is one.
  ///
  /// SCC40: this is what lets the resolved value be filed against its own await
  /// expression in [AsyncExecutionState.resolvedAwaitResults] instead of a
  /// single per-frame slot shared by every await in the statement. Null for
  /// suspensions the state machine raises itself (yield, await-for stream
  /// conversion), which resume by a different route and need no per-site replay.
  final SAstNode? awaitNode;

  /// Creates a new async suspension request.
  ///
  /// [future] The Future that the interpreter should wait for.
  /// [asyncState] The current execution state that will be resumed after the Future completes.
  /// [isYieldSuspension] Whether this suspension is from a yield statement.
  /// [awaitNode] The `await` expression this suspension came from, if any.
  AsyncSuspensionRequest(
    this.future,
    this.asyncState, {
    this.isYieldSuspension = false,
    this.awaitNode,
  });
}
