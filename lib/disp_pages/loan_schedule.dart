import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/disp_loans.dart';
import 'package:ezenSacco/models/LoanLedger_Transactionmodel.dart';
import 'package:ezenSacco/models/loanShedule_model.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';


class LoanSchedule extends StatefulWidget {
  const LoanSchedule({Key? key, required this.loanId}) : super(key: key);
  final loanId;
  @override
  _LoanScheduleState createState() => _LoanScheduleState();
}

class _LoanScheduleState extends State<LoanSchedule> {
  final AuthService auth = AuthService();
  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final stylehead = TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Loan Schedule',
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
        future: auth.fetchLoanRepaymentSchedule('${widget.loanId}'),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: PaginatedDataTable(
                source: dataSource(snapshot.data),
                //header: const Text('Employees'),
                columns: const [

                  DataColumn(label: Text('Installment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Loan Balance',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Principle',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Interest',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Scheduled Payment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Cummulative Interest',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent),
                  )),
                  DataColumn(label: Text('Date',
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

  DataTableSource dataSource(List<LoanSchedules> LoanSchedulesList) =>
      MyData(dataList: LoanSchedulesList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<LoanSchedules> dataList;
  final styled = TextStyle(fontFamily: "Muli",fontSize: width * 0.035);
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
          Text(dataList[index].installment.toString(),style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].loanBalance)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].principle)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].interest)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].schedulePayment)}',style: styled,),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].cummulativeInterest)}',style: styled,),
        ),
        DataCell(
            Text(dataList[index].date == null ? '' :f.format(new DateTime.fromMillisecondsSinceEpoch(dataList[index].date)),style: styled,)
        ),
      ],
    );
  }
}