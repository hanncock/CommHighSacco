import 'package:ezenSacco/Pages/Home/home_drawwer.dart';
import 'package:ezenSacco/Pages/Home/profile.dart';
import 'package:ezenSacco/disp_pages/loans/disp_loans.dart';
import 'package:ezenSacco/models/card_models.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../disp_pages/loans/LoanCalculator.dart';
import '../../disp_pages/dividends.dart';
import '../../disp_pages/loans/loan_product.dart';
import '../../disp_pages/loans_guaranteed.dart';
import '../../disp_pages/my_guarantors.dart';
import '../../disp_pages/pay_loan.dart';
import '../../disp_pages/reports_alltrnxs.dart';
import '../../disp_pages/savings/savings_home.dart';
import '../../disp_pages/shares/share_products.dart';
import '../../models/transactions_data.dart';

late var currentUserData ;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late final LocalAuthentication authentication;
  bool _supportState = false;
  var diff = height * 0.38;

  final date = DateFormat('dd/MM/yyy').format(DateTime.now());
  final nowdate = new DateFormat('dd-MM-yyy').format(DateTime.now());
  final AuthService auth = AuthService();
  var user_info ;
  var oldPassword = '';
  var dat ;
  late Future? datafutur;
  var hour = DateTime.now().hour;
  TextStyle styler = TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.035);

  carouselInfo () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      setState(() {
        dat = 'connected';
      });
      var response = await auth.userCorouselInfo();
      print(response);
      if(response==null){
      }else{
        setState(() {
          user_info = response;
          currentUserData = response;
          print(currentUserData);
        });
        return currentUserData;
      }
    }else{
    }

  }



  @override
  void initState() {
    super.initState();
    authentication = LocalAuthentication();
    authentication.isDeviceSupported().then(
          (bool isSupported) => setState((){
        _supportState = isSupported;
      }),
    );
    datafutur = carouselInfo().whenComplete((){
      // _authenticates();
    });
  }

  int activeIndex = 0;
  late var myCards = [
    CardModel(
      title: "Loan Balance",
      number: '${formatCurrency(currentUserData['totalLoanBalance'])}',
      name: 'Outstanding Loan Bal.',
      expiry: '',
      background: 'assets/images/card_bg_alt.png',
      route: '/interests',
      cardColor: Colors.redAccent.withOpacity(0.9),
    ),
    CardModel(
      title: "Savings",
      number: '${formatCurrency(currentUserData['totalSavings'])}',
      name: 'My monthly Savings',
      expiry: '06/22',
      background: 'assets/images/card_bg.png',
      route: '/savings_deposits',
      cardColor: Colors.redAccent,
    ),
    CardModel(
      title: "Interest Earned",
      number: '0',
      name: 'My earnings & dividends',
      expiry: '06/22',
      background: 'assets/images/card_bg_alt.png',
      route: '/interests',
      cardColor: Colors.redAccent.withOpacity(0.9),
    ),
    CardModel(
        title: "Total active loans",
        number: '${currentUserData['activeLoans']}',
        name: 'All active loans',
        expiry: '06/22',
        background: 'assets/images/card_bg_alt.png',
        cardColor: Colors.redAccent,
        route: '/loans'),
    CardModel(
        title: "Loan Limit",
        number: '0.00',
        name: 'Current Loan Limit',
        expiry: '06/22',
        background: 'assets/images/card_bg_alt.png',
        cardColor: Colors.redAccent,
        route: '/'),
  ];

  late Map<String, double> loans = {
    "Loans": currentUserData['totalLoanBalance'] ?? 0,
    // "Loans": 4000

  };

  late Map<String, double> shares = {
    "Shares": currentUserData['totalShares'] ?? 0,
    // "Shares": 60000,

  };

  late Map<String, double> savings = {
    "Savings": currentUserData['totalSavings'] ?? 0,
    // "Savings": 30000,

  };

  late Map<String, double> alldash = {
    "Shares": currentUserData['totalShares'] ?? 0,
    "Savings": currentUserData['totalSavings'] ?? 0,
    "Loans": currentUserData['totalLoanBalance'] ?? 0,
  };


  late final transactionsMockData = [
    Transaction(
      logo: 'salary',
      title: 'Loan Balance',
      description: 'Current Loan Balance',
      date: '${nowdate}',
      value: currentUserData['totalLoanBalance'],
    ),
    Transaction(
      logo: 'saving',
      title: 'Savings',
      description: 'All Contributions',
      date: '${nowdate}',
      value: currentUserData['totalSavings'],
    ),
    Transaction(
      logo: 'money-bag',
      title: 'Shares',
      description: 'My Current  Shares',
      date: nowdate,
      value: currentUserData['totalShares'],
    )
  ];
  final styles = TextStyle(fontFamily: 'Muli',fontSize: 10);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    if( dat == null  ){
      print(userData);
      return Scaffold(

        //drawer: AppDrawwer(),
        //   appBar: AppBar(
        //     iconTheme: IconThemeData(
        //       color: Colors.lightBlue, //change your color here
        //     ),
        //
        //     backgroundColor: Colors.blue.shade500,
        //     elevation: 0.0,
        //     title: Text(
        //       "",
        //       style: TextStyle(
        //         color: Colors.redAccent,
        //         fontWeight: FontWeight.w700,
        //       ),
        //       //style: TextStyle(color: Colors.redAccent),
        //     ),
        //     centerTitle: true,
        //     actions: <Widget>[
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8, right: 8),
        //         child: Container(
        //           width: AppBar().preferredSize.height - 8,
        //           height: AppBar().preferredSize.height - 8,
        //           color: Colors.white,
        //           child: Material(
        //             color: Colors.transparent,
        //             // child: InkWell(
        //             //     borderRadius:
        //             //     BorderRadius.circular(AppBar().preferredSize.height),
        //             //     child: Container(
        //             //       width: 60,
        //             //       height: 60,
        //             //       decoration: BoxDecoration(
        //             //           borderRadius: BorderRadius.circular(50)
        //             //       ),
        //             //       child: userData[1]['profileFoto'].isEmpty ? Image.asset('assets/design_course/userImage.png'):Image.network('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
        //             //     ),
        //             //     onTap: () {
        //             //       Navigator.push(context, customePageTransion(
        //             //           Profile())); //MaterialPageRoute(builder: (_) => Profile()));
        //             //     } //() => () =>
        //             // ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child: Text(
              //     'No Internet Connection !!!\n',
              //     style: TextStyle(
              //       fontFamily: "Muli",
              //       fontWeight: FontWeight.bold,
              //       color: Colors.redAccent,
              //     ),),
              // ),
              // Center(
              //   child: Text(
              //     'Please Check Your Internet Connection And Try Again\n',
              //     style: TextStyle(
              //       fontFamily: "Muli",
              //       fontWeight: FontWeight.bold,
              //       color: Colors.blueAccent,
              //     ),),
              // ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       carouselInfo();
              //       datafutur = carouselInfo().whenComplete((){
              //         // _authenticates();
              //       });
              //     },
              //     child: Text('Retry'),
              //   ),
              // )
            ],
          )
      );
    }else {
      return WillPopScope(
        onWillPop: () async {
          print('app will be exited');
          final shoulPop = await showWarning(context);
          return shoulPop;
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          drawer: AppDrawwer(),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),

            // backgroundColor: Color(0xFF5C000E),
            backgroundColor: Colors.blue.shade500,
            elevation: 0.0,
            title: Text(
              "",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
              //style: TextStyle(color: Colors.redAccent),
            ),
            centerTitle: true,
          ),
          floatingActionButton: InkWell(
            onTap: (){
              Navigator.push(
                  context, customePageTransion(HomePage()));
            },
            child: Container(
              width: width * 0.25,
              height: 40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      Colors.green,
                    ],
                  ),
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf_outlined,color: Colors.white,),
                    Text('Statement',
                      style: TextStyle(
                          fontSize: width * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),)
                  ],
                ),
              ),
            ),
          ),
          body: FutureBuilder(
            future: datafutur,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:80.0),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)
                                ),
                                // color: Color(0xFF5C000E)
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blue,
                                    Colors.green,
                                  ],
                                ),
                              ),
                              // child: Text('soke'),
                            ),
                            Positioned(
                              top: 80,
                              left: 20,
                              right: 20,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            hour < 12 ? 'Good Morning ' : hour <
                                                17
                                                ? 'Good Afternoon'
                                                : 'Good Evening',
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                          ),
                                          Text(
                                              currentUserData['firstName'] == null
                                                  ? '---'
                                                  : currentUserData['firstName'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              )
                                          ),
                                        ],
                                      ),

                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              customePageTransion(Profile()));
                                        },
                                        child: CircleAvatar(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            // child: userData[1]['profileFoto'] == null ? Image.asset('assets/design_course/userImage.png'):
                                            // Image.network('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),

                                          ),
                                          // backgroundImage: NetworkImage('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
                                          backgroundImage: userData[1]['profileFoto'] == null ? NetworkImage('assets/design_course/userImage.png'):
                                          NetworkImage('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
                                          backgroundColor: Colors.white,
                                          radius: 30,

                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.03,),
                                  Container(
                                    // width: width,
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[100]
                                    ),
                                    // color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height:height * 0.02),
                                        Container(
                                          // color: Colors.grey,
                                          height:height * 0.1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  Column(
                                                    children: [
                                                      Text('Shares',
                                                        style: TextStyle(color: Colors.blue,
                                                            fontSize: 14
                                                        ),),
                                                      Text('${formatCurrency(currentUserData['totalShares'])}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blue,fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text('Savings',style: TextStyle(color: Colors.green,fontSize: 14)),
                                                      Text('${formatCurrency(currentUserData['totalSavings'])}',
                                                          style: TextStyle(fontSize: 14,color: Colors.green,fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text('Loans',style: TextStyle(color: Colors.red)),
                                                      Text('${formatCurrency(currentUserData['totalLoanBalance'])}',
                                                          style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 14)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: height * 0.6,
                        // color: Colors.red,
                        child: Padding(padding: const EdgeInsets.only(top: 20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right:10,top: 10,bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print('loan calc');
                                            Navigator.push(context, customePageTransion(LoanCalc()));
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(10.0),
                                                  child: Image.asset(
                                                    'assets/icons/calculator.png',
                                                    color: Color(0xFF5C000E)
                                                        .withOpacity(0.5),),
                                                ),
                                                // backgroundImage: ,
                                                backgroundColor: Colors
                                                    .grey[200],
                                                radius: 30,

                                              ),
                                              Text('Loan Calculator',
                                                style: styler,)
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                customePageTransion(
                                                    LoanProduct()));
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(10.0),
                                                  child: Image.asset(
                                                    'assets/icons/salary.png',
                                                    color: Color(0xFF5C000E)
                                                        .withOpacity(0.5),),
                                                ),
                                                // backgroundImage: ,
                                                backgroundColor: Colors
                                                    .grey[200],
                                                radius: 30,

                                              ),
                                              Text('Request Loan',
                                                style: styler,)
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                customePageTransion(
                                                    SavingsHome()));
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(10.0),
                                                  child: Image.asset(
                                                    'assets/icons/send-money.png',
                                                    color: Color(0xFF5C000E)
                                                        .withOpacity(0.5),),
                                                ),
                                                // backgroundImage: ,
                                                backgroundColor: Colors
                                                    .grey[200],
                                                radius: 30,

                                              ),
                                              Text('Deposit',
                                                style: styler,textAlign: TextAlign.center,)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text('SAVINGS',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800),),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // Navigator.push(context, customePageTransion(SavingsAccount()));
                                                Navigator.push(context, customePageTransion(SavingsHome()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/saving.png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Accounts', style: styler,)
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                // Navigator.push(context, customePageTransion(SavingsAccount()));
                                                Navigator.push(context, customePageTransion(SavingsHome()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/wallet.png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Transfers', style: styler,)
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                var showToast = Fluttertoast.showToast(
                                                    msg:  'Coming Soon',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.white,
                                                    textColor: Colors.green,
                                                    fontSize: 16.0
                                                );
                                                // Navigator.push(context, customePageTransion(SavingsAccount()));
                                                // Navigator.push(context, customePageTransion(SavingsHome()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/cash-withdrawal.png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Withdrawals', style: styler,)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text('SHARES',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800)),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, customePageTransion(ShareProducts()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/money-bag(1).png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Accounts', style: styler,)
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, customePageTransion(ShareProducts()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/saving.png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Transfers', style: styler,)
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, customePageTransion(Dividends()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Image.asset(
                                                          'assets/icons/financial-profit.png',
                                                          color: Color(0xFF5C000E)
                                                              .withOpacity(0.5)),
                                                    ),
                                                    // backgroundImage: ,
                                                    backgroundColor: Colors
                                                        .grey[200],
                                                    radius: 30,

                                                  ),
                                                  Text('Dividents', style: styler,)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text('LOANS',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  customePageTransion(Loans()));
                                            },
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Image.asset(
                                                        'assets/icons/loan.png',
                                                        color: Color(0xFF5C000E)
                                                            .withOpacity(0.5)),
                                                  ),
                                                  // backgroundImage: ,
                                                  backgroundColor: Colors.grey[200],
                                                  radius: 25,

                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('Applications',
                                                    style: styler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  customePageTransion(MyGuarantorsList()));
                                            },
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Image.asset(
                                                        'assets/icons/lottery.png',
                                                        color: Color(0xFF5C000E)
                                                            .withOpacity(0.5)),
                                                  ),
                                                  // backgroundImage: ,
                                                  backgroundColor: Colors.grey[200],
                                                  radius: 25,

                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('Guarantors',
                                                    style: styler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  customePageTransion(LoansGuaranteed()));
                                            },
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CircleAvatar(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Image.asset(
                                                        'assets/icons/secured-loan.png',
                                                        color: Color(0xFF5C000E)
                                                            .withOpacity(0.5)),
                                                  ),
                                                  // backgroundImage: ,
                                                  backgroundColor: Colors.grey[200],
                                                  radius: 25,

                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('Guaranteed',
                                                    style: styler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      customePageTransion(PayLoan()));
                                                },
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Image.asset(
                                                            'assets/icons/pay.png',
                                                            color: Color(0xFF5C000E)
                                                                .withOpacity(0.5)),
                                                      ),
                                                      // backgroundImage: ,
                                                      backgroundColor: Colors.grey[200],
                                                      radius: 25,

                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Text('Pay Loan',
                                                          style: styler,
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }else{
                return LoadingSpinCircle();
              }
            },
            // child:
          ),
        ),
      );
    }
  }

  _authenticates() async{
    try{
      bool authenticated = await authentication.authenticate(
          localizedReason: " ",
          options: AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          )
      );
      if(authenticated){

      }else{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
      print("Authenticated : $authenticated");
    }on PlatformException catch(e){
      print(e);
    }
  }

  buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count:myCards.length,
      effect: JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        dotColor: Colors.black12,
        activeDotColor: Colors.redAccent,
        paintStyle:  PaintingStyle.stroke,
        strokeWidth:  1.5,
      )
  );

  showWarning(BuildContext context) {
    showDialog(context: context, builder: (_) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AlertDialog(
        title: Text('Do you want to exit this application..?',style: styles,textAlign: TextAlign.center,),
        content: Text('We hate to see you leave...',style: styles,textAlign: TextAlign.center,),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  padding:  EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No',style: TextStyle(color: Colors.blue,fontFamily: 'Muli'),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  padding:  EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes',style: TextStyle(color: Colors.red),),
              ),
            ],
          )

        ],
        elevation: 24,
        //backgroundColor: Colors.grey[400],
      ),
    ));
  }

}