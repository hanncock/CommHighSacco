import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:grouped_list/grouped_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List datafuture = [];
  final AuthService auth = AuthService();
  final f = new DateFormat('yyyy-MM-dd');
  final styless = TextStyle(fontFamily: "Muli", color: Colors.redAccent,);
  var path;
  bool loading = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;
  bool exists = false;

  getFile()async{
    var fileName = "Member_Statement";

    var resu = await auth.getStatement();
    print(resu);
    var data = await http.get(Uri.parse(resu));
    // return data.bodyBytes;
    if(data !=null){
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      File urlFile = await file.writeAsBytes(data.bodyBytes);
      print(urlFile);
      setState(() {
        path = urlFile.path;
        loaded = true;
        // print(path);
      });
    }else{
      setState(() {
        loaded = true;
        exists = false;
      });
    }

    // return urlFile;
  }

  // getFileFromUrl() async {
  //   var date = DateTime.now();
  //   String name = "${date.hour}-${date.minute}-${date.second}";
  //   List data = await auth.fetchAllTransactions2();
  //   print(data);
  //   // var data = resu;
  //   final image = (await rootBundle.load('assets/Logo Comhigh.JPG')).buffer.asUint8List();
  //   final font = await rootBundle.load("assets/fonts/Muli-Regular.ttf");
  //   final fnt = pw.Font.ttf(font);
  //   final styleheadpw = pw.TextStyle(
  //     fontWeight: pw.FontWeight.bold,
  //     fontSize: 16,color: PdfColors.white,
  //     font: fnt,
  //   );
  //   final stylehea2 = pw.TextStyle(fontSize: 12,font: fnt);
  //   final stylehea3 = pw.TextStyle(fontSize: 10,font: fnt);
  //   final pdf = pw.Document();
  //   pdf.addPage(pw.MultiPage(
  //     maxPages: 100,
  //       // pageFormat: PdfPageFormat.a4.landscape,
  //       build: (pw.Context context){
  //
  //       return <pw.Widget>[
  //         pw.Row(
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children:[
  //               pw.Container(
  //                   width: 100,
  //                   height: 100,
  //                   child: pw.Center(
  //                     // child: pw.Image(pw.MemoryImage(image),width: 150,height: 150, fit: pw.BoxFit.cover),
  //                     child: pw.Image(pw.MemoryImage(image)),
  //                   )
  //
  //               ),
  //               pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                   children: [
  //                     pw.Padding(
  //                       padding: pw.EdgeInsets.all(3),
  //                       child: pw.Text('${userData[1]['companyName']}'),
  //                     ),
  //                     pw.Padding(
  //                       padding: pw.EdgeInsets.all(3),
  //                       child: pw.Text('${userData[1]['saccoMemberNo']}'),
  //                     ),
  //                     pw.Padding(
  //                       padding: pw.EdgeInsets.all(3),
  //                       child: pw.Text('${userData[1]['name']}'),
  //                     ),
  //                     pw.Padding(
  //                       padding: pw.EdgeInsets.all(3),
  //                       child: pw.Text('${date}'),
  //                     ),
  //                   ]
  //               )
  //             ]
  //         ),
  //         // pw.SizedBox(height: 20),
  //         pw.Text('All Transactions',
  //             style: pw.TextStyle(
  //               fontSize: 20,
  //               fontWeight: pw.FontWeight.bold,
  //             )),
  //         // pw.SizedBox(height: 20),
  //         pw.Table(
  //             border: pw.TableBorder.symmetric(
  //               outside: pw.BorderSide.none,
  //               inside:  pw.BorderSide(width: 1, color: PdfColors.white, style: pw.BorderStyle.solid),
  //             ),
  //             children: [
  //               pw.TableRow(
  //                   decoration: pw.BoxDecoration(
  //                     color: PdfColors.redAccent,
  //                   ),
  //                   children: [
  //                     pw.Text('Date.',style: styleheadpw),
  //                     pw.Text('Description',style: styleheadpw),
  //                     pw.Text('Debit',style: styleheadpw),
  //                     pw.Text('Credit',style: styleheadpw),
  //                     pw.Text('Balance',style: styleheadpw),
  //                   ]),
  //               // for (int i = 0; i< data.length; i++){}
  //               // for(var item in data) pw.TableRow(
  //               for (int i = 0; i< data.length; i++) pw.TableRow(
  //                   children: [
  //                     pw.Text('${f.format(new DateTime.fromMillisecondsSinceEpoch(data[i]['txnDate']))}',style: stylehea2),
  //                     pw.SizedBox(
  //                         width: 200,
  //                         child:pw.Text('${data[i]['descr']}',style: stylehea3),
  //                     ),
  //                     pw.Text('${formatCurrency(data[i]['debit'])}',style: stylehea2),
  //                     pw.Text('${formatCurrency(data[i]['credit'])}',style: stylehea2),
  //                     pw.Text('${formatCurrency(data[i]['balance'])}',style: stylehea2),
  //                   ]
  //               )
  //
  //             ])];
  //       }
  //
  //   ));
  //   var dir = await getApplicationDocumentsDirectory();
  //
  //   File file = File("${dir.path}/" + '${name}'  + ".pdf");
  //
  //   setState((){
  //     path = "${dir.path}/${name}.pdf";
  //   });
  //   print(path);
  //   await file.writeAsBytes(await pdf.save());
  //
  //
  // }

  getAllTrans()async{
    var resu = await auth.fetchAllTransactions();
    setState(() {
      datafuture = resu;
      loading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getFile();
    // getAllTrans();
    // datafuture = auth.fetchAllTransactions();
    // getFileFromUrl();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent,
          label: Row(
            children: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  try {
                    print('Share Invoked');
                    await Share.shareFiles(['$path'],
                        text: '${DateTime.now()}');
                  } catch (e) {
                    print('EXCEPTION $e');
                  }
                },
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    //iconSize: 50,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (_currentPage > 0) {
                          _currentPage--;
                          _pdfViewController.setPage(_currentPage);
                        }
                      });
                    },
                  ),
                  Text(
                    "${_currentPage + 1}/$_totalPages",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    //iconSize: 50,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (_currentPage < _totalPages - 1) {
                          _currentPage++;
                          _pdfViewController.setPage(_currentPage);
                        }
                      });
                    },
                  ),
                ],
              ),
              //Text('Page of Page')
            ],
          ),
          onPressed: () {},
        ),
      body: loaded ? PDFView(
        filePath: path,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        nightMode: false,
        onError: (e) {
          Text('${e.toString()}');
          //Show some error message or UI
        },
        onRender: (_pages) {
          setState(() {
            _totalPages = _pages!;
            pdfReady = true;
          });
        },
        onViewCreated: (PDFViewController vc) {
          setState(() {
            _pdfViewController = vc;
          });
        },
        onPageError: (page, e) {},
      ) : LoadingSpinCircle(),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     leading: goback(context),
    //     title: Text(
    //       "All Transactions",
    //       style: TextStyle(
    //           color: Colors.black45,
    //           fontFamily: "Muli",
    //           fontSize: width * 0.05
    //       ),
    //     ),
    //     centerTitle: true,
    //     backgroundColor: Colors.white,
    //     actions: <Widget>[
    //       IconButton(
    //         icon: Icon(
    //           Icons.refresh,
    //           color: Colors.redAccent,
    //         ),
    //         onPressed: () {
    //           setState(() {
    //             // datafuture = auth.fetchAllTransactions();
    //           });
    //         },
    //       ),
    //       IconButton(onPressed: (){
    //         showDialog(
    //             context: context, builder: (_) => LoadingSpinCircle()
    //         );
    //         getFile().whenComplete(()=> Share.shareFiles(['${path}'],
    //             text: '${DateTime.now()}'));
    //         // getFile().then((value) => ()async{
    //         //   try {
    //         //     print('Share Invoked');
    //         //
    //         //     // final url = path;
    //         //     // await OpenFile.open(url);
    //         //   } catch (e) {
    //         //     print('EXCEPTION $e');
    //         //   }
    //         // });
    //       },
    //           icon: Icon(Icons.share,color: Colors.redAccent,)
    //       )
    //     ],
    //   ),
    //           body: loading ? LoadingSpinCircle():SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('Date',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,)),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('Description',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,)),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('Debit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,)),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('Credit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,)),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('Balance',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,)),
    //                     ),
    //                   ],
    //                 ),
    //                 Divider(),
    //                 Container(
    //                   height: height * 0.82,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: GroupedListView<dynamic, String>(
    //                       elements: datafuture,
    //                       groupBy: (element) => element.accName.toString(),
    //                       groupComparator: (value1, value2) => value2.compareTo(value1),
    //                       itemComparator: (item1, item2) => item1.accName.compareTo(item2.accName),
    //                       order: GroupedListOrder.ASC,
    //                       // useStickyGroupSeparators: true,
    //                       groupSeparatorBuilder: (String value) => Container(
    //                         color: Colors.grey[300],
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Text(
    //                             value,
    //                             style: TextStyle(fontWeight: FontWeight.bold),
    //                             // textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                       ),
    //                       itemBuilder: (c, element) {
    //                         return Column(
    //                           children: [
    //                             SingleChildScrollView(
    //                               scrollDirection: Axis.horizontal,
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Text(f.format(new DateTime.fromMillisecondsSinceEpoch(element.date)),
    //                                       style: TextStyle(fontFamily: "Muli",fontSize: width * 0.03)
    //                                   ),
    //                                   SizedBox(
    //                                     width: width * 0.4,
    //                                     // height:100,
    //                                     child: Text(element.description,
    //                                         softWrap: true,
    //                                         style: TextStyle(fontFamily: "Muli",fontSize: width * 0.03)
    //                                     ),
    //                                   ),
    //                                   Text('${formatCurrency(element.debit)}',
    //                                       style: TextStyle(fontFamily: "Muli",fontSize: width * 0.03)
    //                                   ),
    //                                   Text('${formatCurrency(element.credit)}',
    //                                       style: TextStyle(fontFamily: "Muli",fontSize: width * 0.03)
    //                                   ),
    //                                   Text('${formatCurrency(element.balance)}',
    //                                       style: TextStyle(fontFamily: "Muli",fontSize: width * 0.03)
    //                                   ),
    //
    //                               ]),
    //                             ),
    //                             Divider(),
    //                           ],
    //                         );
    //
    //
    //                         // return Row(
    //                         //   children: [
    //                         //     DataTable(
    //                         //         // columnSpacing: 83,
    //                         //         dataRowHeight: double.parse('100'),
    //                         //         columns: [
    //                         //           DataColumn(label: Text('Date',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,),)),
    //                         //         ],
    //                         //         rows: [
    //                         //           DataRow(cells: [
    //                         //             DataCell(
    //                         //                 Text(f.format(new DateTime.fromMillisecondsSinceEpoch(element.date)),style: TextStyle(fontFamily: "Muli"),)
    //                         //             ),
    //                         //           ])
    //                         //         ]),
    //                         //     Expanded(
    //                         //       child: SingleChildScrollView(
    //                         //         scrollDirection: Axis.horizontal,
    //                         //         child: DataTable(
    //                         //             // columnSpacing: 83,
    //                         //             dataRowHeight: double.parse('100'),
    //                         //             columns: [
    //                         //               DataColumn(label: Text('Description',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
    //                         //               DataColumn(label: Text('Debit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
    //                         //               DataColumn(label: Text('Credit',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
    //                         //               DataColumn(label: Text('Balance',style: TextStyle(fontFamily: "Muli", color: Colors.redAccent,))),
    //                         //             ],
    //                         //             rows: [
    //                         //               DataRow(cells: [
    //                         //
    //                         //                 DataCell(
    //                         //                   SizedBox(
    //                         //                     width:200,
    //                         //                     child: Text(element.description,
    //                         //                         softWrap: true,
    //                         //                         style: TextStyle(fontFamily: "Muli")
    //                         //                     ),
    //                         //                   ),
    //                         //                 ),
    //                         //                 DataCell(
    //                         //                   Text('${formatCurrency(element.debit)}',
    //                         //                       style: TextStyle(fontFamily: "Muli")
    //                         //                   ),
    //                         //                 ),
    //                         //                 DataCell(
    //                         //                   Text('${formatCurrency(element.credit)}',
    //                         //                       style: TextStyle(fontFamily: "Muli")
    //                         //                   ),
    //                         //                 ),
    //                         //                 DataCell(
    //                         //                   Text('${formatCurrency(element.balance)}',
    //                         //                       style: TextStyle(fontFamily: "Muli")
    //                         //                   ),
    //                         //                 ),
    //                         //               ])
    //                         //             ]),
    //                         //       ),
    //                         //     )
    //                         //   ],
    //                         // );
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //     //     }else if (snapshot.hasError) {
    //     //       return Text('${snapshot.error}');
    //     //     }
    //     //     return const LoadingSpinCircle();//CircularProgressIndicator();
    //     //
    //     // }
    //   );



  }
}
