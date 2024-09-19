
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDart => this == ThemeData.dark() ? true : false;
}
