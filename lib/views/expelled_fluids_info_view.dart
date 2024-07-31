import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:grid_app/helpers/pateint_helper.dart';
import 'package:provider/provider.dart';

class ExpelledFluidsInfoView extends StatefulWidget {
  const ExpelledFluidsInfoView({super.key});

  @override
  State<ExpelledFluidsInfoView> createState() => _ExpelledFluidsInfoViewState();
}

class _ExpelledFluidsInfoViewState extends State<ExpelledFluidsInfoView> {
  TextEditingController startDatetextEditingController =
      TextEditingController();
  TextEditingController startTimetextEditingController =
      TextEditingController();
  TextEditingController endDatetextEditingController = TextEditingController();
  TextEditingController endTimetextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    startDatetextEditingController.dispose();
    startTimetextEditingController.dispose();
    endDatetextEditingController.dispose();
    endTimetextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expelled Fluids Info'),
        toolbarHeight: 30.h,
      ),
      body: Consumer<PatientController>(builder: (context, consumer, _) {
        return consumer.isexpelledFluidsInfoLoading
            ? LinearProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
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
                                final res =
                                    await PateintHelper.selectDate(context);
                                if (res != null) {
                                  startDatetextEditingController.text = res;
                                  consumer.update();
                                  if (startDatetextEditingController.text.isNotEmpty &&
                                      startTimetextEditingController
                                          .text.isNotEmpty &&
                                      endDatetextEditingController
                                          .text.isNotEmpty &&
                                      endTimetextEditingController
                                          .text.isNotEmpty) {
                                    consumer.getexpelledFluidsInfo(
                                      consumer.patientId,
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                                      '${endDatetextEditingController.text} ${endTimetextEditingController.text}',
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
                                    ? 'Start Date'
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
                                final res =
                                    await PateintHelper.selectTime(context);
                                if (res != null) {
                                  startTimetextEditingController.text = res;
                                  consumer.update();
                                  if (startDatetextEditingController.text.isNotEmpty &&
                                      startTimetextEditingController
                                          .text.isNotEmpty &&
                                      endDatetextEditingController
                                          .text.isNotEmpty &&
                                      endTimetextEditingController
                                          .text.isNotEmpty) {
                                    consumer.getexpelledFluidsInfo(
                                      consumer.patientId,
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                                      '${endDatetextEditingController.text} ${endTimetextEditingController.text}',
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
                                    ? 'Start Time'
                                    : startTimetextEditingController.text,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
                                final res =
                                    await PateintHelper.selectDate(context);
                                if (res != null) {
                                  endDatetextEditingController.text = res;
                                  consumer.update();
                                  if (startDatetextEditingController.text.isNotEmpty &&
                                      startTimetextEditingController
                                          .text.isNotEmpty &&
                                      endDatetextEditingController
                                          .text.isNotEmpty &&
                                      endTimetextEditingController
                                          .text.isNotEmpty) {
                                    consumer.getexpelledFluidsInfo(
                                      consumer.patientId,
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                                      '${endDatetextEditingController.text} ${endTimetextEditingController.text}',
                                    );
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              label: Text(
                                endDatetextEditingController.text.isEmpty
                                    ? 'End Date'
                                    : endDatetextEditingController.text,
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
                                final res =
                                    await PateintHelper.selectTime(context);
                                if (res != null) {
                                  endTimetextEditingController.text = res;
                                  consumer.update();
                                  if (startDatetextEditingController.text.isNotEmpty &&
                                      startTimetextEditingController
                                          .text.isNotEmpty &&
                                      endDatetextEditingController
                                          .text.isNotEmpty &&
                                      endTimetextEditingController
                                          .text.isNotEmpty) {
                                    consumer.getexpelledFluidsInfo(
                                      consumer.patientId,
                                      '${startDatetextEditingController.text} ${startTimetextEditingController.text}',
                                      '${endDatetextEditingController.text} ${endTimetextEditingController.text}',
                                    );
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.black,
                              ),
                              label: Text(
                                endTimetextEditingController.text.isEmpty
                                    ? 'End Time'
                                    : endTimetextEditingController.text,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  _buildHeaderCell('Timestamp'),

                                  _buildHeaderCell('Urine'),
                                  _buildHeaderCell('Levin'),
                                  _buildHeaderCell('ParoxeteushA'),
                                  _buildHeaderCell('ParoxeteushB'),
                                  _buildHeaderCell('Lost fluid sum'),
                                ],
                              ),
                            ),
                            // if (consumer.expelledFluidsDataModel.isEmpty)
                            //   Text(
                            //     'Info not found',
                            //   ),
                            Row(
                              children: List.generate(
                                  consumer.expelledFluidsDataModel.length,
                                  (index) {
                                final data =
                                    consumer.expelledFluidsDataModel[index];
                                return Column(
                                  children: [
                                    _buildDataCell(
                                        PateintHelper.formatDateTime(
                                            data.datetime.toString()),
                                        index),
                                    _buildDataCell(
                                        data.urine.toString(), index),
                                    _buildDataCell(
                                        data.levin.toString(), index),
                                    _buildDataCell(
                                        data.paroxeteushA.toString(), index),
                                    _buildDataCell(
                                        data.paroxeteushB.toString(), index),
                                    _buildDataCell(
                                        data.lostFluidSum.toString(), index),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDataCell(String data, int index) {
    return Container(
      width: 220.w,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black26,
        width: 0.4,
      )
          // border: Border(
          //   bottom: BorderSide(color: Colors.black12),
          //   top: index == 1 ? BorderSide(color: Colors.black26) : BorderSide.none,
          // ),
          ),
      child: Text(
        data,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          // fontSize: 12.sp,
        ),
      ),
    );
  }
}
