import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/constants/links/images_links.dart';
import 'package:teacher/core/constants/strings/register_strings.dart';
import 'package:teacher/presentation/bloc/register_cubit/cubit.dart';
import 'package:teacher/presentation/bloc/register_cubit/state.dart';
import 'package:teacher/presentation/widgets/register/redirect.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:teacher/presentation/widgets/shared/custom_text_filed.dart';

import '../../routes.dart';

class TeacherRegister1 extends StatelessWidget {
  final RegisterCubit cubit;
  const TeacherRegister1({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.register1, width: 500),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(left: 80),
                child: Form(
                  key: cubit.formKey1,
                  child: Center(
                    child: BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is FirstStepErrorState) {
                          cubit.formKey1.currentState?.validate();
                        } else {
                          if (state is FirstStepSuccessState) {
                            cubit.nextStep();
                          }
                        }
                      },
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                RegisterStrings.title1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                RegisterStrings.subtitle1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),

                              CustomTextField(
                                label: RegisterStrings.email,
                                controller: cubit.emailController,
                                validator: (value) {
                                  if (cubit.emailError.isNotEmpty) {
                                    return cubit.emailError;
                                  }
                                  return null;
                                },
                              ),

                              CustomTextField(
                                label: RegisterStrings.password,
                                controller: cubit.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (cubit.passwordError.isNotEmpty) {
                                    return cubit.passwordError;
                                  }
                                  return null;
                                },
                              ),

                              CustomTextField(
                                label: RegisterStrings.confirmPassword,
                                controller: cubit.confirmPasswordController,
                                obscureText: true,
                              ),
                              //const SizedBox(height: 32),
                              CustomElevatedButton(
                                title: "Next",
                                onPressed: () async {
                                  await cubit.register();
                                },
                              ),

                              Redirect(
                                title: RegisterStrings.alreadyHaveAccount,
                                textButton: RegisterStrings.login,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.login,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
