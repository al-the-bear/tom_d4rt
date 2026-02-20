// D4rt test: INH03 - Implements (interface)
// Verifies classes implementing interfaces have all methods bridged.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // EmailNotificationService implements NotificationService
  var email = EmailNotificationService();
  email.send('Hello via email');

  var sms = SmsNotificationService();
  sms.send('Hello via SMS');

  // SmartThermostat implements Switchable, TemperatureControl, Connectable
  var thermostat = SmartThermostat();
  thermostat.turnOn();
  thermostat.setTemperature(22);
  thermostat.connect();
  thermostat.turnOff();

  if (errors.isEmpty) {
    print('INH03_PASSED');
  } else {
    print('INH03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
