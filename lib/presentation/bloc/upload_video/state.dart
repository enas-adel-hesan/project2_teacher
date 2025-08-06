class UploadVideoState {
}

class InitialState extends UploadVideoState{}
class LoadingState extends UploadVideoState{}
class ErrorState extends UploadVideoState{
  final String message;
  ErrorState(this.message);
}
class SuccessState extends UploadVideoState{}
class UploadProgressState extends UploadVideoState {
  final double progress;
  UploadProgressState(this.progress);
}