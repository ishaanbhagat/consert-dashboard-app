import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:grid_app/helpers/pateint_helper.dart';
import 'package:grid_app/main.dart';
import 'package:grid_app/models/blood_gases_data_model.dart';
import 'package:grid_app/models/expelled_fluids_data_model.dart';
import 'package:grid_app/models/graph_data_model.dart';
import 'package:grid_app/models/heart_data_model.dart';
import 'package:grid_app/models/patient_info_model.dart';
import 'package:grid_app/models/patient_model.dart';
import 'package:grid_app/models/respiratory_data_model.dart';
import 'package:grid_app/views/entry_view.dart';
import 'package:grid_app/views/patient_view.dart';
import 'package:intl/intl.dart';

import '../configuration/api_exceptions.dart';
import '../configuration/api_http_requests.dart';
import '../configuration/api_urls.dart';

class PatientController with ChangeNotifier {
  int _selectedScreenIndex = 0;

  int get selectedScreenIndex => _selectedScreenIndex;

  set selectedScreenIndex(int value) {
    _selectedScreenIndex = value;
    notifyListeners();
  }

  List<Widget> screens = [
    PatientView(),
    EntryView(),
  ];

  List<PatientModel> patientModel = [
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'One',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
    PatientModel(
        title: 'Two',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Third',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blue),
    PatientModel(
        title: 'Four',
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.purple),
  ];

  void updateTileSize(
    int index,
    int crossAxisCellCount,
    int mainAxisCellCount,
  ) {
    patientModel[index].crossAxisCellCount = crossAxisCellCount;
    patientModel[index].mainAxisCellCount = mainAxisCellCount;
    notifyListeners();
  }

  final GetIt locator = GetIt.instance;

  String _patientId = "0";

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  PatientInfoModel _patientInfoModel = PatientInfoModel();

  PatientInfoModel get patientInfoModel => _patientInfoModel;

  set patientInfoModel(PatientInfoModel value) {
    _patientInfoModel = value;
    notifyListeners();
  }

  Future<void> getPatientInfo(TextEditingController id,
      [bool canPop = false]) async {
    patientId = id.text;
    try {
      final response = await locator.get<DioClient>().get(
            ApiUrls.patientUrl + id.text,
          );
      Future.delayed(Duration.zero, () {
        if (canPop) {
          Navigator.of(navigatorKey.currentState!.context).pop();
        }
      });
      id.clear();
      patientInfoModel = PatientInfoModel();
      final listData = response.data as List<dynamic>;
      patientInfoModel = PatientInfoModel.fromJson(listData[0]);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        PateintHelper.showBottomText(title: 'Patient info not found');
      } else {
        ApiException.getMessage(e, false, true);
      }
    }
  }

  void update() {
    notifyListeners();
  }

  List<HeartDataModel> _heartDataModel = [];

  List<HeartDataModel> get heartDataModel => _heartDataModel;

  set heartDataModel(List<HeartDataModel> value) {
    _heartDataModel = value;
    notifyListeners();
  }

  bool _isHeartInfoLoading = true;

  bool get isHeartInfoLoading => _isHeartInfoLoading;

  set isHeartInfoLoading(bool value) {
    _isHeartInfoLoading = value;
    notifyListeners();
  }

