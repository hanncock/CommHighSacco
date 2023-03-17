import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezenSacco/Pages/Home/home_drawwer.dart';
import 'package:ezenSacco/Pages/Home/profile.dart';
import 'package:ezenSacco/disp_pages/pay_loan.dart';
import 'package:ezenSacco/models/card_models.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/my_card.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:ezenSacco/widgets/transaction_card.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../disp_pages/loan_product.dart';
import '../../models/transactions_data.dart';

late var currentUserData ;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final date = DateFormat('dd/MM/yyy').format(DateTime.now());
  final nowdate = new DateFormat('dd-MM-yyy').format(DateTime.now());
  final AuthService auth = AuthService();
  var user_info ;
  var oldPassword = '';
  var dat ;
  late Future? datafutur;

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

  urlchecker(){

  }



  @override
  void initState() {
    carouselInfo();
    currentUserData = auth.userCorouselInfo();
    datafutur = carouselInfo();
    super.initState();
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
       cardColor: Colors.lightBlue,
     ),
    CardModel(
        title: "Savings",
        number: '${formatCurrency(currentUserData['totalSavings'])}',
        name: 'My monthly Savings',
        expiry: '06/22',
        background: 'assets/images/card_bg.png',
        route: '/savings_deposits',
        cardColor: Colors.lightBlue,
    ),
    CardModel(
        title: "Interest Earned",
        number: '0',
        name: 'My earnings & dividends',
        expiry: '06/22',
        background: 'assets/images/card_bg_alt.png',
        route: '/interests',
        cardColor: Colors.lightBlue,
    ),
     CardModel(
        title: "Total active loans",
         number: '${currentUserData['activeLoans']}',
        name: 'All active loans',
        expiry: '06/22',
        background: 'assets/images/card_bg_alt.png',
         cardColor: Colors.lightBlue,
        route: '/loans'),
     CardModel(
        title: "Loan Limit",
        number: '0.00',
        name: 'Current Loan Limit',
        expiry: '06/22',
        background: 'assets/images/card_bg_alt.png',
         cardColor: Colors.lightBlue,
        route: '/'),
   ];


  late final transactionsMockData = [
    Transaction(
      logo: 'loan',
      title: 'Loan Balance',
      description: 'Current Loan Balance',
      date: '${nowdate}',
      value: currentUserData['totalLoanBalance'],
    ),
    Transaction(
      logo: 'savingsbal',
      title: 'Savings',
      description: 'All Contributions',
      date: '${nowdate}',
      value: currentUserData['totalSavings'],
    ),
    Transaction(
      logo: 'sharesbal',
      title: 'Shares',
      description: 'My Current  Shares',
      date: nowdate,
      value: currentUserData['totalShares'],
    )
  ];
  final styles = TextStyle(fontFamily: 'Muli');
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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightBlue, //change your color here
          ),

          backgroundColor: Colors.white,
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                      child: Container(
                        width: width * 0.5,
                        height: height * 0.5,
                        child: Image.asset(
                            'assets/design_course/userImage.png'),
                      ),
                      onTap: () {
                        // Navigator.push(context, customePageTransion(
                        //     Profile())); //MaterialPageRoute(builder: (_) => Profile()));
                      } //() => () =>
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'No Internet Connection !!!\n',
                style: TextStyle(
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),),
            ),
            Center(
              child: Text(
                'Please Check Your Internet Connection And Try Again\n',
                style: TextStyle(
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  initState();
                },
                child: Text('Retry'),
              ),
            )
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
            drawer: AppDrawwer(),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.lightBlue, //change your color here
              ),

              backgroundColor: Colors.white,
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
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Container(
                    width: AppBar().preferredSize.height - 8,
                    height: AppBar().preferredSize.height - 8,
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                                'assets/design_course/userImage.png'),
                          ),
                          onTap: () {
                            Navigator.push(context, customePageTransion(
                                Profile())); //MaterialPageRoute(builder: (_) => Profile()));
                          } //() => () =>
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, customePageTransion(LoanProduct()));
                },
              child: Icon(Icons.request_page_outlined),
              // child: Image.asset('assets/icons/loanbal.svg'),
              backgroundColor: Colors.lightBlue,
            ),
            body: FutureBuilder(
              future: datafutur,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  return Column(
                      children: [
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.01,
                            horizontal: width * 0.08,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'Muli',
                                      fontSize: width * 0.03
                                    ),
                                    //style: kHeadingTextStyle.copyWith(fontSize: 14),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    currentUserData['firstName'] == null ? '---' : currentUserData['firstName'],
                                    style: TextStyle(
                                      fontFamily: 'Muli',
                                        fontSize: width * 0.03
                                    ),
                                    // style: kHeadingTextStyle.copyWith(
                                    //     fontSize: 12, fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                          currentUserData['totalLoanBalance'] > 0 ? InkWell(
                                onTap: () async {
                                  if (currentUserData == null) {
                                    await auth.userCorouselInfo();
                                    print('is loading');
                                  } else {
                                    Navigator.push(context, customePageTransion(
                                        PayLoan()));
                                  }
                                },
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            'Pay Loan',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Muli",
                                                fontSize: width * 0.03
                                            ) //kBodyTextStyle,
                                        ),
                                        Icon(
                                          Icons.monetization_on,
                                          color: Colors.white,

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ): Text(''),
                            ],
                          ),
                        ),
                        // SizedBox(height: height * 0.01),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CarouselSlider.builder(
                                itemCount: myCards.length,
                                itemBuilder: (context, index, realIndex) {
                                  // final card = myCards[index];
                                  return GestureDetector(
                                    child: MyCard(card: myCards[index]),
                                    onTap: () {},
                                  );
                                },
                                options: CarouselOptions(
                                  height: height * 0.23,
                                  //.w,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                  autoPlay: true,
                                  reverse: true,
                                  autoPlayInterval: Duration(seconds: 4),
                                  autoPlayAnimationDuration: Duration(
                                      milliseconds: 800),
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) =>
                                      setState(() => activeIndex = index),
                                )
                            ),

                            SizedBox(height: height * 0.02,),
                            buildIndicator(),
                            SizedBox(height: height * 0.02,),
                          ],
                        ),
                        //SizedBox(),
                        Text(
                          'Account transactions in (KES) as of $date',
                          style: TextStyle(
                              fontSize: width * 0.035,
                              color: Colors.black54,
                              fontFamily: 'Muli',
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: height * 0.03,),
                        Flexible(

                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return TransactionCard(
                                transaction: transactionsMockData[index],);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10,);
                            },
                            itemCount: transactionsMockData.length,
                            shrinkWrap: true,
                          ),
                        ),

                      ]
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const LoadingSpinCircle();
              },
            )
        ),
      );
    }
    // if (currentUserData == null) {
    //   return Into101();
    // } else {
    //   return WillPopScope(
    //     onWillPop: () async {
    //       print('app will be exited');
    //       final shoulPop = await showWarning(context);
    //
    //       return shoulPop;
    //     },
    //     child: Scaffold(
    //       drawer: AppDrawwer(),
    //       appBar: AppBar(
    //         iconTheme: IconThemeData(
    //           color: Colors.redAccent, //change your color here
    //         ),
    //
    //         backgroundColor: Colors.white,
    //         elevation: 0.0,
    //         title: Text(
    //           "",
    //           style: TextStyle(
    //             color: Colors.redAccent,
    //             fontWeight: FontWeight.w700,
    //           ),
    //           //style: TextStyle(color: Colors.redAccent),
    //         ),
    //         centerTitle: true,
    //         actions: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.only(top: 8, right: 8),
    //             child: Container(
    //               width: AppBar().preferredSize.height - 8,
    //               height: AppBar().preferredSize.height - 8,
    //               color: Colors.white,
    //               child: Material(
    //                 color: Colors.transparent,
    //                 child: InkWell(
    //                     borderRadius:
    //                     BorderRadius.circular(AppBar().preferredSize.height),
    //                     child: Container(
    //                       width: 60,
    //                       height: 60,
    //                       child: Image.asset(
    //                           'assets/design_course/userImage.png'),
    //                     ),
    //                     onTap: () {
    //                       Navigator.push(context, customePageTransion(
    //                           Profile())); //MaterialPageRoute(builder: (_) => Profile()));
    //                     } //() => () =>
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       body: Column(
    //           children: [
    //             SizedBox(height: height * 0.03),
    //             Padding(
    //               padding: EdgeInsets.symmetric(
    //                 vertical: height * 0.02,
    //                 horizontal: width * 0.08,
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: <Widget>[
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Welcome',
    //                         style: TextStyle(
    //                             color: Colors.blue,
    //                             fontFamily: 'Muli'
    //                         ),
    //                         //style: kHeadingTextStyle.copyWith(fontSize: 14),
    //                       ),
    //                       SizedBox(width: 20,),
    //                       Text(
    //                         currentUserData['firstName'],
    //                         style: TextStyle(
    //                           fontFamily: 'Muli',
    //                         ),
    //                         // style: kHeadingTextStyle.copyWith(
    //                         //     fontSize: 12, fontWeight: FontWeight.normal),
    //                       )
    //                     ],
    //                   ),
    //                   InkWell(
    //                     onTap: () async {
    //                       if (currentUserData == null) {
    //                         await auth.userCorouselInfo();
    //                         print('is loading');
    //                       } else {
    //                         Navigator.push(context, customePageTransion(
    //                             PayLoan()));
    //                       }
    //                     },
    //                     child: Row(
    //                       children: <Widget>[
    //                         Text(
    //                             'Pay Loan',
    //                             style: TextStyle(fontFamily: "Muli",
    //                             ) //kBodyTextStyle,
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.symmetric(horizontal: 20),
    //                           child: Icon(
    //                             Icons.toggle_off,
    //                             color: Colors.redAccent,
    //
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             SizedBox(height: height * 0.01),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 CarouselSlider.builder(
    //                     itemCount: myCards.length,
    //                     itemBuilder: (context, index, realIndex) {
    //                       final card = myCards[index];
    //                       return GestureDetector(
    //                         child: MyCard(card: myCards[index]),
    //                         onTap: () {},
    //                       );
    //                     },
    //                     options: CarouselOptions(
    //                       height: height * 0.23,
    //                       //.w,
    //                       aspectRatio: 16 / 9,
    //                       viewportFraction: 0.8,
    //                       autoPlay: true,
    //                       reverse: true,
    //                       autoPlayInterval: Duration(seconds: 4),
    //                       autoPlayAnimationDuration: Duration(
    //                           milliseconds: 800),
    //                       enlargeCenterPage: true,
    //                       onPageChanged: (index, reason) =>
    //                           setState(() => activeIndex = index),
    //                     )
    //                 ),
    //
    //                 SizedBox(height: height * 0.03,),
    //                 buildIndicator(),
    //                 SizedBox(height: height * 0.03,),
    //               ],
    //             ),
    //             //SizedBox(),
    //             Text(
    //               'Account transactions in (KES) as of $date',
    //               style: TextStyle(
    //
    //                   color: Colors.black54,
    //                   fontFamily: 'Muli'
    //               ),
    //             ),
    //             SizedBox(height: height * 0.03,),
    //             Flexible(
    //
    //               child: ListView.separated(
    //                 itemBuilder: (context, index) {
    //                   return TransactionCard(
    //                     transaction: transactionsMockData[index],);
    //                 },
    //                 separatorBuilder: (context, index) {
    //                   return SizedBox(height: 10,);
    //                 },
    //                 itemCount: transactionsMockData.length,
    //                 shrinkWrap: true,
    //               ),
    //             ),
    //
    //           ]
    //       ),
    //     ),
    //   );
    //}
  }
  buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count:myCards.length,


      effect: JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        dotColor: Colors.black12,
        activeDotColor: Colors.lightBlue,
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