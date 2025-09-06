import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/constants/links/images_links.dart';
import 'package:teacher/core/constants/strings/register_strings.dart';
import 'package:teacher/presentation/bloc/register_cubit/state.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:teacher/presentation/widgets/shared/custom_text_filed.dart';

import '../../data/datasource/local/list_data.dart';
import '../bloc/register_cubit/cubit.dart';
import '../widgets/shared/custom_drop_down.dart';

class TeacherRegister2 extends StatelessWidget {
  final RegisterCubit cubit;

  const TeacherRegister2({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 80),
        child: Center(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  padding: EdgeInsets.only(right: 0),

                  child: Center(
                    child: BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is SecondStepErrorState) {
                          cubit.formKey2.currentState?.validate();
                        } else {
                          if (state is SecondStepSuccessState) {
                            cubit.nextStep();
                          }
                        }
                      },
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Form(
                            key: cubit.formKey2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  RegisterStrings.title2,
                                  textAlign: TextAlign.center,
                                  style: TextTheme.of(context).labelLarge,
                                ),
                                Text(
                                  RegisterStrings.subtitle2,
                                  textAlign: TextAlign.center,
                                  style: TextTheme.of(context).bodyMedium,
                                ),
                                CustomTextField(
                                  label: RegisterStrings.firstName,
                                  controller: cubit.firstNameController,
                                  validator: (value) {
                                    if (cubit.firstNameError.isNotEmpty) {
                                      return cubit.firstNameError;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  label: RegisterStrings.lastName,
                                  controller: cubit.lastNameController,
                                  validator: (value) {
                                    if (cubit.lastNameError.isNotEmpty) {
                                      return cubit.lastNameError;
                                    }
                                    return null;
                                  },
                                ),
                                CustomDropDownField(
                                  validator: (value) {
                                    if (cubit.genderError.isNotEmpty) {
                                      return cubit.genderError;
                                    }
                                    return null;
                                  },
                                  label: RegisterStrings.gender,
                                  items: gender!,
                                  onChanged: (value) {
                                    cubit.gender = value;
                                  },
                                ),
                                SizedBox(height: 5,),
                                if(state is LoadingState)

                                  Center(child: CircularProgressIndicator(),),
                                CustomElevatedButton(
                                  title: "Next",
                                  onPressed: () {
                                    cubit.register();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                width: 500,
                AppImages.register2,

                //   colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn), // اختياري لتغيير اللون
              ),
            ],
          ),
        ),
      ),
    );
  }
}
