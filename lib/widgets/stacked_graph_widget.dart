/// Package import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:grid_app/models/graph_data_model.dart';
import 'package:grid_app/views/zoom_graph_view.dart';
import 'package:provider/provider.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../models/sample_view.dart';

class StackedLineChart extends StatefulWidget {
  const StackedLineChart({super.key});

  @override
  State<StackedLineChart> createState() => _StackedLineChartState();
}

class _StackedLineChartState extends State<StackedLineChart> {
  _StackedLineChartState();
  // List<GraphDataModel>? chartData;

  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    // chartData = <ChartSampleData>[
    //   // GraphDataModel(month: 'Jan', temp: 70, bp: 20, bo: 95),
    //   GraphDataModel(month: 'Feb', temp: 200, bp: 22, bo: 97),
    //   GraphDataModel(month: 'Mar', temp: 80, bp: 24, bo: 96),
    //   GraphDataModel(month: 'Apr', temp: 85, bp: 400, bo: 95),
    //   GraphDataModel(month: 'May', temp: 90, bp: 28, bo: 94),
    //   GraphDataModel(month: 'Jun', temp: 95, bp: 30, bo: 600),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 300.w, child: _buildStackedLineChart()),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ZoomGraphView(),
            ));
          },
          child: Icon(
            Icons.zoom_out_map_outlined,
            size: 34,
          ),
        ),
      ],
    );
  }

  /// Returns the cartesian stacked line chart.
  SfCartesianChart _buildStackedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: ''),
      legend: Legend(
        isVisible: true,
        textStyle: TextStyle(
          fontSize: 11.sp,
        ),
        padding: 4,
        itemPadding: 4,
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 45,
      ),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        labelFormat: r'{value}',
        majorTickLines: MajorTickLines(size: 0),
        // minimum: 0, // Set a minimum value
        // maximum: 5000, // Set a maximum value based on your data
      ),

      // primaryYAxis: NumericAxis(
      //     axisLine: AxisLine(width: 0),
      //     labelFormat: r'{value}',
      //     majorTickLines: MajorTickLines(size: 0)),
      series: _getStackedLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  /// Returns the list of chart series which need to render
  /// on the stacked line chart.
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

  @override
  void dispose() {
    // chartData!.clear();
    super.dispose();
  }
}
