import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';

import '../../injection_container.dart';
import '../../routes.dart';
import '../bloc/categories/cubit.dart';
import 'add_course.dart';
import 'my_courses.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Courses', style: TextTheme.of(context).headlineLarge),
            Divider(),
            SizedBox(height: 20),
            CustomElevatedButton(
              title: "New Course",
              onPressed: () {
                Navigator.pushNamed(context, Routes.addCourse);
              },
            ),
            SizedBox(height: 20,),
            CoursesPage()
          ],
        ),
      ),
    );
  }
}



