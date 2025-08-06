import 'package:flutter/material.dart';

List<DropdownMenuItem<dynamic>>? gender = [
  DropdownMenuItem(value: 'male', child: Text('male')),
  DropdownMenuItem(value: 'female', child: Text('female')),
];

List<DropdownMenuItem<dynamic>>? categories = [
  DropdownMenuItem(value: '1', child: Text('Programming')),
  DropdownMenuItem(value: '2', child: Text('Design')),
  DropdownMenuItem(value: '3', child: Text('Marketing')),


];

final List<Map<String, dynamic>> _specialties = [
  {
    'value': 'computer_science',
    'label': 'Computer Science',
    'icon': Icons.computer_outlined,
  },
  {
    'value': 'software_engineering',
    'label': 'Software Engineering',
    'icon': Icons.code,
  },
  {
    'value': 'artificial_intelligence',
    'label': 'Artificial Intelligence',
    'icon': Icons.memory,
  },
  {'value': 'data_science', 'label': 'Data Science', 'icon': Icons.bar_chart},
  {
    'value': 'cyber_security',
    'label': 'Cyber Security',
    'icon': Icons.security,
  },
  {'value': 'networking', 'label': 'Networking', 'icon': Icons.network_check},
  {
    'value': 'database_systems',
    'label': 'Database Systems',
    'icon': Icons.storage,
  },
  {'value': 'mathematics', 'label': 'Mathematics', 'icon': Icons.calculate},
  {'value': 'physics', 'label': 'Physics', 'icon': Icons.science},
  {
    'value': 'electrical_engineering',
    'label': 'Electrical Engineering',
    'icon': Icons.electrical_services,
  },
  {
    'value': 'mechanical_engineering',
    'label': 'Mechanical Engineering',
    'icon': Icons.precision_manufacturing,
  },
  {
    'value': 'civil_engineering',
    'label': 'Civil Engineering',
    'icon': Icons.engineering,
  },
  {'value': 'biology', 'label': 'Biology', 'icon': Icons.biotech},
  {'value': 'chemistry', 'label': 'Chemistry', 'icon': Icons.science_outlined},
  {
    'value': 'english_language',
    'label': 'English Language',
    'icon': Icons.language,
  },
  {'value': 'psychology', 'label': 'Psychology', 'icon': Icons.psychology},
  {
    'value': 'business_administration',
    'label': 'Business Administration',
    'icon': Icons.business_center,
  },
  {'value': 'other', 'label': 'Other...', 'icon': Icons.more_horiz},
];

List<DropdownMenuItem<String>> professorSpecialties() {
  return _specialties.map((specialty) {
    return DropdownMenuItem<String>(
      value: specialty['value'],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(specialty['label']), Icon(specialty['icon'], size: 20)],
      ),
    );
  }).toList();
}
