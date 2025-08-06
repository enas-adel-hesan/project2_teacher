import 'package:flutter/material.dart';
import 'package:teacher/presentation/screens/add_course.dart';
import 'package:teacher/presentation/screens/course_details.dart';
import 'presentation/screens/home.dart';
import 'presentation/screens/welcome_page.dart';
import 'presentation/screens/login.dart';
import 'presentation/screens/teacher_register.dart';

class Routes {
  static const String welcomeRoute = "/";
  static const String login = "/login";
  static const String teacherRegister = "/teacherRegister";
  static const String home = "/home";
  static const String courseDetails = "/courseDetails";
  static const String addCourse = "/addCourse";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const Login(),
          settings: settings,
        );

      case Routes.welcomeRoute:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
          settings: settings,
        );

      case Routes.teacherRegister:
        return MaterialPageRoute(
          builder: (_) => const TeacherRegister(),
          settings: settings,
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
          settings: settings,
        );

      case Routes.courseDetails:
        final courseId = settings.arguments ;
        if (courseId != null && courseId is int) {
          return MaterialPageRoute(
            builder: (_) => CourseDetails(courseId: courseId),
          );
        }
        else {
          return MaterialPageRoute(
          builder: (_) => Home(), // يمكن لاحقًا استخدام settings.arguments
          settings: settings,
        );
        }

      case Routes.addCourse:
        return MaterialPageRoute(
          builder: (_) => const AddCourse(),
          settings: settings,
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(child: Text("No Route")),
      ),
    );
  }
}
