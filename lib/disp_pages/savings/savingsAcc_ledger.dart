import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/savings/savings_account.dart';
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
    final styles = TextStyle(fontFamily: 'Muli', fontSize: 14, color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli', fontSize: 16);
    return initial_load ?
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
        Divider(),
        Row(
          children: [
            DataTable(
              dataRowHeight: 60,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey,
                    width: .5,
                  ),
                ),
              ),
              columnSpacing: 10,
              columns:[
                DataColumn(label: Text(
                  'Date'.toUpperCase(), style: styles,),),
              ],
              rows: List.generate(savingsLedger.length, (index) {
                final item = savingsLedger[index];

                return DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    return index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1);}),
                  cells: [
                    DataCell(Text(f.format(new DateTime.fromMillisecondsSinceEpoch(savingsLedger[index]['txnDate'])))),

                  ],
                );
              }),

            ),
            Expanded(child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 60,
                columnSpacing: 10,
                columns: <DataColumn>[
                  DataColumn(
                      label: Text(
                        'Description'.toUpperCase(), style: styles,),
                      numeric: false,
                      onSort: (i, b) {},
                      tooltip: "trxn Desc"
                  ),
                  DataColumn(
                      label: Text('Debit'.toUpperCase(), style: styles,),
                      numeric: false,
                      onSort: (i, b) {},
                      tooltip: "All Debits"
                  ),
                  DataColumn(
                      label: Text('Credit'.toUpperCase(), style: styles,),
                      numeric: false,
                      onSort: (i, b) {},
                      tooltip: "All Credits"
                  ),
                  DataColumn(
                      label: Text(
                        'Balance'.toUpperCase(), style: styles,),
                      numeric: false,
                      onSort: (i, b) {},
                      tooltip: "Acc Balance"
                  ),
                ],
                rows: List.generate(savingsLedger.length, (index) {
                  final item = savingsLedger[index];

                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      return index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1);}),
                    // color: index % 2 == 0
                    //     ? MaterialStateProperty.resolveWith(getColor)
                    //     : null,
                    cells: [
                      DataCell(SizedBox(
                        width: 150,
                        child: Text(
                          savingsLedger[index]['descr'] ?? '' ,style: styles2,),
                      )),
                      DataCell(Text(
                        formatCurrency(savingsLedger[index]['debit'] ?? 0), style: styles2,)),
                      DataCell(Text(formatCurrency(savingsLedger[index]['credit'] ?? 0), style: styles2,)),
                      DataCell(Text(
                        formatCurrency(savingsLedger[index]['balance'] ?? 0) , style: styles2,)),
                    ],
                  );
                }),
              ),
            ))
          ],
        ),
        Divider()
      ],
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