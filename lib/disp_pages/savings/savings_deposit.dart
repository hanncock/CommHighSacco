import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../wrapper.dart';

var savingsData;
class SavingsDeposit extends StatefulWidget {
  const SavingsDeposit({Key? key}) : super(key: key);

  @override
  State<SavingsDeposit> createState() => _SavingsDepositState();
}

class _SavingsDepositState extends State<SavingsDeposit> {

  final AuthService auth = AuthService();
  bool initial_load = false;
  bool nodata = false;
  late List savingsLedger = [];
  final f = DateFormat('yyyy-MM-dd');

  //var name = shareAccData['accountNo'];

  getShareLedgers() async {
    var check_connection = await auth.internetFunctions();
    if (check_connection == true) {
      //print('${widget.ledgerId}');
      //print('SOKE');
      var response = await auth.getSavingsDeposits();
      print(response);
      if (response['count'] == 0) {
        setState(() {
          initial_load = false;
          nodata = true;
        });
      } else {
        setState(() {
          nodata = false;
          initial_load = false;
          //savingsLedger = response['list'];
          savingsData = response['list'];
          print(savingsLedger);
        });
        return savingsData;
      }
    } else {
      initial_load = true;
    }
  }

  @override
  // void initState() {
  //   //getShareLedgers();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
    final styles = TextStyle(
        fontFamily: 'Muli', fontSize: width * 0.04, color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli', fontSize: width * 0.035);
    return  initial_load ?
    LoadingSpinCircle()
        :
    nodata ?
    Center(
      child: Text(
        'Sorry !\n\nNo Ledgers to Display',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue,
            fontSize: width * 0.04,
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
              columns: [
                DataColumn(label: Text('Date',style: styles,))
              ],
              rows: List.generate(savingsLedger.length, (index) {
                final item = savingsLedger[index];
                color: MaterialStateColor.resolveWith((states) {
                  return index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1);});
                return DataRow(
                    cells: [
                      DataCell(Text(f.format(new DateTime.fromMillisecondsSinceEpoch(item['depositDate']))),),
                    ]
                );
              }),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
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
                  columns: [
                    DataColumn(label: SizedBox(
                        width: 200,
                        child: Text('Product',style: styles))
                    ),
                    DataColumn(label: Text('Month',style: styles)),
                    DataColumn(label: Text('Year',style: styles)),
                    DataColumn(label: Text('Amount',style: styles)),
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
                        DataCell(
                            SizedBox(
                                width:200,
                                child: Text(savingsLedger[index]['product'] ?? '' ,style: styles2,)
                            )
                        ),
                        DataCell(Text(savingsLedger[index]['month'] , style: styles2,)),
                        DataCell(Text(savingsLedger[index]['year'].toString() , style: styles2,)),
                        DataCell(Text(formatCurrency(savingsLedger[index]['amount'] ?? 0) , style: styles2,)),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

}

class RowSource extends DataTableSource {

  final _rowCount = savingsData.length;
  final styler2 = TextStyle(fontFamily: "Muli");

  @override
  DataRow? getRow(int index){
    if(index <_rowCount){
      return DataRow(
          cells: [
            DataCell(Text(f.format(
                new DateTime.fromMillisecondsSinceEpoch(
                    savingsData[index]['depositDate'])), style: styler2,),),
            DataCell(SingleChildScrollView(
              child: Text('${savingsData[index]['product']}',style: styler2,overflow: TextOverflow.fade,
                  softWrap: true),
            )),
            DataCell(Text('${savingsData[index]['month']}',style: styler2,)),
            DataCell(Text('${savingsData[index]['year']}',style: styler2,)),
            DataCell(Text('${formatCurrency(savingsData[index]['amount'])}',style: styler2,)),
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