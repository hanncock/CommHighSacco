import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/loanShedule_model.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';


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
  var path;

  getFileFromUrl() async {
    var date = DateTime.now();
    String name = "${date.hour}-${date.minute}-${date.second}";
    var resu = await auth.fetchLoanRepaymentSchedule2('${widget.loanId}');
    var data = resu['list'];
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
                pw.Text('Loan Schedules',
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
                            pw.Text('No.',style: styleheadpw),
                            pw.Text('Loan Balance',style: styleheadpw),
                            pw.Text('Principle',style: styleheadpw),
                            pw.Text('Interest',style: styleheadpw),
                            pw.Text('Total Interest',style: styleheadpw),
                            pw.Text('Date',style: styleheadpw)
                          ]),
                      for(var item in data) pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${item['installmentNo']}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${formatCurrency(item['principalApplied'])}',style: stylehea2),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(3),
                              child: pw.Text('${formatCurrency(item['principalPayment'])}',style: stylehea2),
                            ),
                            pw.Text('${formatCurrency(item['interestPayment'])}',style: stylehea2),
                            pw.Text('${formatCurrency(item['cumulativeInterest'])}',style: stylehea2),
                            pw.Text('${item['dueDate'] == null ? '' :f.format(new DateTime.fromMillisecondsSinceEpoch(item['dueDate']))}',style: stylehea2),])
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
  void initState(){
    super.initState();
    getFileFromUrl();
  }


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
      // body: PDFView(
      //   filePath: path,
      //   autoSpacing: true,
      //   enableSwipe: true,
      //   pageSnap: true,
      //   swipeHorizontal: true,
      //   nightMode: false,
      //   onError: (e) {
      //     Text('${e.toString()}');
      //     //Show some error message or UI
      //   },
      //   onRender: (_pages) {
      //     setState(() {
      //       // _totalPages = _pages;
      //       // pdfReady = true;
      //     });
      //   },
      //   onViewCreated: (PDFViewController vc) {
      //     setState(() {
      //       // _pdfViewController = vc;
      //     });
      //   },
      //   onPageError: (page, e) {},
      // ),

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