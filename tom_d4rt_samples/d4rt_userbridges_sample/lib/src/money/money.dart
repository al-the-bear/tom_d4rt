/// A money value type whose arithmetic operators need user bridges.
///
/// The bridge generator handles plain methods and getters automatically, but
/// operator overloading is one of the cases where the generated adapter is not
/// reliable — so [MoneyUserBridge] supplies the operator implementations by
/// hand. The class itself is ordinary Dart; nothing here knows about D4rt.
library;

/// An immutable amount of money, stored as an integer number of cents to avoid
/// floating-point rounding error.
class Money {
  /// The amount in whole cents.
  final int cents;

  /// The ISO currency code (e.g. `USD`).
  final String currency;

  /// Create money from a whole number of [cents].
  const Money(this.cents, [this.currency = 'USD']);

  /// Create money from a fractional [amount] of the major unit (dollars).
  Money.amount(double amount, [this.currency = 'USD'])
      : cents = (amount * 100).round();

  /// Add two amounts. Both must share the same [currency].
  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(cents + other.cents, currency);
  }

  /// Subtract [other] from this amount. Both must share the same [currency].
  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(cents - other.cents, currency);
  }

  /// Scale this amount by a numeric [factor] (e.g. a tax rate or quantity).
  Money operator *(num factor) => Money((cents * factor).round(), currency);

  /// Unary negation — flips the sign of the amount.
  Money operator -() => Money(-cents, currency);

  @override
  bool operator ==(Object other) =>
      other is Money && other.cents == cents && other.currency == currency;

  @override
  int get hashCode => Object.hash(cents, currency);

  /// The amount expressed in the major unit (dollars).
  double get majorUnits => cents / 100;

  /// Whether the amount is negative.
  bool get isNegative => cents < 0;

  /// A plain, currency-prefixed rendering. [MoneyUserBridge] overrides this to
  /// add sign-aware accounting formatting, so a script that calls `format()`
  /// gets the user-bridge version rather than this one.
  String format() => '$currency ${majorUnits.toStringAsFixed(2)}';

  void _assertSameCurrency(Money other) {
    if (other.currency != currency) {
      throw ArgumentError(
        'Currency mismatch: $currency vs ${other.currency}',
      );
    }
  }

  @override
  String toString() => 'Money($cents, $currency)';
}
