

import 'package:flutter/material.dart';

class NavData{
  final String activeIcon;
  final String inActiveIcon;
  final String label;
  final Widget basePage;
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  NavData({required this.label, required this.basePage, required this.inActiveIcon, required this.activeIcon});
}