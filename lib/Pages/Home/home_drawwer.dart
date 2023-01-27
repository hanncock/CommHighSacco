import 'package:ezenSacco/Pages/Authenticate/authenticate.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/Pages/Home/profile.dart';
import 'package:ezenSacco/disp_pages/disp_loans.dart';
import 'package:ezenSacco/disp_pages/dividends.dart';
import 'package:ezenSacco/disp_pages/loan_product.dart';
import 'package:ezenSacco/disp_pages/loans_guaranteed.dart';
import 'package:ezenSacco/disp_pages/my_guarantors.dart';
import 'package:ezenSacco/disp_pages/my_receipts.dart';
import 'package:ezenSacco/disp_pages/reports_alltrnxs.dart';
import 'package:ezenSacco/disp_pages/reports_interest.dart';
import 'package:ezenSacco/disp_pages/savings_account.dart';
import 'package:ezenSacco/disp_pages/savings_deposit.dart';
import 'package:ezenSacco/disp_pages/savings_product.dart';
import 'package:ezenSacco/disp_pages/savings_transfer.dart';
import 'package:ezenSacco/disp_pages/shareAcc_deposits.dart';
import 'package:ezenSacco/disp_pages/share_accounts.dart';
import 'package:ezenSacco/disp_pages/share_products.dart';
import 'package:ezenSacco/disp_pages/share_transfers.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../disp_pages/LoanCalculator.dart';


class AppDrawwer extends StatefulWidget {
  const AppDrawwer({Key? key}) : super(key: key);

  @override
  State<AppDrawwer> createState() => _AppDrawwerState();
}

