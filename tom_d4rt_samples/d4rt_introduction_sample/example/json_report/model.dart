// Domain model for the json_report example. Pure D4rt — no host types.

/// An employee record parsed from a map.
class Employee {
  final String name;
  final String department;
  final int salary;

  Employee(this.name, this.department, this.salary);

  /// Build an [Employee] from a decoded JSON-like map.
  factory Employee.fromMap(Map<String, Object?> map) => Employee(
        map['name'] as String,
        map['department'] as String,
        map['salary'] as int,
      );
}

/// Aggregated statistics for one department.
class DepartmentStats {
  final String department;
  int headcount = 0;
  int totalSalary = 0;

  DepartmentStats(this.department);

  double get averageSalary => headcount == 0 ? 0 : totalSalary / headcount;

  void add(Employee e) {
    headcount++;
    totalSalary += e.salary;
  }
}
