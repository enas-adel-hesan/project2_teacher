import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/core/constants/links/images_links.dart';
import 'package:teacher/core/constants/strings/register_strings.dart';
import 'package:teacher/presentation/bloc/register_cubit/state.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:teacher/presentation/widgets/shared/custom_text_filed.dart';
import '../../data/datasource/local/list_data.dart';
import '../../routes.dart';
import '../bloc/register_cubit/cubit.dart';
import '../widgets/shared/custom_drop_down.dart';


class TeacherRegister3 extends StatelessWidget {
  final RegisterCubit cubit;

  const TeacherRegister3({super.key, required this.cubit});

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
                        if (state is ThirdStepErrorState) {
                          cubit.formKey3.currentState?.validate();
                        } else {
                          if (state is ThirdStepSuccessState) {
                            print("success");
                          }
                        }
                        if(state is SuccessState){
                          Navigator.pushReplacementNamed(context, Routes.home);
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: cubit.formKey3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                RegisterStrings.title3,
                                textAlign: TextAlign.center,
                                style: TextTheme.of(context).labelLarge,
                              ),
                              Text(
                                RegisterStrings.subtitle3,
                                textAlign: TextAlign.center,
                                style: TextTheme.of(context).bodyMedium,
                              ),
                              CustomDropDownField(
                                validator: (value) {
                                  if (cubit.specializationError.isNotEmpty) {
                                    return cubit.specializationError;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  cubit.specialization = value!;
                                },
                                label: RegisterStrings.specialization,
                                items: professorSpecialties(),
                              ),
                              SizedBox(
                                height: 250,
                                child: CustomTextField(
                                  validator: (value) {
                                    if (cubit.aboutYouError.isNotEmpty) {
                                      return cubit.aboutYouError;
                                    }
                                    return null;
                                  },
                                  controller: cubit.aboutYouController,
                                  maxLines: 10,
                                  label: RegisterStrings.aboutYou,
                                ),
                              ),

                              CustomElevatedButton(
                                title: "Next",
                                onPressed: () {
                                  cubit.register();
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: SvgPicture.asset(
                  width: 500,

                  AppImages.register3,

                  //   colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn), // اختياري لتغيير اللون
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
