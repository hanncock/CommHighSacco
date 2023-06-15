import 'package:ezenSacco/models/class%20profModel.dart';
import 'package:flutter/material.dart';

class ProfView extends StatelessWidget {
  final ProfModel profModel;
  const ProfView({Key? key, required this.profModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Colors.redAccent
        ),
        child: Center(
            child: Text('${this.profModel.label}',
              style: TextStyle(
              fontWeight: FontWeight.bold,
                  fontSize: 12,
                  // color: this.profModel.active ? Colors.white :Colors.black54
              ),
            )
        )
    );
  }
}
