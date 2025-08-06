import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:teacher/core/constants/links/lottie_links.dart';
import 'package:teacher/core/constants/strings/home_strings.dart';
import 'package:teacher/core/constants/strings/register_strings.dart';
import '../../core/constants/colors_manager.dart';
import '../../routes.dart';
import '../widgets/welcome/animated_shape.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BuildWelcomePage();
  }
}

class _BuildWelcomePage extends StatelessWidget {
  const _BuildWelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.login);
              },

              child: Text(RegisterStrings.login),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          const Positioned(
            top: 80,
            left: 40,
            child: AnimatedShape(
              size: 100,
              color: AppColors.secondary,
              shape: BoxShape.circle,
              delay: Duration(milliseconds: 300),
            ),
          ),
          const Positioned(
            bottom: 120,
            right: 60,
            child: AnimatedShape(
              size: 140,
              color: AppColors.secondary,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(40)),
              delay: Duration(milliseconds: 600),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            HomeStrings.homeTitle,
                            style: GoogleFonts.poppins(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.3,
                                  ),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slide(begin: const Offset(-0.5, 0))
                          .then()
                          .scale(duration: 500.ms, curve: Curves.easeOut),

                      const SizedBox(height: 20),

                      Text(
                            HomeStrings.homeSubTitle,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.white.withValues(alpha: 0.85),
                              height: 1.4,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 1000.ms)
                          .slide(
                            begin: const Offset(-0.3, 0),
                            curve: Curves.easeIn,
                          ),

                      const SizedBox(height: 40),

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Animate(
                          effects: [
                            ShakeEffect(
                              duration: 1200.ms,
                              hz: 1.5,
                              curve: Curves.easeInOut,
                            ),
                          ],
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.teacherRegister,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              shadowColor: AppColors.primary.withValues(
                                alpha: 0.7,
                              ),
                              elevation: 8,
                            ),
                            child: Text(

                              HomeStrings.register,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 60),

                Expanded(
                  flex: 5,
                  child: Lottie.network(
                    LottieLinks.homeImage,
                    width: 500,
                    height: 500,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
