# commhigh

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# CommHighSacco

previous dashboard
// import 'package:ezenSacco/Pages/Home/profile.dart';
// import 'package:ezenSacco/disp_pages/pay_loan.dart';
// import 'package:ezenSacco/routes.dart';
// import 'package:ezenSacco/services/auth.dart';
// import 'package:ezenSacco/utils/formatter.dart';
// import 'package:ezenSacco/widgets/spin_loader.dart';
// import 'package:ezenSacco/wrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:local_auth/local_auth.dart';
// import '../../disp_pages/dividends.dart';
// import '../../disp_pages/loans/LoanCalculator.dart';
// import '../../disp_pages/loans/disp_loans.dart';
// import '../../disp_pages/loans/loan_product.dart';
// import '../../disp_pages/loans_guaranteed.dart';
// import '../../disp_pages/my_guarantors.dart';
// import '../../disp_pages/reports_alltrnxs.dart';
// import '../../disp_pages/savings/savings_home.dart';
// import '../../disp_pages/shares/share_products.dart';
// import '../../models/transactions_data.dart';
// import 'home_drawwer.dart';
//
// var currentUserData ;
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   late final LocalAuthentication authentication;
//   bool _supportState = false;
//
//   final date = DateFormat('dd/MM/yyy').format(DateTime.now());
//   final nowdate = new DateFormat('dd-MM-yyy').format(DateTime.now());
//   final AuthService auth = AuthService();
//   var user_info ;
//   var oldPassword = '';
//   bool dat = true;
//   var hour = DateTime.now().hour;
//   TextStyle styler = TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.035);
//
//   bool finishFetching = false;
//   late Future? datafutur;
//
//
//   checkConnection()async{
//     var check_connection = await auth.internetFunctions();
//     if(check_connection == true) {
//       setState(() {
//         dat = true;
//       });
//     }else{
//       setState(() {
//         dat = false;
//       });
//     }
//   }
//
//
//   carouselInfo () async{
//     var response = await auth.userCorouselInfo();
//     print(response);
//     if(response==null){
//       return null;
//     }else{
//       currentUserData = response;
//       setState(() {
//         user_info = response;
//       });
//       return currentUserData;
//     }
//
//   }
//
//
//   late final transactionsMockData = [
//     Transaction(
//       logo: 'salary',
//       title: 'Loan Balance',
//       description: 'Current Loan Balance',
//       date: '${nowdate}',
//       value: currentUserData['totalLoanBalance'],
//     ),
//     Transaction(
//       logo: 'saving',
//       title: 'Savings',
//       description: 'All Contributions',
//       date: '${nowdate}',
//       value: currentUserData['totalSavings'],
//     ),
//     Transaction(
//       logo: 'money-bag',
//       title: 'Shares',
//       description: 'My Current  Shares',
//       date: nowdate,
//       value: currentUserData['totalShares'],
//     )
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     checkConnection().whenComplete((){
//       authentication = LocalAuthentication();
//       authentication.isDeviceSupported().then(
//             (bool isSupported) => setState((){
//           _supportState = isSupported;
//         }),
//       );
//       datafutur = carouselInfo().whenComplete((){
//         _authenticates();
//       });
//     });
//
//   }
//   final styles = TextStyle(fontFamily: 'Muli');
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     if(dat == null){
//       return Card();
//     }else {
//       return WillPopScope(
//         onWillPop: () async {
//           print('app will be exited');
//           final shoulPop = await showWarning(context);
//           return shoulPop;
//         },
//         child: Scaffold(
//           extendBodyBehindAppBar: true,
//           key: scaffoldKey,
//           drawer: AppDrawwer(),
//           floatingActionButton: InkWell(
//             onTap: () {
//               Navigator.push(
//                   context, customePageTransion(HomePage()));
//             },
//             child: Container(
//               width: width * 0.22,
//               height: 40,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: [
//                       Colors.blue,
//                       Colors.green,
//                     ],
//                   ),
//                   // color: Colors.blue,
//                   borderRadius: BorderRadius.circular(20)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Icon(Icons.picture_as_pdf_outlined, color: Colors.white,),
//                     Text('Statement',
//                       style: TextStyle(
//                           fontSize: width * 0.025,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                       ),)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           appBar: AppBar(
//             iconTheme: IconThemeData(
//               color: Colors.lightBlue, //change your color here
//             ),
//
//             leading: IconButton(
//               icon: Icon(Icons.menu, color: Colors.white,),
//               onPressed: () => scaffoldKey.currentState?.openDrawer(),
//             ),
//             // backgroundColor: Colors.blue.shade500,
//             elevation: 0.0,
//             title: Text(
//               "",
//               style: TextStyle(
//                 color: Colors.redAccent,
//                 fontWeight: FontWeight.w700,
//               ),
//               //style: TextStyle(color: Colors.redAccent),
//             ),
//             centerTitle: true,
//           ),
//
//           body: dat ? RefreshIndicator(
//             onRefresh: () async {
//               showDialog(
//                   context: context,
//                   builder: (_) =>
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           LoadingSpinCircle(),
//                         ],
//                       ));
//
//               var check_connection = await auth.internetFunctions();
//               if (check_connection == true) {
//                 setState(() {
//                   dat = true;
//                 });
//                 var response = await auth.userCorouselInfo();
//                 print(response);
//                 if (response == null) {} else {
//                   Navigator.of(context).pop();
//                   setState(() {
//                     user_info = response;
//                     currentUserData = response;
//                     print(currentUserData);
//                   });
//                   return currentUserData;
//                 }
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: currentUserData == null ? LoadingSpinCircle() :
//                     FutureBuilder(
//                       future: datafutur,
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         if (snapshot.hasData) {
//                           return Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 70.0),
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   clipBehavior: Clip.none,
//                                   children: [
//                                     Container(
//                                       height: height * 0.3,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(30),
//                                             bottomRight: Radius.circular(30)
//                                         ),
//                                         // color: Color(0xFF5C000E)
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topRight,
//                                           end: Alignment.bottomLeft,
//                                           colors: [
//                                             Colors.blue,
//                                             Colors.green,
//                                           ],
//                                         ),
//                                       ),
//                                       // child: Text('soke'),
//                                     ),
//                                     Positioned(
//                                       top: 80,
//                                       left: 20,
//                                       right: 20,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   Text(
//                                                     hour < 12
//                                                         ? 'Good Morning '
//                                                         : hour <
//                                                         17
//                                                         ? 'Good Afternoon'
//                                                         : 'Good Evening',
//                                                     style: TextStyle(
//                                                       color: Colors.white54,
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontFamily: "Inter",
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                       '${currentUserData['firstName'] ??
//                                                           ''}',
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight: FontWeight
//                                                               .bold,
//                                                           fontSize: 20
//                                                       )
//                                                   ),
//                                                 ],
//                                               ),
//
//                                               InkWell(
//                                                 onTap: () {
//                                                   Navigator.push(context,
//                                                       customePageTransion(
//                                                           Profile()));
//                                                 },
//                                                 child: CircleAvatar(
//                                                   child: Padding(
//                                                     padding: const EdgeInsets
//                                                         .all(8.0),
//                                                     child: userData[1]['profileFoto']
//                                                         .isEmpty
//                                                         ? Image.asset(
//                                                         'assets/design_course/userImage.png')
//                                                         :
//                                                     Image.network(
//                                                         '${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
//
//                                                   ),
//                                                   // backgroundImage: NetworkImage('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
//
//                                                   backgroundColor: Colors.white,
//                                                   radius: 30,
//
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: height * 0.03,),
//                                           Container(
//
//                                             // width: width,
//                                             height: height * 0.25,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius
//                                                     .circular(10),
//                                                 color: Colors.white
//                                             ),
//                                             // color: Colors.white,
//                                             child: Column(
//                                               mainAxisAlignment: MainAxisAlignment
//                                                   .start,
//                                               children: [
//                                                 SizedBox(height: height * 0.02),
//                                                 Container(
//                                                   // color: Colors.grey,
//                                                   height: height * 0.1,
//                                                   child: Column(
//                                                     mainAxisAlignment: MainAxisAlignment
//                                                         .center,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment: MainAxisAlignment
//                                                             .spaceEvenly,
//                                                         children: [
//
//                                                           Column(
//                                                             children: [
//                                                               Text('Shares',
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .blue,
//                                                                     fontSize: width *
//                                                                         0.04
//                                                                 ),),
//                                                               Text(
//                                                                   '${formatCurrency(
//                                                                       currentUserData['totalShares'])}',
//                                                                   style: TextStyle(
//                                                                       fontSize: width *
//                                                                           0.042,
//                                                                       color: Colors
//                                                                           .blue,
//                                                                       fontWeight: FontWeight
//                                                                           .bold)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               Text('Savings',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .green,
//                                                                       fontSize: width *
//                                                                           0.04
//                                                                   )),
//                                                               Text(
//                                                                   '${formatCurrency(
//                                                                       currentUserData['totalSavings'])}',
//                                                                   style: TextStyle(
//                                                                       fontSize: width *
//                                                                           0.042,
//                                                                       color: Colors
//                                                                           .green,
//                                                                       fontWeight: FontWeight
//                                                                           .bold)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               Text('Loans',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .red,
//                                                                       fontSize: width *
//                                                                           0.04)),
//                                                               Text(
//                                                                   '${formatCurrency(
//                                                                       currentUserData['totalLoanBalance'])}',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .red,
//                                                                       fontWeight: FontWeight
//                                                                           .bold,
//                                                                       fontSize: width *
//                                                                           0.042)),
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//
//
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               Container(
//                                 height: height * 0.6,
//                                 // color: Colors.red,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 30.0),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       children: [
//                                         Card(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(20),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment
//                                                   .spaceBetween,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     print('loan calc');
//                                                     Navigator.push(context,
//                                                         customePageTransion(
//                                                             LoanCalc()));
//                                                   },
//                                                   child: Column(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .all(10.0),
//                                                           child: Image.asset(
//                                                             'assets/icons/calculator.png',
//                                                             color: Color(
//                                                                 0xFF5C000E)
//                                                                 .withOpacity(
//                                                                 0.5),),
//                                                         ),
//                                                         // backgroundImage: ,
//                                                         backgroundColor: Colors
//                                                             .grey[200],
//                                                         radius: 30,
//
//                                                       ),
//                                                       Text('Loan Calculator',
//                                                         style: styler,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     Navigator.push(context,
//                                                         customePageTransion(
//                                                             LoanProduct()));
//                                                   },
//                                                   child: Column(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .all(10.0),
//                                                           child: Image.asset(
//                                                             'assets/icons/salary.png',
//                                                             color: Color(
//                                                                 0xFF5C000E)
//                                                                 .withOpacity(
//                                                                 0.5),),
//                                                         ),
//                                                         // backgroundImage: ,
//                                                         backgroundColor: Colors
//                                                             .grey[200],
//                                                         radius: 30,
//
//                                                       ),
//                                                       Text('Request Loan',
//                                                         style: styler,)
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     Navigator.push(context,
//                                                         customePageTransion(
//                                                             SavingsHome()));
//                                                   },
//                                                   child: Column(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .all(10.0),
//                                                           child: Image.asset(
//                                                             'assets/icons/send-money.png',
//                                                             color: Color(
//                                                                 0xFF5C000E)
//                                                                 .withOpacity(
//                                                                 0.5),),
//                                                         ),
//                                                         // backgroundImage: ,
//                                                         backgroundColor: Colors
//                                                             .grey[200],
//                                                         radius: 30,
//
//                                                       ),
//                                                       Text('Deposit',
//                                                         style: styler,
//                                                         textAlign: TextAlign
//                                                             .center,)
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Card(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .all(20.0),
//                                                     child: Text('SAVINGS',
//                                                       style: TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeight
//                                                               .w800),),
//                                                   ),
//                                                 ],
//                                               ),
//
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 40.0,
//                                                     right: 40,
//                                                     top: 20,
//                                                     bottom: 20),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment
//                                                       .spaceBetween,
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () {
//                                                         // Navigator.push(context, customePageTransion(SavingsAccount()));
//                                                         Navigator.push(context,
//                                                             customePageTransion(
//                                                                 SavingsHome()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/saving.png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Accounts',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         // Navigator.push(context, customePageTransion(SavingsAccount()));
//                                                         Navigator.push(context,
//                                                             customePageTransion(
//                                                                 SavingsHome()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/wallet.png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Transfers',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         var showToast = Fluttertoast
//                                                             .showToast(
//                                                             msg: 'Coming Soon',
//                                                             toastLength: Toast
//                                                                 .LENGTH_SHORT,
//                                                             gravity: ToastGravity
//                                                                 .CENTER,
//                                                             timeInSecForIosWeb: 1,
//                                                             backgroundColor: Colors
//                                                                 .white,
//                                                             textColor: Colors
//                                                                 .green,
//                                                             fontSize: 16.0
//                                                         );
//                                                         // Navigator.push(context, customePageTransion(SavingsAccount()));
//                                                         // Navigator.push(context, customePageTransion(SavingsHome()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/cash-withdrawal.png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Withdrawals',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Divider(),
//                                         Card(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .all(20.0),
//                                                     child: Text('SHARES',
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight
//                                                                 .w800)),
//                                                   ),
//                                                 ],
//                                               ),
//
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 40.0,
//                                                     right: 40,
//                                                     top: 20,
//                                                     bottom: 20),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment
//                                                       .spaceBetween,
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () {
//                                                         Navigator.push(context,
//                                                             customePageTransion(
//                                                                 ShareProducts()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/money-bag(1).png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Accounts',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         Navigator.push(context,
//                                                             customePageTransion(
//                                                                 ShareProducts()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/saving.png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Transfers',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         Navigator.push(context,
//                                                             customePageTransion(
//                                                                 Dividends()));
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           CircleAvatar(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Image
//                                                                   .asset(
//                                                                   'assets/icons/financial-profit.png',
//                                                                   color: Color(
//                                                                       0xFF5C000E)
//                                                                       .withOpacity(
//                                                                       0.5)),
//                                                             ),
//                                                             // backgroundImage: ,
//                                                             backgroundColor: Colors
//                                                                 .grey[200],
//                                                             radius: 30,
//
//                                                           ),
//                                                           Text('Dividents',
//                                                             style: styler,)
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//
//                                         Card(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .all(20.0),
//                                                     child: Text('LOANS',
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontWeight: FontWeight
//                                                                 .w800)),
//                                                   ),
//                                                 ],
//                                               ),
//
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment
//                                                           .spaceEvenly,
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 customePageTransion(
//                                                                     Loans()));
//                                                           },
//                                                           child: Column(
//                                                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             children: [
//                                                               CircleAvatar(
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .all(
//                                                                       10.0),
//                                                                   child: Image
//                                                                       .asset(
//                                                                       'assets/icons/loan.png',
//                                                                       color: Color(
//                                                                           0xFF5C000E)
//                                                                           .withOpacity(
//                                                                           0.5)),
//                                                                 ),
//                                                                 // backgroundImage: ,
//                                                                 backgroundColor: Colors
//                                                                     .grey[200],
//                                                                 radius: 25,
//
//                                                               ),
//                                                               Padding(
//                                                                 padding: const EdgeInsets
//                                                                     .all(5.0),
//                                                                 child: Text(
//                                                                   'Applications',
//                                                                   style: styler,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 customePageTransion(
//                                                                     MyGuarantorsList()));
//                                                           },
//                                                           child: Column(
//                                                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             children: [
//                                                               CircleAvatar(
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .all(
//                                                                       10.0),
//                                                                   child: Image
//                                                                       .asset(
//                                                                       'assets/icons/lottery.png',
//                                                                       color: Color(
//                                                                           0xFF5C000E)
//                                                                           .withOpacity(
//                                                                           0.5)),
//                                                                 ),
//                                                                 // backgroundImage: ,
//                                                                 backgroundColor: Colors
//                                                                     .grey[200],
//                                                                 radius: 25,
//
//                                                               ),
//                                                               Padding(
//                                                                 padding: const EdgeInsets
//                                                                     .all(5.0),
//                                                                 child: Text(
//                                                                   'Guarantors',
//                                                                   style: styler,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 customePageTransion(
//                                                                     LoansGuaranteed()));
//                                                           },
//                                                           child: Column(
//                                                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             children: [
//                                                               CircleAvatar(
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .all(
//                                                                       10.0),
//                                                                   child: Image
//                                                                       .asset(
//                                                                       'assets/icons/secured-loan.png',
//                                                                       color: Color(
//                                                                           0xFF5C000E)
//                                                                           .withOpacity(
//                                                                           0.5)),
//                                                                 ),
//                                                                 // backgroundImage: ,
//                                                                 backgroundColor: Colors
//                                                                     .grey[200],
//                                                                 radius: 25,
//
//                                                               ),
//                                                               Padding(
//                                                                 padding: const EdgeInsets
//                                                                     .all(5.0),
//                                                                 child: Text(
//                                                                   'Guaranteed',
//                                                                   style: styler,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         InkWell(
//                                                           onTap: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 customePageTransion(
//                                                                     PayLoan()));
//                                                           },
//                                                           child: Column(
//                                                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             children: [
//                                                               CircleAvatar(
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .all(
//                                                                       10.0),
//                                                                   child: Image
//                                                                       .asset(
//                                                                       'assets/icons/pay.png',
//                                                                       color: Color(
//                                                                           0xFF5C000E)
//                                                                           .withOpacity(
//                                                                           0.5)),
//                                                                 ),
//                                                                 // backgroundImage: ,
//                                                                 backgroundColor: Colors
//                                                                     .grey[200],
//                                                                 radius: 25,
//
//                                                               ),
//                                                               Padding(
//                                                                   padding: const EdgeInsets
//                                                                       .all(5.0),
//                                                                   child: Text(
//                                                                     'Pay Loan',
//                                                                     style: styler,
//                                                                   )
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                             ],
//                           );
//                         } else {
//                           return LoadingSpinCircle();
//                         }
//                       },
//                       // child:
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ) : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(child: Text(
//                 'No Connection detected, please check your mobile or wifi connection',
//                 textAlign: TextAlign.center,)),
//               ElevatedButton(onPressed: () async {
//                 showDialog(
//                     context: context,
//                     builder: (_) =>
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             LoadingSpinCircle(),
//                           ],
//                         ));
//
//                 var check_connection = await auth.internetFunctions();
//                 if (check_connection == true) {
//                   setState(() {
//                     dat = true;
//                   });
//                   carouselInfo();
//                   datafutur = carouselInfo().whenComplete(() {
//                     // _authenticates();
//                   });
//                   Navigator.of(context).pop();
//                   // var response = await auth.userCorouselInfo();
//                   // print(response);
//                   // if(response==null){
//                   // }else{
//                   //   Navigator.of(context).pop();
//                   //   setState(() {
//                   //     user_info = response;
//                   //     currentUserData = response;
//                   //     print(currentUserData);
//                   //   });
//                   //   return currentUserData;
//                   // }
//                 } else {
//                   Navigator.of(context).pop();
//                 }
//               }, child: Text('Retry'))
//             ],
//           ),
//         ),
//       );
//     }
//
//
//   }
//
//
//   _authenticates() async{
//     try{
//       bool authenticated = await authentication.authenticate(
//           localizedReason: " ",
//           options: AuthenticationOptions(
//             stickyAuth: true,
//             biometricOnly: false,
//           )
//       );
//       if(authenticated){
//
//       }else{
//         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//       }
//       print("Authenticated : $authenticated");
//     }on PlatformException catch(e){
//       print(e);
//     }
//   }
//
//   Future<void> _getAvailableBiometrics() async{
//     List availableBiometrics =  await authentication.getAvailableBiometrics();
//     print(availableBiometrics);
//     if(!mounted){
//       return ;
//     }else{
//
//     }
//   }
//
//
//   showWarning(BuildContext context) {
//     showDialog(context: context, builder: (_) => Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: AlertDialog(
//         title: Text('Do you want to exit this application..?'/*,style: styles*/,textAlign: TextAlign.center,),
//         // content: Text('We hate to see you leave...'/*,style: styles*/,textAlign: TextAlign.center,),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Colors.white,
//                   padding:  EdgeInsets.all(10.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: Text('No',style: TextStyle(color: Colors.blue,fontFamily: 'Muli'),),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   backgroundColor: Colors.white,
//                   padding:  EdgeInsets.all(10.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//                 },
//                 child: Text('Yes',style: TextStyle(color: Colors.red),),
//               ),
//             ],
//           )
//
//         ],
//         elevation: 24,
//         //backgroundColor: Colors.grey[400],
//       ),
//     ));
//   }
//
// }