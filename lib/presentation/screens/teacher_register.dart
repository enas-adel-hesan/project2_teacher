import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/presentation/bloc/register_cubit/cubit.dart';
import 'package:teacher/presentation/screens/teacher_register_1.dart';
import 'package:teacher/presentation/screens/teacher_register_2.dart';
import 'package:teacher/presentation/screens/teacher_register_3.dart';

import '../../injection_container.dart';
import '../bloc/register_cubit/state.dart';

class TeacherRegister extends StatelessWidget {
  const TeacherRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final cubit = context.read<RegisterCubit>();


            switch (cubit.currentStep) {
              case 1:
                return TeacherRegister1(cubit: cubit);
              case 2:
                return TeacherRegister2(cubit: cubit);
              case 3:
                return TeacherRegister3(cubit: cubit);
              default:
                return TeacherRegister1(cubit: cubit);
            }
          },
        ),
      ),
    );
  }
}
