import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/links/images_links.dart';
import '../../routes.dart';
import '../widgets/shared/custom_elevated_button.dart';

class TeacherRegisterSuccessPage extends StatelessWidget {
  final bool isFormal; // لتبديل النصوص بين رسمي وودي

  const TeacherRegisterSuccessPage({super.key, this.isFormal = false});

  @override
  Widget build(BuildContext context) {
    // نصوص حسب النمط
    final title = isFormal
        ? "Your application has been successfully submitted"
        : "Great job! Your request has been sent 🎉";

    final subtitle = isFormal
        ? "Thank you for registering with our platform.\nYour application is now under review, and you will receive a response shortly via your registered email address."
        : "Thanks for joining our learning community!\nWe’re reviewing your application now and will get back to you soon by email.";

    final buttonText = isFormal ? "Back to Home" : "Go to Home";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Icon
                SvgPicture.asset(
                  AppImages.successIcon, // success.svg داخل مجلد الصور
                  width: 360,
                  height: 360,
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),

               // const SizedBox(height: 30),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                    fontSize: 30
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 20),

                // Subtitle
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade700,
                    height: 1.6,
                    fontSize: 20
                  ),
                ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.4, end: 0),

                const SizedBox(height: 50),

                // Button
                CustomElevatedButton(
                  title: buttonText,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
                  },
                ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.5, end: 0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
