class VideoModel {
  String? status;
  String? message;
  Video? video;

  VideoModel({this.status, this.message, this.video});

  VideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class Video {
  int? courseId;
  String? videoUrl;
  String? uploadedAt;
  int? fileSize;
  String? videoName;
  String? updatedAt;
  String? createdAt;
  int? id;

  Video({
    this.courseId,
    this.videoUrl,
    this.uploadedAt,
    this.fileSize,
    this.videoName,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Video.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    videoUrl = json['video_url'];
    uploadedAt = json['uploaded_at'];
    fileSize = json['file_size'];
    videoName = json['video_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['video_url'] = videoUrl;
    data['uploaded_at'] = uploadedAt;
    data['file_size'] = fileSize;
    data['video_name'] = videoName;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
