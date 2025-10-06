import 'dart:convert';
CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));
String cityModelToJson(CityModel data) => json.encode(data.toJson());
class CityModel {
  CityModel({
      bool? success, 
      List<City>? data,
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  CityModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(City.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _success;
  List<City>? _data;
  String? _message;
CityModel copyWith({  bool? success,
  List<City>? data,
  String? message,
}) => CityModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  List<City>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

City dataFromJson(String str) => City.fromJson(json.decode(str));
String dataToJson(City data) => json.encode(data.toJson());
class City {
  City({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  City.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
City copyWith({  num? id,
  String? title,
}) => City(  id: id ?? _id,
  title: title ?? _title,
);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}