class _AppDrawwerState extends State<AppDrawwer> {


  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli', fontSize: width* 0.035);
    if(currentUserData == null){
      return Home();
    }else {
      return SizedBox(
        width: width * 0.6,
        child: Drawer(
            backgroundColor: Colors.white.withOpacity(1),
            child: Container(
              width: double.infinity,
              height: height,
              padding: EdgeInsets.only(top: height * 0.05),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
                    height: height * 0.16,
                    width: width * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/user.png'),
                        Text(
                          userData[1]['name'] == null ? '---': userData[1]['name'],softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            currentUserData == null ? '---' : currentUserData['company'], softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Muli",
                              fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    // scrollDirection: Axis.vertical,
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text('My Profile', style: styles,),
                          onTap: () {
                            Navigator.push(context, customePageTransion(
                                Profile()));
                          },
                          leading: const Icon(Icons.account_box),
                        ),
                        ListTile(
                          leading: ClipRRect(
                              child: Icon(
                                Icons.dashboard_rounded,
                              )
                          ),
                          title:  Text('Dashboard', style: styles,),
                          onTap: () {
                            Navigator.push(context, customePageTransion(
                                Home())); //MaterialPageRoute(builder: (_) => Home()));
                          },
                        ),
                        ListTile(
                          title: Text('Request Loan', style: styles,),
                          onTap: () {
                            Navigator.push(context, customePageTransion(
                                LoanProduct()));
                          },
                          leading: const Icon(Icons.add),
                        ),

                        ExpansionTile(
                          title: Text('Loans & Gurantors', style: styles,),
                          leading: const Icon(Icons.request_page_outlined),
                          children: [
                            ListTile(
                              title: Text('Loans', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(
                                    Loans()));
                              },
                              leading: const Icon(Icons.done_all),
                            ),
                            ListTile(
                              title: Text('My Guarantors', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(MyGuarantorsList()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),

                            ListTile(
                              title: Text('Loans Guaranteed', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(LoansGuaranteed()));
                              },
                              leading: const Icon(Icons.outbond),
                            ),
                            ListTile(
                              title: Text('Loan Calculator', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(
                                    LoanCalc()));
                              },
                              leading: const Icon(Icons.calculate_outlined),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Shares', style: styles,),
                          leading: const Icon(Icons.monetization_on_rounded),
                          children: [
                            ListTile(
                              title: Text('My Share Accounts', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(ShareAccounts()));
                              },
                              leading: const Icon(Icons.account_balance),
                            ),
                            ListTile(
                              title: Text('Share Deposits', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(
                                    ShareAccountDeposits()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            ListTile(
                              title: Text('Share Transfers ', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(ShareTransfers()));
                              },
                              leading: const Icon(Icons.outbond),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Savings', style: styles,),
                          leading: const Icon(Icons.save_alt),
                          children: [
                            ListTile(
                              title: Text('My Savings account', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(SavingsAccount()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            ListTile(
                              title: Text('Savings Deposits', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(SavingsDeposit()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            ListTile(
                              title: Text('Savings Transfers', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(SavingsTransfer()));
                              },
                              leading: const Icon(Icons.outbond),
                            ),
                            // ListTile(
                            //   title: Text('Outgoing Savings Transfers',style: styles,),
                            //   onTap: () {
                            //     Navigator.of(context).pop();
                            //     Navigator.of(context).pushNamed('/outgoing_savings');
                            //   },
                            //   leading: const Icon(Icons.outbond),
                            // ),
                            // ListTile(
                            //   title: Text('Incoming Savings Transfers',style: styles,),
                            //   onTap: () {
                            //     Navigator.of(context).pop();
                            //     Navigator.of(context).pushNamed('/incoming_savings');
                            //   },
                            //   leading: const Icon(Icons.call_received),
                            // ),
                          ],
                        ),
                        ExpansionTile(
                          leading: Icon(Icons.receipt),
                          title: Text('Reports', style: styles,),
                          children: [
                            ListTile(
                              title: Text('My Receipts', style: styles,),
                              onTap: () {
                                Navigator.push(context, customePageTransion(
                                    MonthlyContributions()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            ListTile(
                              title: Text('Interest Earned', style: styles,),
                              onTap: () {
                                Navigator.push(context,
                                    customePageTransion(InterstEarned()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            ListTile(
                              title: Text('All Transactions', style: styles,),
                              onTap: () {
                                Navigator.push(
                                    context, customePageTransion(HomePage()));
                              },
                              leading: const Icon(Icons.account_balance_wallet),
                            ),
                            // ListTile(
                            //   title: Text('Interests Earned',style: styles,),
                            //   onTap: () {
                            //     Navigator.of(context).pop();
                            //     Navigator.of(context).pushNamed('/interests');
                            //   },
                            //   leading: const Icon(Icons.monetization_on),
                            // ),
                          ],
                        ),
                        ExpansionTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.menu),
                            ),
                            title: Text(
                              'Products', style: styles,
                            ),
                            children: <Widget>[
                              ListTile(
                                title: Text('Loan Products', style: styles,),
                                onTap: () {
                                  Navigator.push(context,
                                      customePageTransion(LoanProduct()));
                                },
                                leading: const Icon(Icons.location_history),
                              ),
                              ListTile(
                                title: Text('Share Products', style: styles,),
                                onTap: () {
                                  Navigator.push(context,
                                      customePageTransion(ShareProducts()));
                                },
                                leading: const Icon(Icons.share),
                              ),
                              ListTile(
                                title: Text('Saving Products', style: styles,),
                                onTap: () {
                                  Navigator.push(context,
                                      customePageTransion(SavingsProducts()));
                                },
                                leading: const Icon(Icons.calendar_today),
                              ),
                            ]),
                        ListTile(
                          title: Text('Dividends', style: styles,),
                          onTap: () {
                            Navigator.push(context, customePageTransion(
                                Dividends()));
                          },
                          leading: const Icon(Icons.account_balance_wallet),
                        ),
                        ListTile(
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.lightBlue,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          trailing: Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            showDialog(context: context, builder: (_) =>
                                AlertDialog(
                                  title: Text(
                                    'Do you want to exit this application?',
                                    style: styles,),
                                  content: Text('We hate to see you leave...',
                                    style: styles,),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.grey.shade200,
                                        padding:  EdgeInsets.all(10.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        print("you choose no");
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('No', style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "Muli"),),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.grey.shade200,
                                        padding:  EdgeInsets.all(10.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() async {
                                          final SharedPreferences sharePreferences = await SharedPreferences
                                              .getInstance();
                                          sharePreferences.remove('email');
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Wrapper()));
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Authenticate()));
                                        });
                                        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                      },
                                      child: Text('Yes', style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: "Muli"),),
                                    ),
                                  ],
                                  elevation: 24,
                                  backgroundColor: Colors.grey[400],
                                )
                            );
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      );
    }
  }
  // PageRouteBuilder customePageTransion(newRoute) {
  //   return PageRouteBuilder(
  //       pageBuilder: (_, __, ___) =>  newRoute,
  //       transitionDuration: Duration(seconds: 2),
  //       transitionsBuilder: (context, animation, anotherAnimation, child) {
  //         animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
  //         return Align(
  //           child: SizeTransition(
  //             sizeFactor: animation,
  //             child: child,
  //             axisAlignment: 0.0,
  //           ),
  //         );
  //       });
  // }
}
