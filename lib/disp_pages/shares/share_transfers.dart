import 'package:ezenSacco/disp_pages/shares/incoming_shares.dart';
import 'package:ezenSacco/disp_pages/shares/outgoing_shares.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../../wrapper.dart';

class ShareTransfers extends StatefulWidget {
  const ShareTransfers({Key? key}) : super(key: key);

  @override
  State<ShareTransfers> createState() => _ShareTransfersState();
}


class _ShareTransfersState extends State<ShareTransfers> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',color: Colors.redAccent,fontSize: width * 0.035);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: <Widget>[
              Tab(child:Text('Outgoing Share',style: styles,)),
              Tab(child:Text('Incoming Share',style: styles,)),
            ],
          ),
          Container(
            height: height * 0.5,
            child: TabBarView(
              children: [
                OutgoingShares(),
                IncomingShares(),
              ],
            ),
          ),
        ],

      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     leading: goback(context),
      //     title: Text(
      //       'Share Transfers',
      //       style: TextStyle(
      //           color: Colors.black45,
      //           fontFamily: "Muli"
      //       ),
      //     ),
      //     centerTitle: true,
      //     backgroundColor: Colors.white,
      //
      //     actions: <Widget>[
      //       IconButton(
      //         icon: Icon(
      //           Icons.refresh,
      //           color: Colors.redAccent,
      //         ),
      //         onPressed: () {
      //           setState(() {
      //             print('Reload init');
      //
      //           });
      //         },
      //       ),
      //     ],
      //     bottom: TabBar(
      //       tabs: <Widget>[
      //         Tab(child:Text('Outgoing Share',style: styles,)),
      //         Tab(child:Text('Incoming Share',style: styles,)),
      //       ],
      //     ),
      //   ),
      //   body: TabBarView(
      //     children: [
      //       OutgoingShares(),
      //       IncomingShares(),
      //     ],
      //   ),
      // ),
    );
  }
}
