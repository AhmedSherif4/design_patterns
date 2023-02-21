import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../apis/json_students_api.dart';
import '../../student.dart';
import '../../students_bmi_calculator.dart';

class TeenageStudentsJsonBmiCalculator extends StudentsBmiCalculator {
  final JsonStudentsApi _api = JsonStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    final String studentsJson = _api.getStudentsJson();
    final Map<String, dynamic> studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    final List studentsJsonList = studentsMap['students'] as List;
    final List<Student> studentsList = studentsJsonList.map((json) {
      final Map<String, dynamic> studentJson = json as Map<String, dynamic>;

      return Student(
        fullName: studentJson['fullName'] as String,
        age: studentJson['age'] as int,
        height: studentJson['height'] as double,
        weight: studentJson['weight'] as int,
      );
    }).toList();

    return studentsList;
  }

  @override
  @protected
  List<Student> doStudentsFiltering(List<Student> studentList) {
    return studentList
        .where((student) => student.age > 12 && student.age < 20)
        .toList();
  }
}
