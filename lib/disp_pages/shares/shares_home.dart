import 'package:ezenSacco/disp_pages/shares/shareAcc_deposits.dart';
import 'package:ezenSacco/disp_pages/shares/shareAcc_ledger.dart';
import 'package:ezenSacco/disp_pages/shares/share_transfers.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/class profModel.dart';
import '../../utils/formatter.dart';
import '../../widgets/backbtn_overide.dart';
import '../../widgets/profModelView.dart';
import '../../wrapper.dart';

class SharesHome extends StatefulWidget {
  final sharesDetails;
  const SharesHome({Key? key, required this.sharesDetails}) : super(key: key);

  @override
  State<SharesHome> createState() => _SharesHomeState();
}

class _SharesHomeState extends State<SharesHome> {

  final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,);
  final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,color: Colors.black45);

  var title = 'Details';
  late Widget screen;

  late final profMockData = [
    ProfModel(
      active: true,
      label: 'Details',
      route: '',
      widget: SharesDetails(),
    ),
    ProfModel(
      active: false,
      label: 'Deposits',
      route: '',
      widget: ShareAccountDeposits(),
    ),
    // ProfModel(
    //   active: false,
    //   label: 'Ledger',
    //   route: '',
    //   widget: ShareAccLedger(shareLedgerId: widget.sharesDetails['ledgerId'],),
    // ),
    ProfModel(
      active: false,
      label: 'Transfers',
      route: '',
      widget: ShareTransfers(),
    )
  ];

  @override
  void initState(){
    super.initState();
    setState(() {
      screen = SharesDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.sharesDetails);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text('${widget.sharesDetails['name']}',
          style: TextStyle(
              color: Colors.redAccent,
              fontFamily: "Muli",
            fontSize: width * 0.04
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:Container(
        height: height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200]
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: profMockData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          childAspectRatio : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 8),
                          crossAxisCount: profMockData.length,),
                        itemBuilder: (context, index){
                          return InkWell(
                              onTap: (){
                                setState(() {
                                  profMockData[index].active = !profMockData[index].active;
                                  title = profMockData[index].label;
                                  screen = profMockData[index].widget;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: title == profMockData[index].label ? Colors.blue: Colors.grey[200],
                                  ),
                                  child: ProfView(profModel: profMockData[index],)
                              )
                          );
                        }),
                  )
              ),
            ),
            screen
          ],
        ),
      ),
    );
  }

  Card SharesDetails() {
    return Card(
      elevation: 5,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Share Type',
                  style: styles,),
                Text(
                  widget.sharesDetails['type'].toString(),
                  style: styles2,
                ),
              ],
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Required Active Period',
                  style: styles,
                ),
                Text( widget.sharesDetails['minActivePeriod'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Effective Date',
                  style: styles,
                ),
                Text(f.format(new DateTime.fromMillisecondsSinceEpoch(widget.sharesDetails['effectiveDate'])),style: styles2,),
              ],
            ),

            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. of accounts ',
                  style: styles,),
                Text( widget.sharesDetails['numOfAccounts'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Shares',
                  style: styles,),
                Text( widget.sharesDetails['totalShares'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Share Value',
                  style: styles,),
                Text( '${formatCurrency(widget.sharesDetails['totalShareValue'])}',style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Is Refundable ?',
                  style: styles,),
                Text(widget.sharesDetails['refundable'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account Transferable ?',
                  style: styles,),
                Text(widget.sharesDetails['transferrable'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Minimun Shares ?',
                  style: styles,),
                Text(widget.sharesDetails['minimumShares'].toString(),style: styles2,),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Value Per Share',
                  style: styles,),
                Text('${formatCurrency(widget.sharesDetails['valuePerShare'])}',style: styles2,),

              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity',
                  style: styles,),
                Text(widget.sharesDetails['quantity'].toString(),style: styles2,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
