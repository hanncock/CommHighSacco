import 'package:flutter/material.dart';

class LoadingSpinCircle extends StatelessWidget {
  const LoadingSpinCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.lightBlue,
      ),
    );
  }
}
