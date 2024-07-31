class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({
    this.month,
    this.temp,
    this.bp,
    this.bo,
  });

  /// Holds x value of the datapoint
  final dynamic month;

  /// Holds y value of the datapoint
  final num? temp;

  /// Holds x value of the datapoint
  final num? bp;

  /// Holds y value of the datapoint
  final num? bo;
}
