class TeacherModel {
  String? status;
  String? message;
  Data? data;

  TeacherModel({this.status, this.message, this.data});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? firstName;
  String? lastName;
  String? specialization;
  String? previousExperiences;
  String? phone;
  String? profileImage;
  String? country;
  String? city;
  String? gender;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.userId,
    this.firstName,
    this.lastName,
    this.specialization,
    this.previousExperiences,
    this.phone,
    this.profileImage,
    this.country,
    this.city,
    this.gender,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    specialization = json['specialization'];
    previousExperiences = json['Previous_experiences'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    country = json['country'];
    city = json['city'];
    gender = json['gender'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['specialization'] = specialization;
    data['Previous_experiences'] = previousExperiences;
    data['phone'] = phone;
    data['profile_image'] = profileImage;
    data['country'] = country;
    data['city'] = city;
    data['gender'] = gender;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
