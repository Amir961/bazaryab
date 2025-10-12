import 'dart:convert';
Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());
class Customer {
  Customer({
      num? id, 
      String? ownerName, 
      String? ownerNationalId, 
      String? position, 
      String? inChargeName, 
      String? inChargeMobile, 
      String? industry, 
      String? city, 
      String? address, 
      String? phone, 
      String? description, 
      String? contactType, 
      String? visitP, 
      String? visit, 
      String? result, 
      dynamic lastFollowupP, 
      dynamic lastFollowup, 
      String? type, 
      List<dynamic>? images,}){
    _id = id;
    _ownerName = ownerName;
    _ownerNationalId = ownerNationalId;
    _position = position;
    _inChargeName = inChargeName;
    _inChargeMobile = inChargeMobile;
    _industry = industry;
    _city = city;
    _address = address;
    _phone = phone;
    _description = description;
    _contactType = contactType;
    _visitP = visitP;
    _visit = visit;
    _result = result;
    _lastFollowupP = lastFollowupP;
    _lastFollowup = lastFollowup;
    _type = type;
    _images = images;
}

  Customer.fromJson(dynamic json) {
    _id = json['id'];
    _ownerName = json['owner_name'];
    _ownerNationalId = json['owner_national_id'];
    _position = json['position'];
    _inChargeName = json['in_charge_name'];
    _inChargeMobile = json['in_charge_mobile'];
    _industry = json['industry'];
    _city = json['city'];
    _address = json['address'];
    _phone = json['phone'];
    _description = json['description'];
    _contactType = json['contact_type'];
    _visitP = json['visit_p'];
    _visit = json['visit'];
    _result = json['result'];
    _lastFollowupP = json['last_followup_p'];
    _lastFollowup = json['last_followup'];
    _type = json['type'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
       // _images?.add(Dynamic.fromJson(v));
      });
    }
  }
  num? _id;
  String? _ownerName;
  String? _ownerNationalId;
  String? _position;
  String? _inChargeName;
  String? _inChargeMobile;
  String? _industry;
  String? _city;
  String? _address;
  String? _phone;
  String? _description;
  String? _contactType;
  String? _visitP;
  String? _visit;
  String? _result;
  dynamic _lastFollowupP;
  dynamic _lastFollowup;
  String? _type;
  List<dynamic>? _images;
Customer copyWith({  num? id,
  String? ownerName,
  String? ownerNationalId,
  String? position,
  String? inChargeName,
  String? inChargeMobile,
  String? industry,
  String? city,
  String? address,
  String? phone,
  String? description,
  String? contactType,
  String? visitP,
  String? visit,
  String? result,
  dynamic lastFollowupP,
  dynamic lastFollowup,
  String? type,
  List<dynamic>? images,
}) => Customer(  id: id ?? _id,
  ownerName: ownerName ?? _ownerName,
  ownerNationalId: ownerNationalId ?? _ownerNationalId,
  position: position ?? _position,
  inChargeName: inChargeName ?? _inChargeName,
  inChargeMobile: inChargeMobile ?? _inChargeMobile,
  industry: industry ?? _industry,
  city: city ?? _city,
  address: address ?? _address,
  phone: phone ?? _phone,
  description: description ?? _description,
  contactType: contactType ?? _contactType,
  visitP: visitP ?? _visitP,
  visit: visit ?? _visit,
  result: result ?? _result,
  lastFollowupP: lastFollowupP ?? _lastFollowupP,
  lastFollowup: lastFollowup ?? _lastFollowup,
  type: type ?? _type,
  images: images ?? _images,
);
  num? get id => _id;
  String? get ownerName => _ownerName;
  String? get ownerNationalId => _ownerNationalId;
  String? get position => _position;
  String? get inChargeName => _inChargeName;
  String? get inChargeMobile => _inChargeMobile;
  String? get industry => _industry;
  String? get city => _city;
  String? get address => _address;
  String? get phone => _phone;
  String? get description => _description;
  String? get contactType => _contactType;
  String? get visitP => _visitP;
  String? get visit => _visit;
  String? get result => _result;
  dynamic get lastFollowupP => _lastFollowupP;
  dynamic get lastFollowup => _lastFollowup;
  String? get type => _type;
  List<dynamic>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['owner_name'] = _ownerName;
    map['owner_national_id'] = _ownerNationalId;
    map['position'] = _position;
    map['in_charge_name'] = _inChargeName;
    map['in_charge_mobile'] = _inChargeMobile;
    map['industry'] = _industry;
    map['city'] = _city;
    map['address'] = _address;
    map['phone'] = _phone;
    map['description'] = _description;
    map['contact_type'] = _contactType;
    map['visit_p'] = _visitP;
    map['visit'] = _visit;
    map['result'] = _result;
    map['last_followup_p'] = _lastFollowupP;
    map['last_followup'] = _lastFollowup;
    map['type'] = _type;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}