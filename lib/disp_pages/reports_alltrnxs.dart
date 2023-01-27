import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/alltransactions_model.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../widgets/spin_loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future? datafuture;
  final AuthService auth = AuthService();
  final f = new DateFormat('yyyy-MM-dd');
  final styless = TextStyle(fontFamily: "Muli", color: Colors.redAccent,);

  @override
  void initState(){
    super.initState();
    datafuture = auth.fetchAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          "All Transactions",
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
                datafuture = auth.fetchAllTransactions();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: datafuture,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: PaginatedDataTable(
                source: dataSource(snapshot.data),
                header: const Text('Ledger Entries',style: TextStyle(fontFamily: "Muli"),),
                columns: const [
                  DataColumn(label: Text('Date',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,),)),
                  DataColumn(label: Text('Description',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
                  DataColumn(label: Text('Debit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
                  DataColumn(label: Text('Credit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
                  DataColumn(label: Text('Balance',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
                ],
                showCheckboxColumn: true,
                columnSpacing: 20,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const LoadingSpinCircle();//CircularProgressIndicator();
        },
      ),
    );
  }

  DataTableSource dataSource(List<AllTransctions> allTransactionList) =>
      MyData(dataList: allTransactionList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<AllTransctions> dataList;
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
          Text(f.format(new DateTime.fromMillisecondsSinceEpoch(dataList[index].date)),style: TextStyle(fontFamily: "Muli"),)
        ),
        DataCell(
          SizedBox(
            width: 200,
            child: SingleChildScrollView(
              child: Text(dataList[index].description,
                  softWrap: true,
                  style: TextStyle(fontFamily: "Muli")
              ),
            ),
          ),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].debit)}',
              style: TextStyle(fontFamily: "Muli")
          ),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].credit)}',
              style: TextStyle(fontFamily: "Muli")
          ),
        ),
        DataCell(
          Text('${formatCurrency(dataList[index].balance)}',
              style: TextStyle(fontFamily: "Muli")
          ),
        ),
      ],
    );
  }
}