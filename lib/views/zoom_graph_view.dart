import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../helpers/pateint_helper.dart';
import '../models/graph_data_model.dart';
import '../models/sample_view.dart';
import '../widgets/dropdown_menu_widget.dart';

class ZoomGraphView extends StatefulWidget {
  const ZoomGraphView({super.key});

  @override
  State<ZoomGraphView> createState() => _ZoomGraphViewState();
}

class _ZoomGraphViewState extends State<ZoomGraphView> {
  // List<ChartSampleData>? chartData;
  TrackballBehavior? _trackballBehavior;
  ZoomPanBehavior? _zoomPanBehavior;

  TextEditingController startDatetextEditingController =
      TextEditingController();
  TextEditingController startTimetextEditingController =
      TextEditingController();
  int? timeDifference;

  @override
  void dispose() {
    super.dispose();
    startDatetextEditingController.dispose();
    startTimetextEditingController.dispose();
  }

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true);
    // chartData = <ChartSampleData>[
    //   ChartSampleData(month: 'Jan', temp: 70, bp: 20, bo: 95),
    //   ChartSampleData(month: 'Feb', temp: 200, bp: 22, bo: 97),
    //   ChartSampleData(month: 'Mar', temp: 80, bp: 24, bo: 96),
    //   ChartSampleData(month: 'Apr', temp: 85, bp: 400, bo: 95),
    //   ChartSampleData(month: 'May', temp: 90, bp: 28, bo: 94),
    //   ChartSampleData(month: 'Jun', temp: 95, bp: 30, bo: 600),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PatientController>(builder: (context, consumer, _) {
        return SafeArea(
          child: SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 5,
                          padding: EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          final res = await PateintHelper.selectDate(context);
                          if (res != null) {
                            startDatetextEditingController.text = res;
                            consumer.update();
                  
                            if (startDatetextEditingController.text.isNotEmpty &&
                                startTimetextEditingController.text.isNotEmpty &&
                                timeDifference != null) {
                              DateTime parsedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm').parse(
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}');
                  
                              DateTime newDateTime = parsedDateTime
                                  .subtract(Duration(hours: timeDifference!));
                  
                              String newFormattedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(newDateTime);
                              print('DateTime: $newFormattedDateTime');
                  
                              consumer.getGraphInfo(
                                consumer.patientId,
                                true,
                                 newFormattedDateTime,
                              '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                              );
                            }
                          }
                        },
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.black,
                        ),
                        label: Text(
                          startDatetextEditingController.text.isEmpty
                              ? 'End Date'
                              : startDatetextEditingController.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 5,
                          padding: EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          final res = await PateintHelper.selectTime(context, startDatetextEditingController.text);
                          if (res != null) {
                            startTimetextEditingController.text = res;
                            consumer.update();
                  
                            if (startDatetextEditingController.text.isNotEmpty &&
                                startTimetextEditingController.text.isNotEmpty &&
                                timeDifference != null) {
                              DateTime parsedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm').parse(
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}');
                  
                              DateTime newDateTime = parsedDateTime
                                  .subtract(Duration(hours: timeDifference!));
                  
                              String newFormattedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(newDateTime);
                              print('DateTime: $newFormattedDateTime');
                  
                              consumer.getGraphInfo(
                                consumer.patientId,
                                true,
                               newFormattedDateTime,
                              '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                              );
                            }
                          }
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black,
                        ),
                        label: Text(
                          startTimetextEditingController.text.isEmpty
                              ? 'End Time'
                              : startTimetextEditingController.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      DropdownMenuWidget(
                        hintText: 'Select Time Interval',
                        items: [
                          'Last 3 Hours',
                          'Last 6 Hours',
                          'Last 12 Hours',
                          'Last 24 Hours',
                        ],
                        onTap: (selectedIndex, selectedValue) {
                          if (selectedValue == 'Last 3 Hours') {
                            timeDifference = 3;
                          }
                          if (selectedValue == 'Last 6 Hours') {
                            timeDifference = 6;
                          }
                          if (selectedValue == 'Last 12 Hours') {
                            timeDifference = 12;
                          }
                          if (selectedValue == 'Last 24 Hours') {
                            timeDifference = 24;
                          }
                          if (startDatetextEditingController.text.isNotEmpty &&
                              startTimetextEditingController.text.isNotEmpty &&
                              timeDifference != null) {
                            DateTime parsedDateTime =
                                DateFormat('yyyy-MM-dd HH:mm').parse(
                                    '${startDatetextEditingController.text} ${startTimetextEditingController.text}');
                  
                            DateTime newDateTime = parsedDateTime
                                .subtract(Duration(hours: timeDifference!));
                  
                            String newFormattedDateTime =
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(newDateTime);
                            print('DateTime: $newFormattedDateTime');
                  
                            consumer.getGraphInfo(
                              consumer.patientId,
                              true,
                              newFormattedDateTime,
                              '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                            );
                          }
                        },
                      ),
                        SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child:
                      SizedBox(height: 620.h, child: _buildStackedLineChart()),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  SfCartesianChart _buildStackedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: ''),
      legend: Legend(
        isVisible: true,
        textStyle: TextStyle(
          fontSize: 12.sp,
        ),
        padding: 8,
        itemPadding: 4,
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 45,
      ),
      // primaryYAxis: NumericAxis(
      //     axisLine: AxisLine(width: 0),
      //     labelFormat: r'{value}',
      //     majorTickLines: MajorTickLines(size: 0)),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        labelFormat: r'{value}',
        majorTickLines: MajorTickLines(size: 0),
        // minimum: 0, // Set a minimum value
        // maximum: 500, // Set a maximum value based on your data
      ),
      series: _getStackedLineSeries(),
      trackballBehavior: _trackballBehavior,
      zoomPanBehavior: _zoomPanBehavior,
    );
  }

  List<StackedLineSeries<GraphDataModel, String>> _getStackedLineSeries() {
    return <StackedLineSeries<GraphDataModel, String>>[
      StackedLineSeries<GraphDataModel, String>(
          dataSource: context.watch<PatientController>().graphDataModel,
          xValueMapper: (GraphDataModel data, _) => data.timeGroup as String,
          yValueMapper: (GraphDataModel data, _) => data.temperature,
          name: 'Temperature',

          // groupName: 'Temp',
          color: Colors.blue,
          // dataLabelSettings:
          //     DataLabelSettings(isVisible: true, useSeriesColor: true),
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<GraphDataModel, String>(
          dataSource: context.watch<PatientController>().graphDataModel,
          xValueMapper: (GraphDataModel data, _) => data.timeGroup as String,
          yValueMapper: (GraphDataModel data, _) => data.bloodPressure,
          name: 'Blood Pressure',

          // groupName: 'BP',
          // dataLabelSettings:
          //     DataLabelSettings(isVisible: true, useSeriesColor: true),
          color: Colors.red,
          markerSettings: const MarkerSettings(isVisible: true)),
      StackedLineSeries<GraphDataModel, String>(
          dataSource: context.watch<PatientController>().graphDataModel,
          xValueMapper: (GraphDataModel data, _) => data.timeGroup as String,
          yValueMapper: (GraphDataModel data, _) => data.bloodOxygen,
          name: 'Blood Oxygen',
          // groupName: 'BO',
          // dataLabelSettings:
          //     DataLabelSettings(isVisible: true, useSeriesColor: true),
          color: Colors.black,
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
}
