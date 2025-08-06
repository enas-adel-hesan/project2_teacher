import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/presentation/bloc/courses/cubit.dart';
import 'package:teacher/presentation/bloc/courses/state.dart';
import 'package:teacher/presentation/widgets/shared/custom_drop_down.dart';
import 'package:teacher/presentation/widgets/shared/custom_elevated_button.dart';
import 'package:teacher/presentation/widgets/shared/custom_text_filed.dart';
import 'package:teacher/presentation/widgets/shared/error_message.dart';
import 'package:teacher/presentation/widgets/shared/flush_bar.dart';
import '../../data/datasource/local/list_data.dart';
import '../../injection_container.dart';
import '../../routes.dart';

class AddCourse extends StatelessWidget {
  const AddCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => sl<CoursesCubit>(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            child: BlocConsumer<CoursesCubit, CoursesState>(
              listener: (context, state) {
                if (state is SuccessState) {

                  showSuccessFlushBar(context).then((_) {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.courseDetails,
                      arguments: state.cId,

                    );
                  });

                  //
                }
              },
              builder: (context, state) {
                final cubit = context.watch<CoursesCubit>();
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 300,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Create New Course",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Category Dropdown
                        CustomDropDownField(
                          onChanged: (value) => cubit.setCategoryId(value),
                          label: "Select Category",
                          items: categories!,
                        ),

                        // Title
                        CustomTextField(
                          label: "Course Title",
                          controller: cubit.nameController,
                        ),

                        // Description
                        CustomTextField(
                          label: "Description",
                          controller: cubit.descriptionController,
                          maxLines: 3,
                        ),

                        // Price
                        CustomTextField(
                          label: "Price",
                          controller: cubit.priceController,
                          keyboardType: TextInputType.number,
                        ),

                        if (state is ErrorState)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ErrorMessageWidget(message: state.message),
                          ),

                        // Add Course Button
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            title: "Add Course",
                            onPressed: () => cubit.addCourse(),
                          ),
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
    );
  }
}
