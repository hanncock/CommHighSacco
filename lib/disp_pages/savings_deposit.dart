import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../wrapper.dart';

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
        fontFamily: 'Muli', fontSize: width * 0.035, color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli', fontSize: width * 0.035);
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Saving Deposits',
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
      FutureBuilder(
        future: getShareLedgers(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            print('hasData');
            //return Text('has Data');
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('', style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Muli",
                      color: Colors.black
                  ),),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      source: RowSource(),
                      showCheckboxColumn: false,
                      showFirstLastButtons: true,
                      columnSpacing: 20,
                      rowsPerPage: rowsPerPage,
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
                        DataColumn(label: Text('Product',style: styles)),
                        DataColumn(label: Text('Month',style: styles)),
                        DataColumn(label: Text('Year',style: styles)),
                        DataColumn(label: Text('Amount',style: styles)),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          else if (snapshot.hasError) {
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
        }
      ),
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