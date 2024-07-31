
class ExpelledFluidsDataModel {
  String? id;
  int? idd;
  String? datetime;
  int? urine;
  int? levin;
  int? paroxeteushA;
  int? paroxeteushB;
  int? lostFluidSum;

  ExpelledFluidsDataModel({this.id, this.idd, this.datetime, this.urine, this.levin, this.paroxeteushA, this.paroxeteushB, this.lostFluidSum});

  ExpelledFluidsDataModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["id"] is int) {
      idd = json["id"];
    }
    if(json["datetime"] is String) {
      datetime = json["datetime"];
    }
    if(json["urine"] is int) {
      urine = json["urine"];
    }
    if(json["levin"] is int) {
      levin = json["levin"];
    }
    if(json["paroxeteushA"] is int) {
      paroxeteushA = json["paroxeteushA"];
    }
    if(json["paroxeteushB"] is int) {
      paroxeteushB = json["paroxeteushB"];
    }
    if(json["lost_fluid_sum"] is int) {
      lostFluidSum = json["lost_fluid_sum"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["id"] = idd;
    _data["datetime"] = datetime;
    _data["urine"] = urine;
    _data["levin"] = levin;
    _data["paroxeteushA"] = paroxeteushA;
    _data["paroxeteushB"] = paroxeteushB;
    _data["lost_fluid_sum"] = lostFluidSum;
    return _data;
  }
}