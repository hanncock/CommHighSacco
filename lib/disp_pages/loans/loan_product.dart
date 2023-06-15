import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';

import '../../Pages/forms/request_loan.dart';
import '../../routes.dart';
import '../check_eligibility.dart';

class LoanProduct extends StatefulWidget {
  const LoanProduct({Key? key}) : super(key: key);

  @override
  State<LoanProduct> createState() => _LoanProductState();
}

class _LoanProductState extends State<LoanProduct> {

  final AuthService auth = AuthService();
  var loanProducts ;
  bool initial_load = true;
  var showmore;



  loanproduct () async{
      var response = await auth.getLoanProduct();
      if(response==null){
        initial_load = false;
      }else{
        setState(() {
          loanProducts = response['list'];
          print(loanProducts);
          print(userData[0]);
          initial_load = false;
        });
      }
  }

  @override
  void initState() {
    loanproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
    final styles2 = TextStyle(fontFamily: 'Muli',color: Colors.black45,fontSize: width * 0.035);
    return Scaffold(
        appBar: AppBar(
          leading: goback(context),
          title: Text(
            "Available Loan Products",
            style: TextStyle(
                color: Colors.blue,
                fontFamily: "Muli",
                fontSize: width * 0.04,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: initial_load?
        Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        )
            : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:  (context, index){
                    return Card(
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState((){
                                  showmore  == loanProducts[index] ? showmore = null : showmore = loanProducts[index];
                                });
                              },
                              child: Row(
                                mainAxisAlignment: showmore == loanProducts[index] ? MainAxisAlignment.center :MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.payment_rounded),
                                  SizedBox(width: 50,),
                                  Expanded(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${loanProducts[index]['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: height * 0.018,fontFamily: 'Muli',)),
                                      Icon(showmore == loanProducts[index] ? Icons.expand_less_outlined :Icons.arrow_drop_down_outlined )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            showmore == loanProducts[index] ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Max. Repayment Period(Months)',style: styles,),
                                      Text('${loanProducts[index]['maxRepPeriod'] ?? 0}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Min. Interest Rate',style: styles,),
                                      Text('${loanProducts[index]['minInterestRate']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Max. Interest Rate',style: styles,),
                                      Text('${loanProducts[index]['maxInterestRate']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Grace Period (Months)',style: styles,),
                                      Column(children: [
                                        Row(
                                          children: [
                                            Text("Min.",style: styles,),
                                            Text('${loanProducts[index]['gracePeriodMin']}',style: styles2,)
                                          ],
                                        ),
                                        SizedBox(height: height * 0.01,),
                                        Row(
                                          children: [
                                            Text("Max.",style: styles,),
                                            Text('${loanProducts[index]['gracePeriodMax']}',style: styles2,)
                                          ],
                                        )
                                      ],),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Arrears Tolerance Amount',style: styles,),
                                      Text('${loanProducts[index]['arrearsToleranceAmt']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Code',style: styles,),
                                      Text('${loanProducts[index]['code']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Min. Amount',style: styles,),
                                      Text('${loanProducts[index]['minAmount'] ?? 0}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Max. Amount',style: styles,),
                                      Text('${loanProducts[index]['maxAmount'] ?? 0}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Can Use guarantors?',style: styles,),
                                      Text('${loanProducts[index]['useGuarantors']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Can Use Collateral?',style: styles,),
                                      Text('${loanProducts[index]['useCollaterals']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loan Status',style: styles2,),
                                      Text('${loanProducts[index]['status']}',style: styles2,)
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){},
                                        child: Text(
                                          'Check Eligibility',
                                          style: TextStyle(
                                            fontFamily: "Muli",
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding:  EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context, customePageTransion(LoanRequestForm(productId: loanProducts[index]['id'],)));
                                        },
                                        child: Text(
                                          'Request Loan',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding:  EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ) : Text(''),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: loanProducts.length,
                  // shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                ),
              ],
            )
        )


    );
  }
}
