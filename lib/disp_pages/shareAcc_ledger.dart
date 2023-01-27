// import 'package:ezenSacco/Pages/Home/homescreen.dart';
// import 'package:ezenSacco/constants.dart';
// import 'package:ezenSacco/disp_pages/share_accounts.dart';
// import 'package:ezenSacco/services/auth.dart';
// import 'package:ezenSacco/utils/formatter.dart';
// import 'package:ezenSacco/widgets/backbtn_overide.dart';
// import 'package:ezenSacco/widgets/spin_loader.dart';
// import 'package:ezenSacco/wrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ShareAccLedger extends StatefulWidget {
//   const ShareAccLedger({Key? key, required this.ledgerId}) : super(key: key);
//   final String ledgerId;
//   @override
//   State<ShareAccLedger> createState() => _ShareAccLedgerState();
// }
//
// class _ShareAccLedgerState extends State<ShareAccLedger> {
//   @override
//   final AuthService auth = AuthService();
//   bool initial_load = true;
//   bool nodata = false;
//   late  List shareledger = [];
//   final f = new DateFormat('yyyy-MM-dd');
//   //var name = shareAccData['accountNo'];
//
//   getShareLedgers() async{
//     var check_connection = await auth.internetFunctions();
//     if(check_connection == true){
//       //print('${widget.ledgerId}');
//       //print('SOKE');
//       var response = await auth.shareLedger('${widget.ledgerId}'.toString());
//       print(response);
//       if(response['count']== 0){
//         setState(() {
//           initial_load = false;
//           nodata = true;
//         });
//
//       }else{
//         setState(() {
//           nodata = false;
//           initial_load = false;
//           shareledger = response['list'];
//           print(shareledger);
//         });
//       }
//     }else{
//       initial_load = true;
//     }
//
//   }
//
//   @override
//   void initState(){
//     getShareLedgers();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final styles = TextStyle(fontFamily: 'Muli',fontSize: 16,color: Colors.redAccent,fontWeight: FontWeight.bold);
//     final styles2 = TextStyle(fontFamily: 'Muli',fontSize: 15);
//     return Scaffold(
//         appBar: AppBar(
//           leading: goback(context),
//           title: Text(
//             'Shares Ledger',
//             style: TextStyle(
//                 color: Colors.black45,
//                 fontFamily: "Muli"
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.refresh,
//                 color: Colors.redAccent,
//               ),
//               onPressed: () {
//                 setState(() {
//                   print('Reload init');
//                   // provider.getStatements(context, mounted, reload: true);
//                   // _data = ApiService().getDividends(true);
//                 });
//               },
//             ),
//           ],
//         ),
//         body: initial_load?
//         LoadingSpinCircle()
//             :
//         nodata ?
//         Center(
//           child: Text(
//             'Sorry !\n\nNo Ledgers to Display',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 20,
//                 fontFamily: "Muli"
//             ),
//           ),) :
//         // Column(
//         //   children: [
//         //     Text(shareledger['product'].toString())
//         //   ],
//         // ),
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Ledger Entries',style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: "Muli",
//                 color: Colors.black
//               ),),
//             ),
//             Container(
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 width: MediaQuery.of(context).size.width,
//                 child: Scrollbar(
//                   child: ListView.builder(
//                     itemCount: shareledger.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (c, i) => DataTable(
//                       columns: <DataColumn>[
//                         DataColumn(
//                             label: Text('Date'.toUpperCase(),style: styles,),
//                             numeric: false,
//                             onSort: (i, b){},
//                             tooltip: "Transaction Date"
//                         ),
//                         DataColumn(
//                             label: Text('Description'.toUpperCase(),style: styles,),
//                             numeric: false,
//                             onSort: (i, b){},
//                             tooltip: "trxn Desc"
//                         ),
//                         DataColumn(
//                             label: Text('Debit'.toUpperCase(),style: styles,),
//                             numeric: false,
//                             onSort: (i, b){},
//                             tooltip: "All Debits"
//                         ),
//                         DataColumn(
//                             label: Text('Credit'.toUpperCase(),style: styles,),
//                             numeric: false,
//                             onSort: (i, b){},
//                             tooltip: "All Credits"
//                         ),
//                         DataColumn(
//                             label: Text('Balance'.toUpperCase(),style: styles,),
//                             numeric: false,
//                             onSort: (i, b){},
//                             tooltip: "Acc Balance"
//                         ),
//                       ],
//
//                       rows: shareledger.map((prop) => DataRow(
//                           cells: [
//                             DataCell(Text(f.format(new DateTime.fromMillisecondsSinceEpoch(prop['txnDate'])),style: styles2,),),
//                             DataCell(Text(prop['descr'] == null ? '' : prop['descr'].toString(),style: styles2,)),
//                             DataCell(Text(prop['debit'] == null ? '---' : prop['debit'].toString() ,style: styles2,)),
//                             DataCell(Text(prop['credit'] == null ? '---' : prop['credit'].toString(),style: styles2,)),
//                             DataCell(Text(prop['balance'] == null ? '---' : prop['balance'].toString(),style: styles2,)),
//                           ]
//                       )).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         );
//   }
// }
import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/shareAccledger_model.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class ShareAccLedger extends StatefulWidget {
  const ShareAccLedger({Key? key, required this.shareLedgerId}) : super(key: key);
  final shareLedgerId;
  @override
  _ShareAccLedgerState createState() => _ShareAccLedgerState();
}

class _ShareAccLedgerState extends State<ShareAccLedger> {
  final AuthService auth = AuthService();
  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final stylehead = TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent,fontSize: width * 0.35);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Shares Acc. Ledger',
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli",
            fontSize: width * 0.04
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
      ),
      body: FutureBuilder(
        future: auth.fetchShareLedger('${widget.shareLedgerId}'),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: PaginatedDataTable(
                source: dataSource(snapshot.data),
                //header: const Text('Employees'),
                columns: const [
                  DataColumn(label: Text('Date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Debit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Credit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Balance',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                ],
                showCheckboxColumn: false,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: [10, 20],
                columnSpacing: 20,

                onRowsPerPageChanged: (newRowsPerPage){
                  if(newRowsPerPage != null){
                    setState(() {
                      rowsPerPage = newRowsPerPage;
                    });
                  }
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }else if (snapshot == null){
            Center(
              child: Text('There is No Loan Data to Show',
                style: TextStyle(
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
              ,);
          }

          // By default, show a loading spinner.
          return Center(child: const LoadingSpinCircle());
        },
      ),
    );
  }

  DataTableSource dataSource(List<ShareAccLedgers> ShareAccLedgersList) =>
      MyData(dataList: ShareAccLedgersList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<ShareAccLedgers> dataList;
  // Generate some made-up data

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
            Text(f.format(new DateTime.fromMillisecondsSinceEpoch(dataList[index].date)))
        ),
        DataCell(
          SingleChildScrollView(
            child: SizedBox(width: 300,
                child: Text(dataList[index].description.toString(),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                )
            ),
          ),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].debit)}'),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].credit)}'),
        ),
        DataCell(
            Text('${formatCurrency(dataList[index].balance)}'),
        ),
      ],
    );
  }
}