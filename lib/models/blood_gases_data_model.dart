
class BloodGasesDataModel {
  String? id;
  int? idd;
  String? datetime;
  int? pH;
  int? paO2;
  int? paCo2;
  int? hco3;
  int? satO2;
  int? be;

  BloodGasesDataModel({this.id, this.idd, this.datetime, this.pH, this.paO2, this.paCo2, this.hco3, this.satO2, this.be});

  BloodGasesDataModel.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["id"] is int) {
      idd = json["id"];
    }
    if(json["datetime"] is String) {
      datetime = json["datetime"];
    }
    if(json["pH"] is int) {
      pH = json["pH"];
    }
    if(json["PaO2"] is int) {
      paO2 = json["PaO2"];
    }
    if(json["PaCO2"] is int) {
      paCo2 = json["PaCO2"];
    }
    if(json["HCO3"] is int) {
      hco3 = json["HCO3"];
    }
    if(json["SatO2"] is int) {
      satO2 = json["SatO2"];
    }
    if(json["BE"] is int) {
      be = json["BE"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["id"] = idd;
    _data["datetime"] = datetime;
    _data["pH"] = pH;
    _data["PaO2"] = paO2;
    _data["PaCO2"] = paCo2;
    _data["HCO3"] = hco3;
    _data["SatO2"] = satO2;
    _data["BE"] = be;
    return _data;
  }
}