  Future<void> getHeartInfo(String pid,
      [String? startTime, String? endTime]) async {
    // 2024-12-04 16:05:34
    heartDataModel = [];
    isHeartInfoLoading = true;
    try {
      final response = await locator
          .get<DioClient>()
          .get(ApiUrls.heartUrl + pid, queryParameters: {
        // 'pid': pid,
        'start_time': startTime,
        'end_time': endTime,
      });
      final listData = response.data as List<dynamic>;
      final List<HeartDataModel> toList =
          listData.map((data) => HeartDataModel.fromJson(data)).toList();
      heartDataModel = toList;
      isHeartInfoLoading = false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // PateintHelper.showBottomText(title: 'Patient info not found');
        isHeartInfoLoading = false;
      } else {
        ApiException.getMessage(e, false, false);
      }
    }
  }

  List<RespiratoryDataModel> _respiratoryDataModel = [];

  List<RespiratoryDataModel> get respiratoryDataModel => _respiratoryDataModel;

  set respiratoryDataModel(List<RespiratoryDataModel> value) {
    _respiratoryDataModel = value;
    notifyListeners();
  }

  bool _isRespiratoryInfoLoading = true;

  bool get isRespiratoryInfoLoading => _isRespiratoryInfoLoading;

  set isRespiratoryInfoLoading(bool value) {
    _isRespiratoryInfoLoading = value;
    notifyListeners();
  }

  Future<void> getRespiratoryInfo(String pid,
      [String? startTime, String? endTime]) async {
    // 2024-12-04 16:05:34
    respiratoryDataModel = [];
    isRespiratoryInfoLoading = true;
    try {
      final response = await locator
          .get<DioClient>()
          .get(ApiUrls.respiratoryUrl + pid, queryParameters: {
        // 'pid': pid,
        'start_time': startTime,
        'end_time': endTime,
      });
      final listData = response.data as List<dynamic>;
      final List<RespiratoryDataModel> toList =
          listData.map((data) => RespiratoryDataModel.fromJson(data)).toList();
      respiratoryDataModel = toList;
      isRespiratoryInfoLoading = false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // PateintHelper.showBottomText(title: 'Patient info not found');
        isRespiratoryInfoLoading = false;
      } else {
        ApiException.getMessage(e, false, false);
      }
    }
  }

  List<BloodGasesDataModel> _bloodGasesDataModel = [];

  List<BloodGasesDataModel> get bloodGasesDataModel => _bloodGasesDataModel;

  set bloodGasesDataModel(List<BloodGasesDataModel> value) {
    _bloodGasesDataModel = value;
    notifyListeners();
  }

  bool _isbloodGasesInfoLoading = true;

  bool get isbloodGasesInfoLoading => _isbloodGasesInfoLoading;

  set isbloodGasesInfoLoading(bool value) {
    _isbloodGasesInfoLoading = value;
    notifyListeners();
  }

  Future<void> getbloodGasesInfo(String pid,
      [String? startTime, String? endTime]) async {
    // 2024-12-04 16:05:34
    bloodGasesDataModel = [];
    isbloodGasesInfoLoading = true;
    try {
      final response = await locator
          .get<DioClient>()
          .get(ApiUrls.bloodGassesUrl + pid, queryParameters: {
        // 'pid': pid,
        'start_time': startTime,
        'end_time': endTime,
      });
      final listData = response.data as List<dynamic>;
      final List<BloodGasesDataModel> toList =
          listData.map((data) => BloodGasesDataModel.fromJson(data)).toList();
      bloodGasesDataModel = toList;
      isbloodGasesInfoLoading = false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // PateintHelper.showBottomText(title: 'Patient info not found');
        isbloodGasesInfoLoading = false;
      } else {
        ApiException.getMessage(e, false, false);
      }
    }
  }

  List<ExpelledFluidsDataModel> _expelledFluidsDataModel = [];

  List<ExpelledFluidsDataModel> get expelledFluidsDataModel =>
      _expelledFluidsDataModel;

  set expelledFluidsDataModel(List<ExpelledFluidsDataModel> value) {
    _expelledFluidsDataModel = value;
    notifyListeners();
  }

  bool _isexpelledFluidsInfoLoading = true;

  bool get isexpelledFluidsInfoLoading => _isexpelledFluidsInfoLoading;

  set isexpelledFluidsInfoLoading(bool value) {
    _isexpelledFluidsInfoLoading = value;
    notifyListeners();
  }

  Future<void> getexpelledFluidsInfo(String pid,
      [String? startTime, String? endTime]) async {
    // 2024-12-04 16:05:34
    expelledFluidsDataModel = [];
    isexpelledFluidsInfoLoading = true;
    try {
      final response = await locator
          .get<DioClient>()
          .get(ApiUrls.expelledFluidsUrl + pid, queryParameters: {
        // 'pid': pid,
        'start_time': startTime,
        'end_time': endTime,
      });
      final listData = response.data as List<dynamic>;
      final List<ExpelledFluidsDataModel> toList = listData
          .map((data) => ExpelledFluidsDataModel.fromJson(data))
          .toList();
      expelledFluidsDataModel = toList;
      isexpelledFluidsInfoLoading = false;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // PateintHelper.showBottomText(title: 'Patient info not found');
        isexpelledFluidsInfoLoading = false;
      } else {
        ApiException.getMessage(e, false, false);
      }
    }
  }

  List<GraphDataModel> _graphDataModel = [];

  List<GraphDataModel> get graphDataModel => _graphDataModel;

  set graphDataModel(List<GraphDataModel> value) {
    _graphDataModel = value;
    notifyListeners();
  }

  bool _isGraphsInfoLoading = true;

  bool get isGraphsInfoLoading => _isGraphsInfoLoading;

  set isGraphsInfoLoading(bool value) {
    _isGraphsInfoLoading = value;
    notifyListeners();
  }

  Future<void> getGraphInfo(String pid,
      [bool showLoader = false, String? startTime, String? endTime]) async {
    // 2024-12-04 16:05:34
    graphDataModel = [];
    isGraphsInfoLoading = true;
    if (showLoader) {
      PateintHelper.showLoader();
    }
    try {
      final response = await locator
          .get<DioClient>()
          .get(ApiUrls.graphDataUrl + pid, queryParameters: {
        'start_time': startTime,
        'end_time': endTime,
      });
      final listData = response.data as List<dynamic>;
      // final List<GraphDataModel> toList =
      //     listData.map((data) => GraphDataModel.fromJson(data)).toList();

      // final List<GraphDataModel> toList = listData.where((data) {
      //   // Check if datetime is valid before processing
      //   String datetimeString = data["datetime"];
      //   return isValidDateTime(datetimeString);
      // }).map((data) {
      //   // Parse the datetime string to a DateTime object
      //   String datetimeString = data["datetime"];
      //   DateTime dateTime =
      //       DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetimeString);

      //   // Format the time portion to "h a" (e.g., "4 PM")
      //   String formattedTime = DateFormat('h a').format(dateTime);

      //   // Create a GraphDataModel instance with formatted time
      //   var model = GraphDataModel.fromJson(data);
      //   return model.copyWith(timeGroup: formattedTime);
      // }).toList();

//       final List<GraphDataModel> toList = listData.where((data) {
//         // Check if datetime is valid before processing
//         String datetimeString = data["datetime"];
//         return isValidDateTime(datetimeString);
//       }).map((data) {
//         // Parse the datetime string to a DateTime object
//         String datetimeString = data["datetime"];
//         DateTime dateTime =
//             DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetimeString);

//         // Format the time portion to "h a" (e.g., "4 PM")
//         String formattedTime = DateFormat('h a').format(dateTime);

//         // Create a GraphDataModel instance with formatted time
//         var model = GraphDataModel.fromJson(data);
//         return model.copyWith(timeGroup: formattedTime);
//       }).toList();

// // Sort the list in ascending order of time
//       toList.sort((a, b) {
//         DateTime timeA = DateFormat('h a').parse(a.timeGroup!);
//         DateTime timeB = DateFormat('h a').parse(b.timeGroup!);
//         return timeA.compareTo(timeB);
//       });

      final List<GraphDataModel> toList = listData.where((data) {
        // Check if datetime is valid before processing
        String datetimeString = data["datetime"];
        return isValidDateTime(datetimeString);
      }).map((data) {
        // Parse the datetime string to a DateTime object
        String datetimeString = data["datetime"];
        DateTime dateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(datetimeString);

        // Format the time portion to "h a" (e.g., "4 PM")
        String formattedTime = DateFormat('h a').format(dateTime);

        // Create a GraphDataModel instance with original datetime string and formatted time
        var model = GraphDataModel.fromJson(data);
        return model.copyWith(
          datetime: datetimeString, // Retain original datetime as string
          timeGroup: formattedTime,
        );
      }).toList();

// Sort the list in ascending order of original datetime
      toList.sort((a, b) {
        DateTime dateTimeA =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(a.datetime!);
        DateTime dateTimeB =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(b.datetime!);
        return dateTimeA.compareTo(dateTimeB);
      });

      if (showLoader) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(navigatorKey.currentState!.context);
        });
      }

      graphDataModel = toList;
      isGraphsInfoLoading = false;
    } on DioException catch (e) {
      if (showLoader) {
        if (e.response?.statusCode == 404) {
          PateintHelper.showBottomText(title: 'Patient info not found');
          Future.delayed(Duration.zero, () {
            Navigator.pop(navigatorKey.currentState!.context);
          });
          isGraphsInfoLoading = false;
        } else {
          ApiException.getMessage(e, true, true);
        }
      } else {
        if (e.response?.statusCode == 404) {
          // PateintHelper.showBottomText(title: 'Patient info not found');
          isGraphsInfoLoading = false;
        } else {
          ApiException.getMessage(e, false, false);
        }
      }
    }
  }

  Future<void> postPatientInfo({
    required String patientId,
    required String firstName,
    required String lastName,
    required String age,
    required String height,
    required String weight,
    required String diagnosis,
    required String doNotAdminister,
    required String bloodType,
    required String dateOfEntry,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.patientUrl,
        data: {
          "id": patientId,
          "first_name": firstName,
          "last_name": lastName,
          "age": age,
          "height": height,
          "weight": weight,
          "diagnosis": diagnosis,
          "do_not_administer": doNotAdminister,
          "blood_type": bloodType,
          "date_of_entry": dateOfEntry,
          "apacheii": 0,
          "iss": 0,
          "ts": 0,
          "gcs": 0
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(title: 'Patient Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }

  Future<void> postGraphInfo({
    required String patientId,
    required String datetime,
    required String temperature,
    required String bloodPressure,
    required String bloodOxygen,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.postgraphDataUrl,
        data: {
          "id": patientId,
          "datetime": '$datetime:00',
          "temperature": temperature,
          "bloodPressure": bloodPressure,
          "bloodOxygen": bloodOxygen,
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(title: 'Graph Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }

  Future<void> postHeartInfo({
    required String patientId,
    required String datetime,
    required String cVP,
    required String pAP,
    required String pWP,
    required String cO,
    required String iCP,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.postheartUrl,
        data: {
          "id": patientId,
          "datetime": '$datetime:00',
          "CVP": cVP,
          "PAP": pAP,
          "PWP": pWP,
          "CO": cO,
          "ICP": iCP,
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(title: 'Heart Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }

  Future<void> postRespiratoryInfo({
    required String patientId,
    required String datetime,
    required String respirationType,
    required String vT,
    required String rr,
    required String pEEP,
    required String fiO2,
    required String maskO2,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.postrespiratoryUrl,
        data: {
          "id": patientId,
          "datetime": '$datetime:00',
          "respiration_type": respirationType,
          "VT": vT,
          "RR": rr,
          "PEEP": pEEP,
          "FiO2": fiO2,
          "maskO2": maskO2,
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(
          title: 'Respiratory Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }

  Future<void> postBloodGasesInfo({
    required String patientId,
    required String datetime,
    required String pH,
    required String paO2,
    required String paCO2,
    required String hCO3,
    required String satO2,
    required String bE,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.postbloodGassesUrl,
        data: {
          "id": patientId,
          "datetime": '$datetime:00',
          "pH": pH,
          "PaO2": paO2,
          "PaCO2": paCO2,
          "HCO3": hCO3,
          "SatO2": satO2,
          "BE": bE,
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(
          title: 'Blood Gases Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }

  Future<void> postExpelledFluidsInfo({
    required String patientId,
    required String datetime,
    required String urine,
    required String levin,
    required String paroxeteushA,
    required String paroxeteushB,
    required String lostFluidSum,
    required VoidCallback callBack,
  }) async {
    PateintHelper.showLoader();
    try {
      await locator.get<DioClient>().post(
        ApiUrls.postexpelledFluidsUrl,
        data: {
          "id": patientId,
          "datetime": '$datetime:00',
          "urine": urine,
          "levin": levin,
          "paroxeteushA": paroxeteushA,
          "paroxeteushB": paroxeteushB,
          "lost_fluid_sum": lostFluidSum,
        },
      );
      callBack();
      Future.delayed(Duration.zero, () {
        Navigator.of(navigatorKey.currentState!.context).pop();
      });
      PateintHelper.showBottomText(
          title: 'Expelled Fluids Info Saved Successfully');
    } on DioException catch (e) {
      // if (e.response?.statusCode == 404) {
      //   // PateintHelper.showBottomText(title: 'Patient info not found');
      //   isGraphsInfoLoading = false;
      // } else {
      ApiException.getMessage(e);
      // }
    }
  }
}
