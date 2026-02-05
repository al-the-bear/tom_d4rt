/// Demonstrates sealed classes and exhaustive pattern matching
///
/// Features covered:
/// - sealed class definition
/// - Subtype hierarchy
/// - Exhaustive switch expressions
/// - Pattern matching with sealed types
/// - Nested sealed hierarchies

void main() {
  print('=== Sealed Classes ===');
  print('');

  // Basic sealed class
  print('--- Basic Sealed Class ---');
  var results = [
    Success('Data loaded'),
    Failure('Network error'),
    Loading(),
  ];

  for (var result in results) {
    print(handleResult(result));
  }

  // Sealed with data
  print('');
  print('--- Sealed with Data ---');
  List<ApiResponse> responses = [
    SuccessResponse(200, {'user': 'Alice'}),
    ErrorResponse(404, 'Not found'),
    RedirectResponse(301, 'https://new-url.com'),
  ];

  for (var response in responses) {
    processResponse(response);
  }

  // Exhaustive switch expression
  print('');
  print('--- Exhaustive Switch Expression ---');
  List<PaymentMethod> payments = [
    CreditCard('1234-5678-9012-3456', '12/25'),
    DebitCard('9876-5432-1098-7654'),
    PayPal('user@email.com'),
    BankTransfer('IBAN12345'),
  ];

  for (var payment in payments) {
    var fee = calculateFee(payment, 100.0);
    print('${payment.runtimeType}: \$100 + fee = \$${fee.toStringAsFixed(2)}');
  }

  // Pattern matching with destructuring
  print('');
  print('--- Pattern Matching with Destructuring ---');
  List<Expression> expressions = [
    NumberExpr(42),
    BinaryExpr(NumberExpr(10), '+', NumberExpr(5)),
    BinaryExpr(NumberExpr(20), '*', NumberExpr(3)),
    BinaryExpr(BinaryExpr(NumberExpr(2), '+', NumberExpr(3)), '*', NumberExpr(4)),
  ];

  for (var expr in expressions) {
    print('$expr = ${evaluate(expr)}');
  }

  // Nested sealed hierarchy
  print('');
  print('--- Nested Sealed Hierarchy ---');
  List<UiEvent> events = [
    ClickEvent(100, 200),
    KeyPressEvent('Enter'),
    SwipeEvent(SwipeDirection.left, 150.0),
    SwipeEvent(SwipeDirection.up, 80.0),
  ];

  for (var event in events) {
    print(describeEvent(event));
  }

  // Guards with sealed types
  print('');
  print('--- Guards with Sealed Types ---');
  List<LoginResult> loginResults = [
    LoginSuccess('Alice', 'admin'),
    LoginSuccess('Bob', 'user'),
    LoginFailure('Invalid password', 3),
    LoginFailure('Account locked', 5),
    LoginPending('Two-factor required'),
  ];

  for (var result in loginResults) {
    print(processLogin(result));
  }

  print('');
  print('=== End of Sealed Classes Demo ===');
}

// Basic sealed class
sealed class Result {}

class Success extends Result {
  final String data;
  Success(this.data);
}

class Failure extends Result {
  final String error;
  Failure(this.error);
}

class Loading extends Result {}

// Factory constructors for convenience
extension ResultFactory on Result {
  static Success success(String data) => Success(data);
  static Failure failure(String error) => Failure(error);
  static Loading loading() => Loading();
}

String handleResult(Result result) {
  return switch (result) {
    Success(data: var d) => 'Success: $d',
    Failure(error: var e) => 'Error: $e',
    Loading() => 'Loading...',
  };
}

// Sealed with data
sealed class ApiResponse {
  final int statusCode;
  ApiResponse(this.statusCode);
}

class SuccessResponse extends ApiResponse {
  final Map<String, dynamic> data;
  SuccessResponse(super.statusCode, this.data);
}

class ErrorResponse extends ApiResponse {
  final String message;
  ErrorResponse(super.statusCode, this.message);
}

class RedirectResponse extends ApiResponse {
  final String location;
  RedirectResponse(super.statusCode, this.location);
}

