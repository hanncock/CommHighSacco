import 'package:ezenSacco/disp_pages/savings/incoming_savings.dart';
import 'package:ezenSacco/disp_pages/savings/outgoing_savings.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../../wrapper.dart';

class SavingsTransfer extends StatefulWidget {
  const SavingsTransfer({Key? key}) : super(key: key);

  @override
  State<SavingsTransfer> createState() => _SavingsTransferState();
}

class _SavingsTransferState extends State<SavingsTransfer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,color: Colors.redAccent);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(tabs: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Outgoing',style: styles,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Incoming',style: styles,),
            ),
          ]),
          Container(
            height: height * 0.5,
            child: TabBarView(
              children: [
                OutgoingSavings(),
                IncomingSavings()
                // OutgoingShares(),
                // IncomingShares(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
