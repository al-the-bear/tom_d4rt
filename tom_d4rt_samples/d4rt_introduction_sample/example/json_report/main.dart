#!/usr/bin/env run_example
// json_report example: collections, closures and higher-order functions.
//
// Groups a list of employee records by department and prints a salary report.
// Imports `model.dart` with a relative path (resolved from the folder).

import 'model.dart';

void main(List<String> args) {
  final raw = <Map<String, Object?>>[
    {'name': 'Alice', 'department': 'Engineering', 'salary': 120000},
    {'name': 'Bob', 'department': 'Engineering', 'salary': 95000},
    {'name': 'Carol', 'department': 'Design', 'salary': 88000},
    {'name': 'Dan', 'department': 'Design', 'salary': 91000},
    {'name': 'Eve', 'department': 'Sales', 'salary': 70000},
  ];

  final employees = raw.map(Employee.fromMap).toList();

  // Fold into per-department stats using a closure over the accumulator.
  final stats = <String, DepartmentStats>{};
  for (final e in employees) {
    stats.putIfAbsent(e.department, () => DepartmentStats(e.department)).add(e);
  }

  final sorted = stats.values.toList()
    ..sort((a, b) => b.averageSalary.compareTo(a.averageSalary));

  print('Department salary report (highest average first):');
  for (final s in sorted) {
    final avg = s.averageSalary.toStringAsFixed(0);
    print('  ${s.department.padRight(12)} headcount=${s.headcount}  avg=\$$avg');
  }

  final topEarner = employees.reduce((a, b) => a.salary >= b.salary ? a : b);
  print('\nTop earner: ${topEarner.name} (\$${topEarner.salary})');
}
