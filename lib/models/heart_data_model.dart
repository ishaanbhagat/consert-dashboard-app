
class HeartDataModel {
  String? id;
  int? idd;
  String? datetime;
  int? cvp;
  int? pap;
  int? pwp;
  int? co;
  int? icp;

  HeartDataModel({this.id, this.idd, this.datetime, this.cvp, this.pap, this.pwp, this.co, this.icp});

  HeartDataModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["id"] is int) {
      idd = json["id"];
    }
    if(json["datetime"] is String) {
      datetime = json["datetime"];
    }
    if(json["CVP"] is int) {
      cvp = json["CVP"];
    }
    if(json["PAP"] is int) {
      pap = json["PAP"];
    }
    if(json["PWP"] is int) {
      pwp = json["PWP"];
    }
    if(json["CO"] is int) {
      co = json["CO"];
    }
    if(json["ICP"] is int) {
      icp = json["ICP"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["id"] = idd;
    _data["datetime"] = datetime;
    _data["CVP"] = cvp;
    _data["PAP"] = pap;
    _data["PWP"] = pwp;
    _data["CO"] = co;
    _data["ICP"] = icp;
    return _data;
  }
}