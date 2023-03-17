import 'package:flutter/material.dart';

import '../Pages/forms/request_loan.dart';
import '../routes.dart';
import '../widgets/backbtn_overide.dart';

class Eligibility extends StatefulWidget {
  final eligibility;
  const Eligibility({Key? key, required this.eligibility}) : super(key: key);

  @override
  State<Eligibility> createState() => _EligibilityState();
}

class _EligibilityState extends State<Eligibility> {
  @override
  Widget build(BuildContext context) {
    print(widget.eligibility);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
    final styles2 = TextStyle(fontFamily: 'Muli',color: Colors.black45,fontSize: width * 0.035);

    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Eligibility Check',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15),
            child: Column(
              children: [
                // Text('Below are the requirements to qualify for this loan'),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    Text('${widget.eligibility['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: height * 0.018,fontFamily: 'Muli'))
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max. Repayment Period(Months)',style: styles,),
                        Text('${widget.eligibility['maxRepPeriod'] ?? 0}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min. Interest Rate',style: styles,),
                        Text('${widget.eligibility['minInterestRate']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max. Interest Rate',style: styles,),
                        Text('${widget.eligibility['maxInterestRate'] ?? ''}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grace Period (Months)',style: styles,),
                        Column(children: [
                          Row(
                            children: [
                              Text("Min.",style: styles,),
                              Text('${widget.eligibility['gracePeriodMin']}',style: styles2,)
                            ],
                          ),
                          SizedBox(height: height * 0.01,),
                          Row(
                            children: [
                              Text("Max.",style: styles,),
                              Text('${widget.eligibility['gracePeriodMax']}',style: styles2,)
                            ],
                          )
                        ],),
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Arrears Tolerance Amount',style: styles,),
                        Text('${widget.eligibility['arrearsToleranceAmt']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Code',style: styles,),
                        Text('${widget.eligibility['code']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min. Amount',style: styles,),
                        Text('${widget.eligibility['minAmount'] ?? 0}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max. Amount',style: styles,),
                        Text('${widget.eligibility['maxAmount'] ?? 0}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Can Use guarantors?',style: styles,),
                        Text('${widget.eligibility['useGuarantors']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Can Use Collateral?',style: styles,),
                        Text('${widget.eligibility['useCollaterals']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Status',style: styles2,),
                        Text('${widget.eligibility['status']}',style: styles2,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max Membership Period',style: styles,),
                        Text('${widget.eligibility['maxMembershipPeriod'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min Membership Period',style: styles,),
                        Text('${widget.eligibility['minMembershipPeriod'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min Member Age',style: styles,),
                        Text('${widget.eligibility['minMemberAge'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max Member Age',style: styles,),
                        Text('${widget.eligibility['maxMemberAge'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Individual Mbrs Allowed',style: styles,),
                        Text('${widget.eligibility['individualMemAllowed'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Joint Mbrs Allowed',style: styles,),
                        Text('${widget.eligibility['jointMemAllowed'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Group Members Allowed',style: styles,),
                        Text('${widget.eligibility['groupMemAllowed'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Business members Allowed',style: styles,),
                        Text('${widget.eligibility['bizzMemAllowed'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Guarantors Makeup',style: styles,),
                        Text('${widget.eligibility['guarantorsMakeUp'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Collateral makeup',style: styles,),
                        Text('${widget.eligibility['collateralMakeUp'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Max % Saving',style: styles,),
                        Text('${widget.eligibility['maxPercSaving'] ?? ''}',style: styles,)
                      ],
                    ),
                    SizedBox(height: height * 0.02,),Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, customePageTransion(LoanRequestForm(productId: widget.eligibility['id'],)));
                            },
                            child: Text(
                              'Request Loan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.04
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              padding:  EdgeInsets.all(18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
