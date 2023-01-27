import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/LoanLedger_Transactionmodel.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';


class LoanLedger extends StatefulWidget {
  const LoanLedger({Key? key, required this.LoanLedgerId}) : super(key: key);
  final LoanLedgerId;
  @override
  _LoanLedgerState createState() => _LoanLedgerState();
}

class _LoanLedgerState extends State<LoanLedger> {
  final AuthService auth = AuthService();
  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final stylehead = TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Loan Ledger',
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
      body: FutureBuilder(
        future: auth.fetchLoanLedger('${widget.LoanLedgerId}'),
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

  DataTableSource dataSource(List<LoanLedgers> LoanLedgersList) =>
      MyData(dataList: LoanLedgersList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<LoanLedgers> dataList;
  final styled = TextStyle(fontFamily: "Muli",);
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
                child: Text(dataList[index].description,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  style: styled,
                )
            ),
          ),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].debit)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].credit)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].balance)}',style: styled,),
        ),
      ],
    );
  }
}