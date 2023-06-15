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
import '../../widgets/spin_loader.dart';
import '../../wrapper.dart';
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
  final stylehead2 = TextStyle(fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent,fontSize: width * 0.04);
  var path;
  final styled = TextStyle(fontFamily: "Muli");

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
    return FutureBuilder(
      future: auth.fetchLoanRepaymentSchedule('${widget.loanId}'),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final savingsLedger = snapshot.data;

          return Container(
            height: height * 0.6,
            child: SingleChildScrollView(
              child: Column(
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
                          DataColumn(
                              label: Text('Instl',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontFamily: "Muli",
                                    color: Colors.redAccent),
                              )
                          ),
                        ],
                        rows: List.generate(savingsLedger.length, (index) {
                          final item = savingsLedger[index];

                          return DataRow(
                              color: MaterialStateColor.resolveWith((states) {
                                return index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1);}),
                              cells: [
                                DataCell(
                                  Text(item.installment.toString(),style: styled,),
                                ),
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
                              DataColumn(label: Text('Loan Balance',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontFamily: "Muli",color: Colors.redAccent,fontSize: width * 0.04),
                              )),
                              DataColumn(label: Text('Principle',
                                style: stylehead2,
                              )),
                              DataColumn(label: Text('Interest',
                                style: stylehead2,
                              )),
                              DataColumn(label: Text('Scheduled Payment',
                                style: stylehead2,
                              )),
                              DataColumn(label: Text('Cummulative Interest',
                                style: stylehead2,
                              )),
                              DataColumn(label: Text('Date',
                                style:stylehead2
                              )),
                            ],
                            rows: List.generate(savingsLedger.length, (index) {
                              final item = savingsLedger[index];

                              return DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.1);}),
                                cells: [

                                  DataCell(
                                    Text('${formatCurrency(item.loanBalance)}',style: styled,),
                                  ),
                                  DataCell(
                                    Text('${formatCurrency(item.principle)}',style: styled,),
                                  ),
                                  DataCell(
                                    Text('${formatCurrency(item.interest)}',style: styled,),
                                  ),
                                  DataCell(
                                    Text('${formatCurrency(item.schedulePayment)}',style: styled,),
                                  ),
                                  DataCell(
                                    Text('${formatCurrency(item.cummulativeInterest)}',style: styled,),
                                  ),
                                  DataCell(
                                      Text('')
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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