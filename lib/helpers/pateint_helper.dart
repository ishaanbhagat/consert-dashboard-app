import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/extensions/shared_extensions.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/patient_controller.dart';
import '../main.dart';

class PateintHelper {
  static void showPatientInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<PatientController>(builder: (context, consumer, _) {
          final data = consumer.patientInfoModel;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: context.isT ? 30.w : 10.w,
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Information',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc233ff), // Purple color
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 250.h,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Full Name', '${data.firstName} ${data.lastName}',
                              Color(0xff6ce797)), // Green color
                          // _buildInfoRow('Last Name', data.lastName ?? '',
                          //     Color(0xff81cef7)), // Light Blue color
                          _buildInfoRow('Age', data.age.toString(),
                              Color(0xffe2a2ff)), // Light Purple color
                          _buildInfoRow('Height', data.height ?? '',
                              Color(0xff22d360)), // Dark Green color
                          _buildInfoRow('Weight', data.weight ?? '',
                              Color(0xff0d8ed3)), // Blue color
                          _buildInfoRow('Diagnosis', data.diagnosis ?? '',
                              Color(0xffc233ff)), // Purple color
                          _buildInfoRow(
                              'Do Not Administer',
                              data.doNotAdminister ?? '',
                              Color(0xff6ce797)), // Green color
                          _buildInfoRow('Blood Type', data.bloodType ?? '',
                              Color(0xff81cef7)), // Light Blue color
                          _buildInfoRow('Date of Entry', data.dateOfEntry ?? '',
                              Color(0xffe2a2ff)), // Light Purple color
                          _buildInfoRow('Apache II', data.apacheii.toString(),
                              Color(0xff22d360)), // Dark Green color
                          _buildInfoRow('ISS', data.iss.toString(),
                              Color(0xff0d8ed3)), // Blue color
                          _buildInfoRow('TS', data.ts.toString(),
                              Color(0xffc233ff)), // Purple color
                          _buildInfoRow('GCS', data.gcs.toString(),
                              Color(0xff6ce797)), // Green color
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  static Widget _buildInfoRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  static void showChangePatientDialog(BuildContext context,
      TextEditingController patientTextEditingController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Type New Patient Id',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: patientTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: 'ID',
                    hintStyle: TextStyle(color: Color(0xff81cef7)),
                  ),
                ),
                SizedBox(height: 16.sp),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    if (patientTextEditingController.text.isEmpty) {
                      showBottomText(
                        title: 'Please type patient id',
                      );
                      return;
                    }
                    context
                        .read<PatientController>()
                        .getPatientInfo(patientTextEditingController, true);
                    String formattedDateTime =
                        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
                    print('Current DateTime: $formattedDateTime');

                    DateTime parsedDateTime =
                        DateFormat('yyyy-MM-dd HH:mm').parse(formattedDateTime);

                    DateTime newDateTime =
                        parsedDateTime.subtract(Duration(hours: 24));

                    String newFormattedDateTime =
                        DateFormat('yyyy-MM-dd HH:mm').format(newDateTime);
                    print('DateTime 6 hours earlier: $newFormattedDateTime');

                    context.read<PatientController>().getGraphInfo(
                          '0',
                          false,
                          '$formattedDateTime:00',
                        );
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showTileSizeOptionsDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: context.isT ? 50.w : 0,
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Tile Size',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffc233ff), // Purple color
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<PatientController>()
                              .updateTileSize(index, 1, 1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff0d8ed3), // Blue color
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '1 x 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<PatientController>()
                              .updateTileSize(index, 1, 2);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff6ce797), // Green color
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '1 x 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<PatientController>()
                              .updateTileSize(index, 3, 3);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff22d360), // Dark Green color
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '3 x 3',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showTileOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: context.isT ? 50.w : 0,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Options',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffc233ff), // Purple color
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        showTileSizeOptionsDialog(context, index);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.swap_horizontal_circle_sharp,
                            color: Color(0xff0d8ed3), // Blue color
                            size: 36,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Resize',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff0d8ed3), // Blue color
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        showPatientInfo(context);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Color(0xff6ce797), // Green color
                            size: 36,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xff6ce797), // Green color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void enteryForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  static Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      return DateFormat('yyyy-MM-dd').format(picked);
    } else {
      return null;
    }
  }

  // static Future<String?> selectTime(BuildContext context, [String? date]) async {
  //   TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     initialEntryMode: TimePickerEntryMode.dialOnly,
  //     builder: (BuildContext context, Widget? child) {
  //       // Customize the appearance of the time picker
  //       return Theme(
  //         data: ThemeData.light(),
  //         child: child!,
  //       );
  //     },
  //   );
  //   // String formattedTime = '${picked?.hour}:${picked?.minute.toString().padLeft(2, '0')}:00';
  //   if (picked != null) {
  //     // Convert TimeOfDay to DateTime for comparison
  //     DateTime now = DateTime.now();
  //     DateTime selectedDateTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       picked.hour,
  //       picked.minute,
  //     );

  //     // Check if the selected time is in the future
  //     if (selectedDateTime.isAfter(now)) {
  //       showBottomText(title: 'Selected time is in the future');
  //       return null; // Return null if the selected time is in the future
  //     }

  //     return DateFormat('HH:mm:ss').format(selectedDateTime);

  //     // Format the selected time
  //     // String formattedTime =
  //     //     '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}:00';
  //     // return formattedTime;
  //   } else {
  //     // Handle cancellation or no selection
  //     return null;
  //   }
  // }

  static Future<String?> selectTime(BuildContext context,
      [String? date]) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        // Customize the appearance of the time picker
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Convert TimeOfDay to DateTime
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      // If a date is passed, parse the passed date
      if (date!.isNotEmpty) {
        DateTime parsedDate = DateTime.parse(date);

        // Check if the passed date is the current date
        if (parsedDate.year == now.year &&
            parsedDate.month == now.month &&
            parsedDate.day == now.day) {
          // If the date is the current date, check if the selected time is in the future
          if (selectedDateTime.isAfter(now)) {
            showBottomText(title: 'Selected time is in the future');
            return null; // Return null if the selected time is in the future
          }
        }
      } else {
        // Check if the selected time is in the future
        if (selectedDateTime.isAfter(now)) {
          showBottomText(title: 'Selected time is in the future');
          return null; // Return null if the selected time is in the future
        }

        // return DateFormat('HH:mm:ss').format(selectedDateTime);
      }

      return DateFormat('HH:mm').format(selectedDateTime);
    } else {
      // Handle cancellation or no selection
      return null;
    }
  }

  static void showBottomText({
    required String title,
  }) {
    BotToast.showText(
      text: title,
    );

    // cancel(); //close
  }

  static void showLoader() {
    showDialog(
      context: navigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black87,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }

  static void showBlankPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            height: 200.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  static String formatDateTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate =
          DateFormat('d MMMM, yyyy hh:mm a').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }
}
