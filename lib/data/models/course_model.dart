class CourseModel {
  String? status;
  Course? course;

  CourseModel({this.status, this.course});

  CourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Course {
  Original? original;
  String? exception;

  Course({this.original, this.exception});

  Course.fromJson(Map<String, dynamic> json) {
    original = json['original'] != null
        ? Original.fromJson(json['original'])
        : null;
    exception = json['exception'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (original != null) {
      data['original'] = original!.toJson();
    }
    data['exception'] = exception;
    return data;
  }
}

class Original {
  String? status;
  String? message;
  Data? data;

  Original({this.status, this.message, this.data});

  Original.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? categoryId;
  String? name;
  String? price;
  String? description;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.categoryId,
        this.name,
        this.price,
        this.description,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
