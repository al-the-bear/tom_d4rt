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
  /// Keyed by IDENTITY, deliberately. `SAstNode` overrides `==` with
  /// `equals()`, which serializes both sides via `toJson()` and deep-diffs
  /// them. Under a plain map every lookup here would run that deep diff on a
  /// hot path — and two await sites whose *entire* subtrees serialize
  /// identically (`await next()` written twice) would fuse into one entry,
  /// which is precisely what this map exists to prevent. Identity keying costs
  /// a pointer compare. Note the fusing half is reasoned, not test-pinned: see
  /// `test/runtime/scc40_per_await_site_resumption_test.dart` for why the case
  /// cannot be written today.
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

  /// Whether the pending suspension is an `await for`'s `moveNext()`.
  ///
  /// SCE16. This used to be `awaitingStreamConversion`, and the name was
  /// accurate: the loop suspended ONCE on `stream.toList()` and then walked the
  /// list. That made `await for` eager — every element was produced before the
  /// body ran once, a `break` could not stop the producer, and a loop over an
  /// infinite stream never ran its body at all because `toList()` never
  /// completes. The loop now suspends once per element on
  /// [StreamIterator.moveNext], which is what `await for` means.
  bool awaitingStreamMoveNext = false;

  /// Stack of stream iterators for nested await-for loops.
  ///
  /// Parallel to [awaitForNodeStack]. Each entry owns a subscription and MUST
  /// be cancelled when its loop is left — see [truncateLoopStacks].
  final List<StreamIterator<Object?>> awaitForIteratorStack = [];

  /// Whether each nested await-for loop currently holds an unconsumed element.
  ///
  /// Parallel to [awaitForNodeStack]. The loop's handler is re-entered both
  /// after a `moveNext()` resumption and after its body finishes, and this is
  /// what tells those apart: with an element in hand it binds and runs the
  /// body, without one it asks for the next.
  final List<bool> awaitForHasElementStack = [];

  /// Stack of SForStatement nodes for nested await-for loops
  /// Used to track which await-for loop we're in
  final List<SForStatement> awaitForNodeStack = [];

  /// The `do` loops whose body has already been entered.
  ///
  /// SCE19. The state machine re-enters a `DoStatement` node for two different
  /// reasons — arriving at the loop from the statement before it, and coming
  /// back from the end of its body — and it used to assume the second,
  /// evaluating the condition every time. So `do { n++; } while (false);`
  /// never ran its body at all. Loops whose condition is true on entry gave the
  /// right answer, which is why nothing caught it.
  ///
  /// Membership is what tells the two arrivals apart: absent means the body has
  /// not run yet and must, present means the body has finished and the
  /// condition decides. `continue` deliberately leaves the entry in place — it
  /// returns to the loop from INSIDE, and Dart evaluates the condition for it
  /// (F-SCD4-13 pins that).
  ///
  /// Keyed by IDENTITY, and load-bearing in the `tom_d4rt_ast` twin: `SAstNode`
  /// overrides `==` with a structural `toJson()` comparison, so a plain Set
  /// there would treat two identical-looking `do` loops as one.
  final Set<SDoStatement> doBodiesStarted = Set<SDoStatement>.identity();

  /// How deep each loop stack was when a `for` loop was entered.
  ///
  /// WHY. Leaving a loop — at its end, or by `break` / `continue` from inside
  /// it — must remove exactly what it and the loops nested in it pushed, and
  /// the stacks cannot answer that themselves: they are not parallel. A for-in
  /// over an existing variable pushes a node and no environment, a for-in
  /// that declares one pushes its environment only on the first element, and
  /// only a classic `for` pushes an initialisation flag. Popping "the last
  /// entry" of each, which `break` used to do, left the wrong loop whenever
  /// those shapes were nested. Recording the depths on entry makes the exit
  /// exact whatever was pushed in between.
  ///
  /// Keyed by identity: the node is the loop, not a structurally equal one.
  final Map<SAstNode, LoopStackDepths> loopEntryDepths = Map.identity();

  /// Records that [loop] is being entered, before it pushes anything.
  void recordLoopEntry(SAstNode loop) {
    loopEntryDepths[loop] = LoopStackDepths(
      nodes: loopNodeStack.length,
      environments: loopEnvironmentStack.length,
      initialized: loopInitializedStack.length,
      awaitFor: awaitForNodeStack.length,
    );
  }

  /// Restores every loop stack to [depths], forgetting the loops that are
  /// removed — so a loop entered again later starts from scratch instead of
  /// resuming a stale iterator or list.
  void truncateLoopStacks(LoopStackDepths depths) {
    for (final node in loopNodeStack.skip(depths.nodes)) {
      forInIteratorMap.remove(node);
      loopEntryDepths.remove(node);
    }
    for (final node in awaitForNodeStack.skip(depths.awaitFor)) {
      loopEntryDepths.remove(node);
    }
    // SCE16: an await-for being left owns a live subscription. Cancelling it is
    // what stops the producer — an `async*` generator resumes at its `yield`
    // and runs its `finally` blocks, and an infinite stream stops arriving.
    // Leaving it uncancelled is how a `break` used to mean nothing to the
    // stream.
    //
    // NOT awaited, because every caller of this is a synchronous exit path in
    // the state machine (break, continue, loop end, an exception unwinding).
    // The cancel still happens promptly — it is the ORDERING against code after
    // the loop that is not guaranteed, which is why a test that observes a
    // generator's `finally` has to await a turn first.
    for (final iterator in awaitForIteratorStack.skip(depths.awaitFor)) {
      unawaited(iterator.cancel().catchError((Object _) {}));
    }
    _shrink(loopNodeStack, depths.nodes);
    _shrink(loopEnvironmentStack, depths.environments);
    _shrink(loopInitializedStack, depths.initialized);
    _shrink(awaitForNodeStack, depths.awaitFor);
    _shrink(awaitForIteratorStack, depths.awaitFor);
    _shrink(awaitForHasElementStack, depths.awaitFor);
    if (awaitForNodeStack.isEmpty) {
      currentAwaitForList = null;
      currentAwaitForIndex = null;
    }
  }

  static void _shrink(List<Object?> stack, int depth) {
    if (stack.length > depth) stack.removeRange(depth, stack.length);
  }

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

/// The depth of each loop stack at the moment a loop was entered; see
/// [AsyncExecutionState.loopEntryDepths].
class LoopStackDepths {
  const LoopStackDepths({
    required this.nodes,
    required this.environments,
    required this.initialized,
    required this.awaitFor,
  });

  final int nodes;
  final int environments;
  final int initialized;
  final int awaitFor;
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
