
class CourseDetailsModel {
  String? status;
  Data? data;

  CourseDetailsModel({this.status, this.data});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? teacherName;
  String? categoryName;
  String? name;
  String? price;
  String? description;

  Data({this.id, this.teacherName, this.categoryName, this.name, this.price, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    teacherName = json["teacher_name"];
    categoryName = json["category_name"];
    name = json["name"];
    price = json["price"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["teacher_name"] = teacherName;
    _data["category_name"] = categoryName;
    _data["name"] = name;
    _data["price"] = price;
    _data["description"] = description;
    return _data;
  }
}