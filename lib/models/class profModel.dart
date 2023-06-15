import 'package:flutter/material.dart';

class ProfModel{

  final String label;
  final String route;
  final Widget widget;
   bool active;

  ProfModel({
    required this.active,
    required this.label,
    required this.route,
    required this.widget
});

}
