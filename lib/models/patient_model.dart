import 'package:flutter/material.dart';

class PatientModel {
   String title;
   int crossAxisCellCount;
   int mainAxisCellCount;
   Color color;

  PatientModel({
    required this.title,
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.color,
  });
}