import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/constants/links/images_links.dart';
import 'package:teacher/core/constants/strings/register_strings.dart';
import 'package:teacher/presentation/bloc/login/cubit.dart';
import 'package:teacher/presentation/bloc/login/state.dart';
import 'package:teacher/presentation/widgets/register/redirect.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:teacher/presentation/widgets/shared/custom_text_filed.dart';

import '../../injection_container.dart';
import '../../routes.dart';
import '../widgets/shared/error_message.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: _BuildLoginPage(),
    );
  }
}

class _BuildLoginPage extends StatelessWidget {
  const _BuildLoginPage();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Row(
            children: [
              /// Illustration
              Expanded(child: SvgPicture.asset(AppImages.login, width: 500)),

              /// Login Form
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 60,
                    ),
                    child: SingleChildScrollView(
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          final cubit = context.read<LoginCubit>();
                          if (state is LoginErrorState) {
                            cubit.formKey.currentState?.validate(); //
                          } else if (state is ErrorState) {
                            cubit.formKey.currentState?.validate(); //
                          } else {
                            if (state is SuccessState) {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.home,
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return Form(
                            key: cubit.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  RegisterStrings.loginTitle1,
                                  textAlign: TextAlign.center,
                                  style: TextTheme.of(context).labelLarge,
                                ),

                                Text(
                                  RegisterStrings.loginSubtitle1,
                                  textAlign: TextAlign.center,
                                  style: TextTheme.of(context).bodyMedium,
                                ),

                                CustomTextField(
                                  controller: cubit.emailController,
                                  validator: (value) {
                                    if (cubit.emailError.isNotEmpty) {
                                      return cubit.emailError;
                                    }
                                    return null;
                                  },
                                  label: RegisterStrings.email,
                                ),

                                CustomTextField(
                                  obscureText: true,
                                  controller: cubit.passwordController,
                                  validator: (value) {
                                    if (cubit.passwordError.isNotEmpty) {
                                      return cubit.passwordError;
                                    }
                                    return null;
                                  },
                                  label: RegisterStrings.password,
                                ),

                                if (state is ErrorState)
                                  ErrorMessageWidget(message: state.message),
                                CustomElevatedButton(
                                  title: RegisterStrings.login,
                                  onPressed: () {
                                    cubit.login();
                                  },
                                ),
                                SizedBox(height: 5,),
                                if (state is LoadingState)
                                  Center(child: CircularProgressIndicator()),
                                Redirect(
                                  title: RegisterStrings.doNotHaveAccount,
                                  textButton: RegisterStrings.signUp,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes.teacherRegister,
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
      ),
    );
  }
}
