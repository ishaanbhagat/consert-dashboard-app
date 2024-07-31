import 'package:flutter/material.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
      print('Current DateTime: $formattedDateTime');

      DateTime parsedDateTime =
          DateFormat('yyyy-MM-dd HH:mm').parse(formattedDateTime);

      DateTime newDateTime = parsedDateTime.subtract(Duration(hours: 24));

      String newFormattedDateTime =
          DateFormat('yyyy-MM-dd HH:mm').format(newDateTime);
      print('DateTime 6 hours earlier: $newFormattedDateTime');

      context
          .read<PatientController>()
          .getPatientInfo(TextEditingController(text: '0'));
      // context.read<PatientController>().getGraphInfo('0', '$formattedDateTime:00', '$newFormattedDateTime:00');
      context.read<PatientController>().getGraphInfo('0', false, '$formattedDateTime:00',);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: context
            .watch<PatientController>()
            .screens[context.watch<PatientController>().selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility),
              label: 'View',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Entry',
            ),
          ],
          currentIndex: context.watch<PatientController>().selectedScreenIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          onTap: (value) {
            context.read<PatientController>().selectedScreenIndex = value;
          },
        ),
      ),
    );
  }
}
