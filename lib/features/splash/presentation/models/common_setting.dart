import 'dart:convert';
CommonSetting commonSettingFromJson(String str) => CommonSetting.fromJson(json.decode(str));
String commonSettingToJson(CommonSetting data) => json.encode(data.toJson());
class CommonSetting {
  CommonSetting({
      bool? success, 
      DataApp? data,
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  CommonSetting.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? DataApp.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  DataApp? _data;
  String? _message;
CommonSetting copyWith({  bool? success,
  DataApp? data,
  String? message,
}) => CommonSetting(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  DataApp? get data => _data;
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

DataApp dataFromJson(String str) => DataApp.fromJson(json.decode(str));
String dataToJson(DataApp data) => json.encode(data.toJson());
class DataApp {
  DataApp({
      Setting? setting, 
      List<UserType>? industry,
      List<UserType>? position,
      List<UserType>? customerStatus,
      List<UserType>? userType,}){
    _setting = setting;
    _industry = industry;
    _position = position;
    _customerStatus = customerStatus;
    _userType = userType;
}

  DataApp.fromJson(dynamic json) {
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    if (json['industry'] != null) {
      _industry = [];
      json['industry'].forEach((v) {
        _industry?.add(UserType.fromJson(v));
      });
    }
    if (json['position'] != null) {
      _position = [];
      json['position'].forEach((v) {
        _position?.add(UserType.fromJson(v));
      });
    }
    if (json['customer_status'] != null) {
      _customerStatus = [];
      json['customer_status'].forEach((v) {
        _customerStatus?.add(UserType.fromJson(v));
      });
    }
    if (json['user_type'] != null) {
      _userType = [];
      json['user_type'].forEach((v) {
        _userType?.add(UserType.fromJson(v));
      });
    }
  }
  Setting? _setting;
  List<UserType>? _industry;
  List<UserType>? _position;
  List<UserType>? _customerStatus;
  List<UserType>? _userType;
DataApp copyWith({  Setting? setting,
  List<UserType>? industry,
  List<UserType>? position,
  List<UserType>? customerStatus,
  List<UserType>? userType,
}) => DataApp(  setting: setting ?? _setting,
  industry: industry ?? _industry,
  position: position ?? _position,
  customerStatus: customerStatus ?? _customerStatus,
  userType: userType ?? _userType,
);
  Setting? get setting => _setting;
  List<UserType>? get industry => _industry;
  List<UserType>? get position => _position;
  List<UserType>? get customerStatus => _customerStatus;
  List<UserType>? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    if (_industry != null) {
      map['industry'] = _industry?.map((v) => v.toJson()).toList();
    }
    if (_position != null) {
      map['position'] = _position?.map((v) => v.toJson()).toList();
    }
    if (_customerStatus != null) {
      map['customer_status'] = _customerStatus?.map((v) => v.toJson()).toList();
    }
    if (_userType != null) {
      map['user_type'] = _userType?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

UserType userTypeFromJson(String str) => UserType.fromJson(json.decode(str));
String userTypeToJson(UserType data) => json.encode(data.toJson());
class UserType {
  UserType({
      String? key, 
      String? title,}){
    _key = key;
    _title = title;
}

  UserType.fromJson(dynamic json) {
    _key = json['key'];
    _title = json['title'];
  }
  String? _key;
  String? _title;
UserType copyWith({  String? key,
  String? title,
}) => UserType(  key: key ?? _key,
  title: title ?? _title,
);
  String? get key => _key;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['title'] = _title;
    return map;
  }

}







Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));
String settingToJson(Setting data) => json.encode(data.toJson());
class Setting {
  Setting({
      Location? location, 
      App? app, 
      num? customerOtp,}){
    _location = location;
    _app = app;
    _customerOtp = customerOtp;
}

  Setting.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _app = json['app'] != null ? App.fromJson(json['app']) : null;
    _customerOtp = json['customer_otp'];
  }
  Location? _location;
  App? _app;
  num? _customerOtp;
Setting copyWith({  Location? location,
  App? app,
  num? customerOtp,
}) => Setting(  location: location ?? _location,
  app: app ?? _app,
  customerOtp: customerOtp ?? _customerOtp,
);
  Location? get location => _location;
  App? get app => _app;
  num? get customerOtp => _customerOtp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_app != null) {
      map['app'] = _app?.toJson();
    }
    map['customer_otp'] = _customerOtp;
    return map;
  }

}

App appFromJson(String str) => App.fromJson(json.decode(str));
String appToJson(App data) => json.encode(data.toJson());
class App {
  App({
      String? v, 
      String? androidUrl, 
      String? iosUrl, 
      num? forceUpdate,}){
    _v = v;
    _androidUrl = androidUrl;
    _iosUrl = iosUrl;
    _forceUpdate = forceUpdate;
}

  App.fromJson(dynamic json) {
    _v = json['v'];
    _androidUrl = json['android_url'];
    _iosUrl = json['ios_url'];
    _forceUpdate = json['force_update'];
  }
  String? _v;
  String? _androidUrl;
  String? _iosUrl;
  num? _forceUpdate;
App copyWith({  String? v,
  String? androidUrl,
  String? iosUrl,
  num? forceUpdate,
}) => App(  v: v ?? _v,
  androidUrl: androidUrl ?? _androidUrl,
  iosUrl: iosUrl ?? _iosUrl,
  forceUpdate: forceUpdate ?? _forceUpdate,
);
  String? get v => _v;
  String? get androidUrl => _androidUrl;
  String? get iosUrl => _iosUrl;
  num? get forceUpdate => _forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = _v;
    map['android_url'] = _androidUrl;
    map['ios_url'] = _iosUrl;
    map['force_update'] = _forceUpdate;
    return map;
  }

}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      String? unit, 
      num? val,}){
    _unit = unit;
    _val = val;
}

  Location.fromJson(dynamic json) {
    _unit = json['unit'];
    _val = json['val'];
  }
  String? _unit;
  num? _val;
Location copyWith({  String? unit,
  num? val,
}) => Location(  unit: unit ?? _unit,
  val: val ?? _val,
);
  String? get unit => _unit;
  num? get val => _val;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = _unit;
    map['val'] = _val;
    return map;
  }

}