void processResponse(ApiResponse response) {
  switch (response) {
    case SuccessResponse(statusCode: var code, data: var d):
      print('[$code] Data: $d');
    case ErrorResponse(statusCode: var code, message: var m):
      print('[$code] Error: $m');
    case RedirectResponse(statusCode: var code, location: var l):
      print('[$code] Redirect to: $l');
  }
}

// Payment methods
sealed class PaymentMethod {}

class CreditCard extends PaymentMethod {
  final String number;
  final String expiry;
  CreditCard(this.number, this.expiry);
}

class DebitCard extends PaymentMethod {
  final String number;
  DebitCard(this.number);
}

class PayPal extends PaymentMethod {
  final String email;
  PayPal(this.email);
}

class BankTransfer extends PaymentMethod {
  final String iban;
  BankTransfer(this.iban);
}

double calculateFee(PaymentMethod method, double amount) {
  return switch (method) {
    CreditCard() => amount * 1.025, // 2.5% fee
    DebitCard() => amount * 1.01, // 1% fee
    PayPal() => amount * 1.029, // 2.9% fee
    BankTransfer() => amount + 1.50, // flat fee
  };
}

// Expression tree
sealed class Expression {}

class NumberExpr extends Expression {
  final int value;
  NumberExpr(this.value);

  @override
  String toString() => '$value';
}

class BinaryExpr extends Expression {
  final Expression left;
  final String op;
  final Expression right;
  BinaryExpr(this.left, this.op, this.right);

  @override
  String toString() => '($left $op $right)';
}

int evaluate(Expression expr) {
  return switch (expr) {
    NumberExpr(value: var v) => v,
    BinaryExpr(left: var l, op: '+', right: var r) => evaluate(l) + evaluate(r),
    BinaryExpr(left: var l, op: '-', right: var r) => evaluate(l) - evaluate(r),
    BinaryExpr(left: var l, op: '*', right: var r) => evaluate(l) * evaluate(r),
    BinaryExpr(left: var l, op: '/', right: var r) => evaluate(l) ~/ evaluate(r),
    BinaryExpr() => throw ArgumentError('Unknown operator'),
  };
}

// Nested sealed hierarchy
sealed class UiEvent {}

class ClickEvent extends UiEvent {
  final int x;
  final int y;
  ClickEvent(this.x, this.y);
}

class KeyPressEvent extends UiEvent {
  final String key;
  KeyPressEvent(this.key);
}

class SwipeEvent extends UiEvent {
  final SwipeDirection direction;
  final double distance;
  SwipeEvent(this.direction, this.distance);
}

enum SwipeDirection { left, right, up, down }

String describeEvent(UiEvent event) {
  return switch (event) {
    ClickEvent(x: var x, y: var y) => 'Click at ($x, $y)',
    KeyPressEvent(key: var k) => 'Key pressed: $k',
    SwipeEvent(direction: SwipeDirection.left, distance: var d) =>
      'Swipe left: ${d}px',
    SwipeEvent(direction: SwipeDirection.right, distance: var d) =>
      'Swipe right: ${d}px',
    SwipeEvent(direction: SwipeDirection.up || SwipeDirection.down, distance: var d) =>
      'Vertical swipe: ${d}px',
  };
}

// Login result with guards
sealed class LoginResult {}

class LoginSuccess extends LoginResult {
  final String username;
  final String role;
  LoginSuccess(this.username, this.role);
}

class LoginFailure extends LoginResult {
  final String message;
  final int attempts;
  LoginFailure(this.message, this.attempts);
}

class LoginPending extends LoginResult {
  final String reason;
  LoginPending(this.reason);
}

String processLogin(LoginResult result) {
  return switch (result) {
    LoginSuccess(username: var u, role: 'admin') => '$u logged in as ADMIN',
    LoginSuccess(username: var u, role: var r) => '$u logged in with role: $r',
    LoginFailure(attempts: var a) when a >= 5 => 'Account locked after $a attempts',
    LoginFailure(message: var m, attempts: var a) => 'Failed: $m ($a attempts)',
    LoginPending(reason: var r) => 'Pending: $r',
  };
}
