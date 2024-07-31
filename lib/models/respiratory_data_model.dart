
class RespiratoryDataModel {
  String? id;
  int? idd;
  String? datetime;
  String? respirationType;
  int? vt;
  int? rr;
  int? peep;
  int? fiO2;
  String? maskO2;

  RespiratoryDataModel({this.id, this.idd, this.datetime, this.respirationType, this.vt, this.rr, this.peep, this.fiO2, this.maskO2});

  RespiratoryDataModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["id"] is int) {
      idd = json["id"];
    }
    if(json["datetime"] is String) {
      datetime = json["datetime"];
    }
    if(json["respiration_type"] is String) {
      respirationType = json["respiration_type"];
    }
    if(json["VT"] is int) {
      vt = json["VT"];
    }
    if(json["RR"] is int) {
      rr = json["RR"];
    }
    if(json["PEEP"] is int) {
      peep = json["PEEP"];
    }
    if(json["FiO2"] is int) {
      fiO2 = json["FiO2"];
    }
    if(json["maskO2"] is String) {
      maskO2 = json["maskO2"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["id"] = id;
    _data["datetime"] = datetime;
    _data["respiration_type"] = respirationType;
    _data["VT"] = vt;
    _data["RR"] = rr;
    _data["PEEP"] = peep;
    _data["FiO2"] = fiO2;
    _data["maskO2"] = maskO2;
    return _data;
  }
}