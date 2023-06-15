import 'package:ezenSacco/utils/formatter.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../widgets/backbtn_overide.dart';
import '../../widgets/spin_loader.dart';
import '../../wrapper.dart';

class LoanCalc extends StatefulWidget {
  const LoanCalc({Key? key}) : super(key: key);

  @override
  State<LoanCalc> createState() => _LoanCalcState();
}

class _LoanCalcState extends State<LoanCalc> {

  final _formKey = GlobalKey<FormState>();

  var selectedAmount;
  var interstRate;
  var numInstal;
  var instalAmnt;
  List interestsTypes = ['FLAT_INTEREST','FLAT_INTEREST_EMI','FLAT_INTEREST_ON_PRINCIPAL_AMOUNT','REDUCING_INTEREST','REDUCING_INTEREST_EMI'];
  var intType = 'REDUCING_INTEREST_EMI';
  List interestFrequencies = ['DAILY','WEEKLY','MONTHLY','ANNUALLY'];
  var intFreq = 'ANNUALLY';
  List repaymentFrequencies = ['DAILY','WEEKLY','MONTHLY','ANNUALLY'];
  var repaymentFrequency = 'ANNUALLY';
  final AuthService auth = AuthService();
  bool showCalc = false;
  bool moreOptions = false;
  var calculationProjections;
  bool loading = false;
  final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.04);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          "Loan Calculator",
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli",
            fontSize: width * 0.04
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Loan Amount & Interest Parameters',style: styles,),
                      SizedBox(height: 10,),
                      Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              children: [
                                // Text('Loan Amount'),
                                Container(
                                  width: width * 0.45,
                                  child: TextFormField(
                                    // enabled: isenabled,
                                    keyboardType: TextInputType.number,
                                    validator: (val) => val!.isEmpty ? "Loan Amount " : null,
                                    onChanged: (val) {setState(() {
                                      selectedAmount = val;
                                    });},
                                    // onChanged: (val){setState((){
                                    //   selectedAmount = double.parse(val);
                                    //   if(selectedAmount > loanLimit){
                                    //     Fluttertoast.showToast(
                                    //         msg:  'Cannot Request Higher Amounts than Available Account Limit Please contact your Sacco for more info',
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.CENTER,
                                    //         timeInSecForIosWeb: 1,
                                    //         //backgroundColor: Colors.white,
                                    //         textColor: Colors.redAccent,
                                    //         fontSize: 16.0
                                    //     );
                                    //     selectedAmount = loanLimit;
                                    //   }
                                    //   if(selectedAmount == 0){
                                    //     selectedAmount = loanLimit;
                                    //   }
                                    //   // refresh;
                                    // });},
                                    // onEditingComplete: ((){
                                    //   setState(() {
                                    //     data = null;
                                    //   });
                                    //       ()async{
                                    //     print(selectedAmount);
                                    //
                                    //     // data = null;
                                    //     print('fetching new values');
                                    //     var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                                    //     print('done');
                                    //     print(res);
                                    //     setState((){
                                    //       data = res;
                                    //     });
                                    //   };
                                    // }),
                                    // onEditingComplete: () => (setState(()async{
                                    //   var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                                    //   print(res);
                                    //   // data = res;
                                    // })),
                                    // initialValue: selectedAmount.toString() ,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    // ],
                                    decoration: InputDecoration(
                                      // suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                                      labelText: "Loan Amount",
                                      floatingLabelAlignment: FloatingLabelAlignment.center,
                                      floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                // Text('Interest Rate'),
                                Container(
                                  width: width * 0.45,
                                  child: TextFormField(
                                    // enabled: isenabled,
                                    keyboardType: TextInputType.number,
                                    validator: (val) => val!.isEmpty ? "Interest rate " : null,
                                    onChanged: (val){
                                      setState(() {
                                        interstRate = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      // suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                                      labelText: "Interest Rate",
                                      floatingLabelAlignment: FloatingLabelAlignment.center,
                                      floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Specify Installment Period or amount',style: styles,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            children: [
                              // Text('Loan Amount'),
                              Container(
                                width: width * 0.45,
                                child: TextFormField(
                                  enabled: instalAmnt==null,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val!.isEmpty ? "Amount to Pay " : null,
                                  onChanged: (val){
                                    setState(() {
                                      numInstal= val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Installment Period",
                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                    floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.redAccent),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              // Text('Interest Rate'),
                              Container(
                                width: width * 0.45,
                                child: TextFormField(
                                  enabled: numInstal==null,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val!.isEmpty ? "Amount to Pay " : null,
                                  onChanged: (val){
                                    setState(() {
                                      instalAmnt = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    // suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                                    labelText: "Installment Amount",
                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                    floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.redAccent),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                moreOptions ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Interest Type',style: styles,),
                          Container(
                            width: width * 0.45,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: intType,
                                  style: TextStyle(fontSize: width * 0.035,color: Colors.black87),
                                  items: interestsTypes.map((e){
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Text('${e}'));
                                  }).toList(),
                                  onChanged: (e){
                                    setState(() {
                                      intType = e.toString();
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SizedBox(
                            width: width * 0.3,
                            child: Text('Interest Frequency',style: styles,),
                          ),
                          Container(
                            width: width * 0.45,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: intFreq,
                                  style: TextStyle(fontSize: width * 0.035,color: Colors.black87),
                                  items: interestFrequencies.map((e){
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Text('${e}'));
                                  }).toList(),
                                  onChanged: (e){
                                    setState(() {
                                      intFreq = e.toString();
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.45,
                            child:Text('Repayment Frequency',style: styles,),
                          ),
                          Expanded(
                            child: Container(
                              width: width * 0.45,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    isExpanded: true,
                                    value: repaymentFrequency,
                                    style: TextStyle(fontSize: width * 0.035,color: Colors.black87),
                                    items: repaymentFrequencies.map((e){
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Text('${e}'));
                                    }).toList(),
                                    onChanged: (e){
                                      setState(() {
                                        repaymentFrequency = e.toString();
                                      });
                                    }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          moreOptions =! moreOptions;
                        });
                      },
                      child: Text(
                        'Show Less',
                        style: TextStyle(
                            color: Colors.blue
                        ),
                      ),
                    ),
                  ],
                ): InkWell(
                  onTap: (){
                    setState(() {
                      moreOptions =! moreOptions;
                    });
                  },
                  child: Text(
                    'More Options',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.blue
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:  EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    onPressed: (()async{
                      if (_formKey.currentState!.validate()) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          loading = true;
                          showCalc = true;
                        });
                        // var resu = await auth.calcLoan(selectedAmount, interstRate, numInstal, instalAmnt);
                        var resu = await auth.loanProjections(selectedAmount, 0, interstRate, numInstal, instalAmnt, intType, intFreq, repaymentFrequency);
                        print(resu);
                        setState(() {
                          calculationProjections = resu;
                          loading = false;
                        });
                      }

                    }),
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.02,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Show Calculations',style: TextStyle(
                              color: Colors.white
                          ),),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          showCalc ? Flexible(
            child: SingleChildScrollView(
              child: loading ? LoadingSpinCircle() : Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Text('Repayment Schedule'),
                    Card(
                      child: Card(
                        elevation: 0,
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Principal',style: styles,),
                                      Text(''),
                                      Text('${calculationProjections['totalPrincipal']}',style: styles,)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Interest',style: styles,),
                                      Text(''),
                                      Text('${calculationProjections['totalInterest']}',style: styles,)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Payment',style: styles,),
                                      Text(''),
                                      Text('${calculationProjections['totalPayment']}',style: styles,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Monthly Payment',style: styles,),
                                      Text(''),
                                      Text('${calculationProjections['monthlyPayment']}',style: styles,)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Installment Period',style: styles,),
                                      SizedBox(width: 30,),
                                      Text('${calculationProjections['numberOfInstallments']}',style: styles,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount:calculationProjections['schedules'].length ?? 0,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: ( context, index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text('${index}'),
                                  SizedBox(width: 30,),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('LoanBal',style: styles,),
                                            Text('${formatCurrency(calculationProjections['schedules'][index]['principalApplied'].ceil())}',style: styles,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Principal applied',style: styles,),
                                            Text('${formatCurrency(calculationProjections['schedules'][index]['principalPayment'].ceil())}',style: styles,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Interest',style: styles,),
                                            Text('${formatCurrency(calculationProjections['schedules'][index]['interestPayment'].ceil())}',style: styles,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Total Payment',style: styles,),
                                            Text('${formatCurrency(calculationProjections['schedules'][index]['totalPayment'].ceil())}',style: styles,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Cummulative Interest',style: styles,),
                                            Text('${formatCurrency(calculationProjections['schedules'][index]['cumulativeInterest'].ceil())}',style: styles,)
                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding:  EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                        onPressed: ((){
                        }),
                        child: Container(
                          width: width * 0.5,
                          height: height * 0.02,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Save',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ],
                          ),
                        )
                    ),
                    Text('')
                  ],
                ),
              ),
            ),
          ): Text('')
        ],
      ),
    );
  }
}
