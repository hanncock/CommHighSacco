import 'package:ezenSacco/disp_pages/incoming_savings.dart';
import 'package:ezenSacco/disp_pages/outgoing_savings.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

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
      child: Scaffold(
        appBar: AppBar(
          leading: goback(context),
          title: Text(
            'Savings Transfers',
            style: TextStyle(
                color: Colors.black45,
                fontFamily: "Muli"
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  print('Reload init');
                  // provider.getStatements(context, mounted, reload: true);
                  // _data = ApiService().getDividends(true);
                });
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child:Text('Outgoing Savings',style: styles,)),
              Tab(child:Text('Incoming Savings',style: styles,)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OutgoingSavings(),
            IncomingSavings()
            // OutgoingShares(),
            // IncomingShares(),
          ],
        ),
      ),
    );
  }
}
