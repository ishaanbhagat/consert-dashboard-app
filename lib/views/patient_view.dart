import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:grid_app/extensions/shared_extensions.dart';
import 'package:grid_app/helpers/pateint_helper.dart';
import 'package:grid_app/views/bloodgases_info_view.dart';
import 'package:grid_app/views/heart_info_view.dart';
import 'package:grid_app/views/notes_view.dart';
import 'package:grid_app/views/respiratory_info_view.dart';
import 'package:grid_app/widgets/beautiful_container_widget.dart';
import 'package:grid_app/widgets/text_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/stacked_graph_widget.dart';
import 'expelled_fluids_info_view.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  final currentDateTime = DateTime.now();

  TextEditingController pateintTextEditingController = TextEditingController();

  List<Offset?> points = [];

  Uint8List? loadedImageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageString = prefs.getString('image');
    if (imageString != null) {
      Uint8List imageBytes = base64Decode(imageString);
      print(imageBytes);
      setState(() {
        loadedImageBytes = imageBytes;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    pateintTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(context.isM.toString());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Consumer<PatientController>(builder: (context, consumer, _) {
              return consumer.patientInfoModel.id == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: LinearProgressIndicator()),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today Date',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0d8ed3), // Blue color
                                ),
                              ),
                              Text(
                                DateFormat('d MMMM, yyyy')
                                    .format(currentDateTime),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xff0d8ed3), // Blue color
                                ),
                              ),
                            ],
                          ),
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(
                          //     maxHeight: 50,
                          //   ),
                          //   child: CustomPaint(
                          //     painter: MyPainter(points),
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Latest Log Date',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0d8ed3), // Blue color
                                ),
                              ),
                              Text(
                                context
                                        .read<PatientController>()
                                        .patientInfoModel
                                        .dateOfEntry ??
                                    '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xff0d8ed3), // Blue color
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            minVerticalPadding: 0,
                            visualDensity: VisualDensity.compact,
                            dense: true,
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Patient Name:',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffc233ff), // Purple color
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '${context
                                          .read<PatientController>()
                                          .patientInfoModel
                                          .firstName} ${context.read<PatientController>().patientInfoModel.lastName}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    // fontWeight: FontWeight.bold,
                                    // color: Color(0xffc233ff), // Purple color
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () =>
                                        PateintHelper.showPatientInfo(context),
                                    child: Icon(Icons.person,
                                        color: Color(
                                            0xff81cef7))), // Light Blue color
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(
                                    onTap: () =>
                                        PateintHelper.showChangePatientDialog(
                                            context,
                                            pateintTextEditingController),
                                    child: Icon(Icons.edit,
                                        color:
                                            Color(0xff6ce797))), // Green color
                              ],
                            ),
                          ),
                          StackedLineChart(),
                          SizedBox(height: 26.h),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final res = await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => NotesView(),
                                      ));
                                      print(res);
                                      if (res == null) {
                                        Future.delayed(Duration(seconds: 1), (){
                                        _loadImage();

                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 150.w,
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Colors.black12,
                                      )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.yellow,
                                            width: double.maxFinite,
                                            child: Text(
                                              'Notes',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 0,
                                          ),
                                          Spacer(),
                                          if (loadedImageBytes != null)
                                            Image.memory(
                                              loadedImageBytes!,
                                              width: 300.w,
                                              // height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          // TextWidget(
                                          //   'Click To View',
                                          //   fontWeight: FontWeight.bold,
                                          //   bodyLage: true,
                                          // ),
                                          Spacer(),

                                          // CustomPaint(
                                          //   painter: MyPainter(points),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BeautifulContainer(
                                        title: 'Heart Info',
                                        onTap: () {
                                          DateTime now = DateTime.now();
                                          String formattedDateTime =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(now);
                                          consumer.getHeartInfo(
                                            consumer.patientId,
                                            // formattedDateTime,
                                            // formattedDateTime
                                          );
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                HeartInfoView(),
                                          ));
                                        },
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      BeautifulContainer(
                                        title: 'Respiratory Info',
                                        onTap: () {
                                          DateTime now = DateTime.now();
                                          String formattedDateTime =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(now);
                                          consumer.getRespiratoryInfo(
                                            consumer.patientId,
                                            // formattedDateTime,
                                            // formattedDateTime
                                          );
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                RespiratoryInfoView(),
                                          ));
                                        },
                                        backgroundColor: Colors.lightBlue,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BeautifulContainer(
                                        title: 'Blood Gases Info',
                                        onTap: () {
                                          DateTime now = DateTime.now();
                                          String formattedDateTime =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(now);
                                          consumer.getbloodGasesInfo(
                                            consumer.patientId,
                                            // formattedDateTime,
                                            // formattedDateTime,
                                          );
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                BloodGasesInfoView(),
                                          ));
                                        },
                                        backgroundColor: Colors.lightBlue,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      BeautifulContainer(
                                        title: 'Expelled Fluids Info',
                                        onTap: () {
                                          DateTime now = DateTime.now();
                                          String formattedDateTime =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(now);
                                          consumer.getexpelledFluidsInfo(
                                            consumer.patientId,
                                            // formattedDateTime,
                                            // formattedDateTime,
                                          );
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ExpelledFluidsInfoView(),
                                          ));
                                        },
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6ce797),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                onPressed: () =>
                                    PateintHelper.showBlankPopup(context),
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.white70,
                                ),
                                label: Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff81cef7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                onPressed: () =>
                                    PateintHelper.showBlankPopup(context),
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.white70,
                                ),
                                label: Text(
                                  'Other Info',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10.h,
                          ),

                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: StaggeredGrid.count(
                          //       crossAxisCount: 4,
                          //       mainAxisSpacing: 8,
                          //       crossAxisSpacing: 8,
                          //       children: List.generate(
                          //         consumer.patientModel.length,
                          //         (index) {
                          //           final data = consumer.patientModel[index];
                          //           return StaggeredGridTile.count(
                          //             crossAxisCellCount: data.crossAxisCellCount,
                          //             mainAxisCellCount: data.mainAxisCellCount,
                          //             child: GestureDetector(
                          //               onTap: () => PateintHelper.showTileOptionsDialog(context, index),
                          //               child: Container(
                          //                 decoration: BoxDecoration(
                          //                   color: _getTileColor(index),
                          //                   borderRadius: BorderRadius.circular(12),
                          //                   boxShadow: [
                          //                     BoxShadow(
                          //                       color: Colors.black12,
                          //                       blurRadius: 4,
                          //                       offset: Offset(2, 2),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 alignment: Alignment.center,
                          //                 padding: EdgeInsets.all(8),
                          //                 child: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.center,
                          //                   children: [

                          //                     SizedBox(height: 5.h,),
                          //                     if (index == 11 && context.isT) LineChartSample2(),
                          //                     Text(
                          //                       data.title,
                          //                       textAlign: TextAlign.center,
                          //                       style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 16.sp,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }

  Color _getTileColor(int index) {
    switch (index % 7) {
      case 0:
        return Color.fromARGB(255, 192, 175, 175); // White
      case 1:
        return Color(0xff6ce797); // Green
      case 2:
        return Color(0xff81cef7); // Light Blue
      case 3:
        return Color(0xffe2a2ff); // Light Purple
      case 4:
        return Color(0xff22d360); // Dark Green
      case 5:
        return Color(0xff0d8ed3); // Blue
      case 6:
        return Color(0xffc233ff); // Purple
      default:
        return Color(0xffffffff); // Fallback to white
    }
  }
}
