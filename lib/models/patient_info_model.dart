
class PatientInfoModel {
  String? idunder;
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? height;
  String? weight;
  String? diagnosis;
  String? doNotAdminister;
  String? bloodType;
  String? dateOfEntry;
  int? apacheii;
  int? iss;
  int? ts;
  int? gcs;

  PatientInfoModel({this.idunder, this.id, this.firstName, this.lastName, this.age, this.height, this.weight, this.diagnosis, this.doNotAdminister, this.bloodType, this.dateOfEntry, this.apacheii, this.iss, this.ts, this.gcs});

  PatientInfoModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      idunder = json["_id"];
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["age"] is int) {
      age = json["age"];
    }
    if(json["height"] is String) {
      height = json["height"];
    }
    if(json["weight"] is String) {
      weight = json["weight"];
    }
    if(json["diagnosis"] is String) {
      diagnosis = json["diagnosis"];
    }
    if(json["do_not_administer"] is String) {
      doNotAdminister = json["do_not_administer"];
    }
    if(json["blood_type"] is String) {
      bloodType = json["blood_type"];
    }
    if(json["date_of_entry"] is String) {
      dateOfEntry = json["date_of_entry"];
    }
    if(json["apacheii"] is int) {
      apacheii = json["apacheii"];
    }
    if(json["iss"] is int) {
      iss = json["iss"];
    }
    if(json["ts"] is int) {
      ts = json["ts"];
    }
    if(json["gcs"] is int) {
      gcs = json["gcs"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = idunder;
    _data["id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["age"] = age;
    _data["height"] = height;
    _data["weight"] = weight;
    _data["diagnosis"] = diagnosis;
    _data["do_not_administer"] = doNotAdminister;
    _data["blood_type"] = bloodType;
    _data["date_of_entry"] = dateOfEntry;
    _data["apacheii"] = apacheii;
    _data["iss"] = iss;
    _data["ts"] = ts;
    _data["gcs"] = gcs;
    return _data;
  }
}