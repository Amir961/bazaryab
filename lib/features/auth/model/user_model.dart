import 'dart:convert';
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  UserModel({
      bool? success, 
      Data? data, 
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  UserModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  String? _message;
UserModel copyWith({  bool? success,
  Data? data,
  String? message,
}) => UserModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;
Data copyWith({  User? user,
  String? token,
}) => Data(  user: user ?? _user,
  token: token ?? _token,
);
  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? name, 
      String? username,
    int? isOnline,
      dynamic state, 
      dynamic city, 
      dynamic activityArea, 
      dynamic avatar,}){
    _name = name;
    _username = username;
    _state = state;
    _city = city;
    _activityArea = activityArea;
    _avatar = avatar;
    _isOnline = isOnline;
}

  User.fromJson(dynamic json) {
    _name = json['name'];
    _username = json['username'];
    _state = json['state'];
    _city = json['city'];
    _activityArea = json['activity_area'];
    _avatar = json['avatar'];
    _isOnline = json['is_online'];
  }
  String? _name;
  String? _username;
  int? _isOnline;
  dynamic _state;
  dynamic _city;
  dynamic _activityArea;
  dynamic _avatar;
User copyWith({  String? name,
  String? username,
  int? isOnline,
  dynamic state,
  dynamic city,
  dynamic activityArea,
  dynamic avatar,
}) => User(  name: name ?? _name,
  username: username ?? _username,
  isOnline: isOnline ?? _isOnline,
  state: state ?? _state,
  city: city ?? _city,
  activityArea: activityArea ?? _activityArea,
  avatar: avatar ?? _avatar,
);
  int? get isOnline => _isOnline;
  String? get name => _name;
  String? get username => _username;
  dynamic get state => _state;
  dynamic get city => _city;
  dynamic get activityArea => _activityArea;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['is_online'] = _isOnline;
    map['username'] = _username;
    map['state'] = _state;
    map['city'] = _city;
    map['activity_area'] = _activityArea;
    map['avatar'] = _avatar;
    return map;
  }

}