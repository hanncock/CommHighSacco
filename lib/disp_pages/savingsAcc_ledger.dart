import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/savings_account.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavingsLedger extends StatefulWidget {
  const SavingsLedger({Key? key, required this.ledgerId}) : super(key: key);
  final String ledgerId;

  @override
  State<SavingsLedger> createState() => _SavingsLedgerState();
}

class _SavingsLedgerState extends State<SavingsLedger> {
  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  late List savingsLedger = [];
  final f = new DateFormat('yyyy-MM-dd');

  //var name = shareAccData['accountNo'];
  getShareLedgers() async{
    var datafound = await savingsLedger;
    if(datafound != null){
      print(savingsLedger);
      setState(() {
        initial_load = false;
      });
    }else{
      setState(() {
        nodata = true;
      });
      print('no data found');
    }
  }


  @override
  void initState() {
    getShareLedgers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
    final styles = TextStyle(
        fontFamily: 'Muli', fontSize: 14, color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli', fontSize: 16);
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Savings Ledger',
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
      ),
      body: initial_load ?
      LoadingSpinCircle()
          :
      nodata ?
      Center(
        child: Text(
          'Sorry !\n\nNo Ledgers to Display',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontFamily: "Muli"
          ),
        ),) :
      Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                source: RowSource(),
                showCheckboxColumn: false,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                columnSpacing: 20,
                availableRowsPerPage: [10, 20],

                onRowsPerPageChanged: (newRowsPerPage){
                  if(newRowsPerPage != null){
                    setState(() {
                      rowsPerPage = newRowsPerPage;
                    });
                  }
                },
                columns: [
                  DataColumn(label: Text('Date',style: styles)),
                  DataColumn(label: Text('Description',style: styles)),
                  DataColumn(label: Text('Debit',style: styles)),
                  DataColumn(label: Text('Credit',style: styles)),
                  DataColumn(label: Text('Balance',style: styles)),
                ],
              ),
            ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     Text(shareledger['product'].toString())
      //   ],
      // ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text('', style: TextStyle(
      //           fontSize: 28,
      //           fontFamily: "Muli",
      //           color: Colors.black
      //       ),),
      //     ),
      //     Container(
      //       height: MediaQuery
      //           .of(context)
      //           .size
      //           .height * 0.8,
      //       width: MediaQuery.of(context).size.width,
      //       child: Scrollbar(
      //         child: ListView.builder(
      //           itemCount: savingsLedger.length,
      //           scrollDirection: Axis.horizontal,
      //           itemBuilder: (c, i) =>
      //               DataTable(
      //                 columns: <DataColumn>[
      //                   DataColumn(
      //                       label: Text('Date'.toUpperCase(), style: styles,),
      //                       numeric: false,
      //                       onSort: (i, b) {},
      //                       tooltip: "Transaction Date"
      //                   ),
      //                   DataColumn(
      //                       label: Text(
      //                         'Description'.toUpperCase(), style: styles,),
      //                       numeric: false,
      //                       onSort: (i, b) {},
      //                       tooltip: "trxn Desc"
      //                   ),
      //                   DataColumn(
      //                       label: Text('Debit'.toUpperCase(), style: styles,),
      //                       numeric: false,
      //                       onSort: (i, b) {},
      //                       tooltip: "All Debits"
      //                   ),
      //                   DataColumn(
      //                       label: Text('Credit'.toUpperCase(), style: styles,),
      //                       numeric: false,
      //                       onSort: (i, b) {},
      //                       tooltip: "All Credits"
      //                   ),
      //                   DataColumn(
      //                       label: Text(
      //                         'Balance'.toUpperCase(), style: styles,),
      //                       numeric: false,
      //                       onSort: (i, b) {},
      //                       tooltip: "Acc Balance"
      //                   ),
      //                 ],
      //
      //                 rows: savingsLedger.map((prop) =>
      //                     DataRow(
      //                         cells: [
      //                           //DataCell(Text(prop['txnDate'] == null ? '' : prop['txnDate'].toString())),
      //                           DataCell(Text(f.format(
      //                               new DateTime.fromMillisecondsSinceEpoch(
      //                                   prop['txnDate'])), style: styles2,),),
      //                           DataCell(Text(
      //                             prop['descr'] == null ? '' : prop['descr']
      //                                 .toString(), style: styles2,)),
      //                           DataCell(Text(
      //                             prop['debit'] == null ? '' : prop['debit']
      //                                 .toString(), style: styles2,)),
      //                           DataCell(Text(prop['credit'].toString() == null ? '' : prop['credit']
      //                               .toString()
      //                             , style: styles2,)),
      //                           DataCell(Text(
      //                             prop['balance'] == null ? '' : prop['balance']
      //                                 .toString(), style: styles2,)),
      //                         ]
      //                     )).toList(),
      //               ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class RowSource extends DataTableSource {

  final _rowCount = savingsLedger.length;
  final styler2 = TextStyle(fontFamily: "Muli");

  @override
  DataRow? getRow(int index){
    if(index <_rowCount){
      return DataRow(
          cells: [
            DataCell(Text(f.format(
                new DateTime.fromMillisecondsSinceEpoch(
                    savingsLedger[index]['txnDate'])), style: styler2,),),
            DataCell(SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Text('${savingsLedger[index]['descr']}',style: styler2,overflow: TextOverflow.fade,
                    softWrap: true),
              ),
            )),
            DataCell(Text('${formatCurrency(savingsLedger[index]['debit'])}',style: styler2,)),
            DataCell(Text('${formatCurrency(savingsLedger[index]['credit'])}',style: styler2,)),
            DataCell(Text('${formatCurrency(savingsLedger[index]['balance'])}',style: styler2,)),
          ]
      );
    }else{
      return null;
    }
  }
  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;
}