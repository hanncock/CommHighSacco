import 'dart:io';
import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/LoanLedger_Transactionmodel.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../wrapper.dart';

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
  var path;

  getFileFromUrl() async {
    var date = DateTime.now();
    String name = "${date.hour}-${date.minute}-${date.second}";
    List data = await auth.fetchLoanLedger2('${widget.LoanLedgerId}');
    print(data);
    // var data = resu;
    final pdf = pw.Document();
    final image = (await rootBundle.load('assets/Logo Comhigh.JPG')).buffer.asUint8List();
    final font = await rootBundle.load("assets/fonts/Muli-Regular.ttf");
    final fnt = pw.Font.ttf(font);
    final styleheadpw = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 16,color: PdfColors.white,
      font: fnt,
    );
    final stylehea2 = pw.TextStyle(fontSize: 16,font: fnt);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children:[
                      pw.Container(
                          width: 100,
                          height: 100,
                          child: pw.Center(
                            // child: pw.Image(pw.MemoryImage(image),width: 150,height: 150, fit: pw.BoxFit.cover),
                            child: pw.Image(pw.MemoryImage(image)),
                          )

                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${userData[1]['companyName']}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${userData[1]['saccoMemberNo']}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${userData[1]['name']}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${date}'),
                            ),
                          ]
                      )
                    ]
                ),
                pw.SizedBox(height: 20),
                pw.Text('Loan Ledger',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.SizedBox(height: 20),
                pw.Table(
                    border: pw.TableBorder.symmetric(
                      outside: pw.BorderSide.none,
                      inside:  pw.BorderSide(width: 1, color: PdfColors.white, style: pw.BorderStyle.solid),
                    ),
                    children: [
                      pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: PdfColors.redAccent,
                          ),
                          children: [
                            pw.Text('Date.',style: styleheadpw),
                            pw.Text('Description',style: styleheadpw),
                            pw.Text('Debit',style: styleheadpw),
                            pw.Text('Credit',style: styleheadpw),
                            pw.Text('Balance',style: styleheadpw),
                          ]),
                      for(var item in data) pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${f.format(new DateTime.fromMillisecondsSinceEpoch(item['txnDate']))}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${item['descr']}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${formatCurrency(item['debit'])}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${formatCurrency(item['credit'])}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${formatCurrency(item['balance'])}',style: stylehea2),
                            ),
                            // pw.Text('${formatCurrency(item['cumulativeInterest'])}',style: stylehea2),
                            // pw.Text('${item['dueDate'] == null ? '' :f.format(new DateTime.fromMillisecondsSinceEpoch(item['dueDate']))}',style: stylehea2),
                          ]
                      )
                      // pw.ListView
                    ]
                ),

              ]);
        }),

    );


    var dir = await getApplicationDocumentsDirectory();

    File file = File("${dir.path}/" + '${name}'  + ".pdf");

    setState((){
      path = "${dir.path}/${name}.pdf";
    });
    await file.writeAsBytes(await pdf.save());
  }

  @override
  void initState() {
    super.initState();
    getFileFromUrl();
  }


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
          IconButton(onPressed: ()async{
            try {
              print('Share Invoked');
              await Share.shareFiles(['${path}'],
                  text: '${DateTime.now()}');
            } catch (e) {
              print('EXCEPTION $e');
            }
          },
              icon: Icon(Icons.share,color: Colors.redAccent,)
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