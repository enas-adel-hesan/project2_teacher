import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_links.dart';
import '../../../core/errors/network/network_info.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/handle_network_call.dart';
import '../../../data/models/my_courses_model.dart';
import '../../../data/services/preference_service.dart';
import '../../../injection_container.dart';
import 'state.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  MyCoursesCubit() : super(InitialState());

  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  final preferences = sl<PreferencesService>();

  Future<void> getMyCourse() async {
    emit(LoadingState());

    final result = await handleNetworkCall<CourseModel>(
      networkInfo: networkInfo,
      apiCall: getMyCoursesRequest,
    );

    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (categoryModel) => emit(SuccessState(categoryModel.data ?? [])),
    );
  }

  Future<CourseModel> getMyCoursesRequest() async {
    final response = await DioHelper.postData(
      token: preferences.token,
      url: AppLinks.myCourses,
      data: {'teacher_id': preferences.userId},
    );
    return CourseModel.fromJson(response.data);
  }
}
