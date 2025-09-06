
class CourseModel {
  String? status;
  String? message;
  List<Data>? data;

  CourseModel({this.status, this.message, this.data});

  CourseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  int? userId;
  int? categoryId;
  String? name;
  String? price;
  String? description;
  int? accepted;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.userId, this.categoryId, this.name, this.price, this.description, this.accepted, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    categoryId = json["category_id"];
    name = json["name"];
    price = json["price"];
    description = json["description"];
    accepted = json["accepted"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["category_id"] = categoryId;
    data["name"] = name;
    data["price"] = price;
    data["description"] = description;
    data["accepted"] = accepted;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}