import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart'; // لـ MediaType
import 'package:teacher/data/models/course_details_model.dart';
import 'package:teacher/data/models/course_model.dart';
import '../../../app_links.dart';
import '../../../core/errors/network/network_info.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/services/preference_service.dart';
import '../../../injection_container.dart';
import 'state.dart';

class UploadVideoCubit extends Cubit<UploadVideoState> {
  UploadVideoCubit() : super(InitialState());

  PlatformFile? pickedFile;
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();
  final preferences = sl<PreferencesService>();

  double uploadProgress = 0.0;

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      pickedFile = result.files.first;
      emit(InitialState());
    }
  }

  Future<void> uploadVideo(int courseId) async {
    if (pickedFile == null) {
      emit(ErrorState("Please choice a video first"));
      return;
    }

    emit(LoadingState());

    try {
      FormData formData = FormData.fromMap({
        'video': MultipartFile.fromBytes(
          pickedFile!.bytes!,
          filename: pickedFile!.name,
          contentType: MediaType('video', 'mp4'),
        ),
      });

      final _ = await DioHelper.uploadFile(
        url: "${AppLinks.uploadVideo}$courseId",
        token: preferences.token,
        data: formData,
        onSendProgress: (sent, total) {
          double progress = sent / total;
          uploadProgress = progress;
          emit(UploadProgressState(progress));
        },
      );

      emit(SuccessState());
      pickedFile = null;
      uploadProgress = 0.0;
    } catch (e) {
      emit(ErrorState("Error while uploading: $e"));
    }
  }

  Future<void> createQuiz(Map<String, dynamic> payload) async {
    emit(LoadingState());
    try {
      final _ = await DioHelper.postData(
        url: AppLinks.addExam, // endpoint تبعك
        data: payload,
      );

      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  CourseDetailsModel? course;

  Future<void> getCourseDetails(int courseId) async {
    emit(LoadingState());
    try {
      final response = await DioHelper.getData(
        url: "${AppLinks.courseDetails}/$courseId", // endpoint تبعك
      );
      course = CourseDetailsModel.fromJson(response.data);

      emit(SuccessStateDetails(course!));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
