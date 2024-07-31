import 'package:intl/intl.dart';

class GraphDataModel {
  String? id;
  int? idd;
  String? datetime;
  double? temperature;
  double? bloodPressure;
  double? bloodOxygen;
  String? timeGroup;

  GraphDataModel(
      {this.id,
      this.idd,
      this.datetime,
      this.temperature,
      this.bloodPressure,
      this.bloodOxygen,
      this.timeGroup});

  GraphDataModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["id"] is int) {
      idd = json["id"];
    }
    // if (json["datetime"] is String) {
    //   datetime = json["datetime"];
    // }
    if (json["datetime"] is String) {
      // Validate if the datetime string is valid
      String datetimeString = json["datetime"];
      if (isValidDateTime(datetimeString)) {
        datetime = datetimeString;
      } else {
        datetime = null;
      }
    }
    if (json["temperature"] is double) {
      temperature = json["temperature"];
    }
    if (json["bloodPressure"] is double) {
      bloodPressure = json["bloodPressure"];
    }
    if (json["bloodOxygen"] is double) {
      bloodOxygen = json["bloodOxygen"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["id"] = id;
    _data["datetime"] = datetime;
    _data["temperature"] = temperature;
    _data["bloodPressure"] = bloodPressure;
    _data["bloodOxygen"] = bloodOxygen;
    return _data;
  }

  GraphDataModel copyWith({
    String? id,
    int? idd,
    String? datetime,
    double? temperature,
    double? bloodPressure,
    double? bloodOxygen,
    String? timeGroup, // Include the new field
  }) {
    return GraphDataModel(
      id: id ?? this.id,
      idd: idd ?? this.idd,
      datetime: datetime ?? this.datetime,
      temperature: temperature ?? this.temperature,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      bloodOxygen: bloodOxygen ?? this.bloodOxygen,
      timeGroup: timeGroup ?? this.timeGroup, // Handle the new field
    );
  }
}

bool isValidDateTime(String datetimeString) {
  try {
    // Try to parse the datetime string with the expected format
    DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetimeString);
    return true;
  } catch (e) {
    // If parsing fails, it means the datetime string is invalid
    return false;
  }
}
