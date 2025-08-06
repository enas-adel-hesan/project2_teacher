import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:teacher/data/models/course_model.dart';
import '../../../app_links.dart';
import '../../../core/errors/network/network_info.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/handle_network_call.dart';
import '../../../data/services/preference_service.dart';
import '../../../injection_container.dart';
import 'state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  CoursesCubit() : super(CoursesState());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String categoryId = '';
  final preferences = sl<PreferencesService>();
  int? createdCourseId;
  Map<String, dynamic> get data => {
    'category_id': categoryId,
    'name': nameController.text.trim(),
    'price': priceController.text,
    'description': priceController.text.trim(),
  };

  Future<void> addCourse() async {
    emit(LoadingState());

    final result = await handleNetworkCall<CourseModel>(
      networkInfo: networkInfo,
      apiCall: addCourseRequest,
    );

    return result.fold(
      (failure) {
        emit(ErrorState(failure.message));
      },
      (course) {
        createdCourseId = course.course?.original!.data!.id!;
        print(".............................");
        print(createdCourseId);
        emit(SuccessState(createdCourseId!));
      },
    );
  }

  Future<CourseModel> addCourseRequest() async {
    final response = await DioHelper.postData(
      url: AppLinks.addCourse,
      data: data,
      token: preferences.token,
    );
    return CourseModel.fromJson(response.data);
  }

  void setCategoryId(String id) {
    categoryId = id;
  }
}
