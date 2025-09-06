import 'package:teacher/data/models/course_model.dart';

import '../../../data/models/course_details_model.dart';

class UploadVideoState {
}

class InitialState extends UploadVideoState{}
class LoadingState extends UploadVideoState{}
class ErrorState extends UploadVideoState{
  final String message;
  ErrorState(this.message);
}
class SuccessState extends UploadVideoState{}
class SuccessStateDetails extends UploadVideoState{
  CourseDetailsModel course;
  SuccessStateDetails(this.course);
}
class UploadProgressState extends UploadVideoState {
  final double progress;
  UploadProgressState(this.progress);
}