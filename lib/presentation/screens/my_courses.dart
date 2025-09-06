
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/presentation/bloc/my_courses/cubit.dart';
import 'package:teacher/presentation/bloc/my_courses/state.dart';

import '../../data/models/my_courses_model.dart';
import '../../routes.dart';
import '../widgets/course_card.dart';
import '../widgets/shared/error_message.dart';

// الصفحة الرئيسية للكورسات
class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCoursesCubit()..getMyCourse(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MyCoursesCubit, MyCoursesState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SuccessState) {
              if (state.myCourses.isEmpty) {
                return const NoCoursesWidget();
              } else {
                return SizedBox(
                  height: 350,
                  child: GridView.builder(
                    itemCount: state.myCourses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 2 كارد في الصف
                          // crossAxisSpacing: 1,
                          // mainAxisSpacing: 1,
                        //  childAspectRatio: 1 / 4,
                        ),
                    itemBuilder: (context, index) {
                      final course = state.myCourses[index];
                      return CourseCard(course: course,published: true,onInfo: (){
                        Navigator.pushNamed(context,Routes.courseDetails,arguments: course.id);
                      },);
                    },
                  ),
                );
              }
            }
            if (state is ErrorState) {
              return ErrorMessageWidget(message: state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

/// ويدجت تظهر لما ما يكون عندك كورسات
class NoCoursesWidget extends StatelessWidget {
  const NoCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school, size: 80, color: Colors.blueAccent)
              .animate()
              .scale(duration: 600.ms, curve: Curves.easeInOut)
              .shake(hz: 2, curve: Curves.easeInOut),
          const SizedBox(height: 20),
          const Text(
            "You don't have any courses yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Start creating your first course and share your knowledge!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black45),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: الانتقال لصفحة إنشاء كورس
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "Create Course",
              style: TextStyle(color: Colors.white),
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
}


