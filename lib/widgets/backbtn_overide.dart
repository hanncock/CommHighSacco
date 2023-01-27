import 'package:flutter/material.dart';

goback(BuildContext context) {
  return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.lightBlue,
      ),
      onPressed: () => Navigator.of(context).pop());
}
