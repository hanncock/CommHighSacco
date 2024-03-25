import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/auth.dart';
import '../../wrapper.dart';

class LoanRequestForm extends StatefulWidget {
  const LoanRequestForm({Key? key, required this.productId}) : super(key: key);
  final  productId;
  @override
  _LoanRequestFormState createState() => _LoanRequestFormState();
}

class _LoanRequestFormState extends State<LoanRequestForm> {

  final AuthService auth = AuthService();
  var loanLimit =0.0;
  int maxRepaymentFreq = 0;
  var selectedAmount = 0.0;
  var data;
  var values ;
  var interstRate ;
  var numInstal;
  var intType;
  var intFreq;
  var repayFreq;
  bool data2 = true;
  bool showProjection = false;

  void refresh(){
    setState((){});
  }

  loansAmount () async{
    var response = await auth.getLoanLimit(widget.productId);
    print(response);
    if(response==null){
      // initial_load = false;
      // nodata = true;
    }else{
      setState(() {
        data = response;
        loanLimit = double.parse(response['maxAllowedLoanAt'].toString());
        selectedAmount = double.parse(response['maxAllowedLoanAt'].toString());
        values = response['projection']['schedules'];
        interstRate = data['interestRate'];
        numInstal = data['numberOfInstallments'];
        intType = data['loanType'];
        intFreq = data['interestFrequency'];
        repayFreq = data['numberOfInstallments'];
        maxRepaymentFreq = data['numberOfInstallments'];
        print(loanLimit);
        refresh();
      });
    }
  }

  loanprojections()async{
    var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, repayFreq, 0, intType, intFreq, repayFreq);
    print('found values');
    print(res);
    setState(() {
      data = res;
      values = res['schedules'];
      data2 = false;
    });

  }

  @override
  void initState() {
    loansAmount();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  var loanReqNotes;
  TextEditingController _messageCtrl = new TextEditingController(text: '');
  TextEditingController _fileCtrl = new TextEditingController(text: '');
  final style1 = TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.03);
  final style2 = TextStyle(fontFamily: "Muli",fontSize: width * 0.03);
  bool remember = false;
  final List<String> errors = [];
  bool showmore = false;

  bool isHidden = true;
  List<Map<String, dynamic>> categoryList = [
    {'value': 'Claims', 'display': 'Claims'},
    {'value': 'Statement Request', 'display': 'Statement Request'},
    {'value': 'Amendment Request', 'display': 'Amendment Request'},
    {'value': 'Enquiries', 'display': 'Enquiries'},
    {'value': 'Billing', 'display': 'Billing'},
    {'value': 'Other', 'display': 'Other'}
  ];
  var selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Request New Loan',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Max Amount:',style: style2,),
                          SizedBox(width: 30,),
                          Text('${formatCurrency(loanLimit.floor())}',style: style2,)
                        ],
                      ),
                    ),
                    Text('${formatCurrency(selectedAmount)}',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.1
                      ),),
                    SizedBox(height: height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width *0.6,
                          child: TextFormField(
                            // enabled: isenabled,
                            keyboardType: TextInputType.number,
                            validator: (val) => val!.isEmpty ? "Amount to Pay " : null,
                            onChanged: (val){setState((){
                              selectedAmount = double.parse(val);
                              if(selectedAmount > loanLimit){
                                Fluttertoast.showToast(
                                    msg:  'Cannot Request Higher Amounts than Available Account Limit Please contact your Sacco for more info',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    //backgroundColor: Colors.white,
                                    textColor: Colors.redAccent,
                                    fontSize: 16.0
                                );
                                selectedAmount = loanLimit;
                              }
                              if(selectedAmount == 0){
                                selectedAmount = loanLimit;
                              }
                              print('changing values');
                              setState((){
                                data =  null;
                              });
                              loanprojections();
                              // setState(()async{
                              //   var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                              //   print(res);
                              //   data = res;
                              // });
                              // refresh;
                            },
                            );},
                            // onEditingComplete: ((){
                            //   setState(() {
                            //     data = null;
                            //   });
                            //   ()async{
                            //   print(selectedAmount);
                            //
                            //   // data = null;
                            //   print('fetching new values');
                            //   var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                            //   print('done');
                            //   print(res);
                            //   setState((){
                            //     data = res;
                            //   });
                            // };
                            // }),
                            // onEditingComplete: () => (){
                            //   print('changing values');
                            //   setState((){
                            //     data =  null;
                            //   });
                            //   setState(()async{
                            //     var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                            //     print(res);
                            //     // data = res;
                            //   });
                            // },
                            initialValue: selectedAmount.toString() ,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.money_off,color: Colors.green,),
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
                        Container(
                          width: width *0.3,
                          child: data ==null ? SizedBox(): TextFormField(
                            // enabled: true,
                            keyboardType: TextInputType.number,
                            validator: (val) => val!.isEmpty ? "Installments " : null,
                            onChanged: (val){setState((){
                              repayFreq = int.parse(val);
                              if(repayFreq > maxRepaymentFreq){
                                Fluttertoast.showToast(
                                    msg:  'Installment can be greater than ${maxRepaymentFreq} or similar to 0',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    //backgroundColor: Colors.white,
                                    textColor: Colors.redAccent,
                                    fontSize: 16.0
                                );
                                repayFreq = maxRepaymentFreq;
                              }
                              if(repayFreq == 0){
                                repayFreq = maxRepaymentFreq;
                              }
                              print('changing values');
                              setState((){
                                data =  null;
                              });
                              loanprojections();
                              // setState(()async{
                              //   var res = await auth.loanProjections(selectedAmount, 0 ,interstRate, numInstal, 0, intType, intFreq, repayFreq);
                              //   print(res);
                              //   data = res;
                              // });
                              // refresh;
                            },
                            );},
                            initialValue: data['numberOfInstallments'].toString(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              // suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                              labelText: "Installements",
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
                    SizedBox(height: height * 0.01,),
                    TextFormField(
                      onChanged: (val){setState((){
                        loanReqNotes = val;

                      },
                      );},
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit_note_outlined,color: Colors.green,),
                        labelText: "Loan Description (optional)",
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding:  EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                        onPressed: (()async{
                          var resu = await auth.requestLoan(widget.productId, selectedAmount, repayFreq,loanReqNotes);
                          print(resu);
                          if(resu['message']=='Successful'){
                            Fluttertoast.showToast(
                                msg:  resu['message'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            Navigator.of(context).pop();
                          }else{
                            Fluttertoast.showToast(
                                msg:  resu['message'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                //backgroundColor: Colors.white,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }),
                        child: Container(
                          width: width * 0.5,
                          // height: height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.money_off,color: Colors.white,),
                              Text('Request Loan',style: TextStyle(
                                  color: Colors.white
                              ),),
                              Icon(Icons.money_off,color: Colors.white,),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: height * 0.01,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey[200],
                width: width,
                height: height * 0.7,
                child: Column(
                  children: [
                    data == null ? LoadingSpinCircle() : data2 ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Loan Variables',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              // fontSize: width * 0.04
                            ),),
                            Text(''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Loan Type:',style: style1,),
                                    // SizedBox(height: height * 0.01,),
                                    Text(
                                      '${data['loanType'] ?? '-'}',
                                      style: style2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Interest Freq:',style: style1,),
                                    // SizedBox(height: height * 0.01,),
                                    Text('${data['interestFrequency'] ?? 0}',
                                      style: style2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Text(''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Repayment Freq:',style: style1,),
                                    // SizedBox(height: height * 0.01,),
                                    Text('${data['repaymentFreq'] ?? '-'}',style: style2,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('No. of Installments:',style: style1,),
                                    SizedBox(height: height * 0.01,),
                                    Text('${data['numberOfInstallments'] ?? 0}',style: style2,),
                                  ],
                                ),
                              ],
                            ),
                            Text(''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Loan Product:',style: style1,),
                                    SizedBox(height: height * 0.01,),
                                    Text('${data['loanProduct']}',style: style2,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Interest Rate:',style: style1,),
                                    SizedBox(height: height * 0.01,),
                                    Text('${data['interestRate'] ?? 0.0}',style: style2,),
                                  ],
                                ),
                              ],
                            ),
                            Text(''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Monthly Payments',style: style1,),
                                    SizedBox(height: height * 0.01,),
                                    Text('${formatCurrency(data['monthlyPayment'] ?? formatCurrency(data['monthlyPayment'])?? 0.0)}',style: style2,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Mandatory Gurantee Val',style: style1,),
                                    SizedBox(height: height * 0.01,),
                                    Text('${formatCurrency(data['mandatoryGuaranteeVal'])?? 0.0}',style: style2,),
                                  ],
                                ),
                              ],
                            ),
                            // showmore ? Column(
                            //   children: [
                            //     Text(''),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [

                            //         Column(
                            //           children: [
                            //             Text('Mandatory Gurantee:',style: style1,),
                            //             SizedBox(height: height * 0.01,),
                            //             Text('${data['projection']['mandatoryGuarantee'] ??0.0}'),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     // Row(
                            //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     //   children: [
                            //     //     Column(
                            //     //       children: [
                            //     //         Text('Mandatory Gurantee Val',style: style1,),
                            //     //         SizedBox(height: height * 0.01,),
                            //     //         Text('${formatCurrency(data['projection']['mandatoryGuaranteeVal'])?? 0.0}'),
                            //     //       ],
                            //     //     ),
                            //     //     Column(
                            //     //       children: [
                            //     //         Text('Mandatory Gurantee:',style: style1,),
                            //     //         SizedBox(height: height * 0.01,),
                            //     //         Text('${data['projection']['mandatoryGuarantee']??0.0}'),
                            //     //       ],
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //   ],
                            // ) : GestureDetector(
                            //     onTap: ((){
                            //       setState(() {
                            //         showmore =! showmore;
                            //       });
                            //     }),
                            //     child: Text('\n show more',style: TextStyle(color: Colors.blue),))
                          ],
                        ),
                      ),

                    ) : Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Total Payment:',style: style1,),
                                        Text(''),
                                        Text('${formatCurrency(data['totalPayment'].ceil())}',style: style2,),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Total Interest:',style: style1,),
                                        Text(''),
                                        Text('${formatCurrency(data['totalInterest'].ceil())}',style: style2,),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Number of Installments',style: style1,),
                                        Text(''),
                                        Text('${formatCurrency(data['numberOfInstallments'].ceil())}',style: style2,),
                                      ],
                                    )
                                    // SizedBox(width: width * 0.05,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.01,),

                    data == null ? Center(child: LoadingSpinCircle()):
                    data2 ? Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  showProjection =! showProjection;
                                });
                              },
                              child: Card(
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Amortization Schedule',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      // fontSize: width * 0.04
                                    ),),
                                    Icon(
                                      showProjection ? Icons.expand_less_outlined:Icons.arrow_drop_down, size: width * 0.07,color: Colors.white,)
                                  ],
                                ),
                              ),
                            ),
                            // Text(''),
                            showProjection ? ListView.builder(
                                itemCount: data['projection']['schedules'].length ,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:  (context, index){
                                  return Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('${index + 1}'),
                                          SizedBox(width: width * 0.05,),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Interest Payment:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['interestPayment'].ceil())}',style: style2,),
                                                    // SizedBox(width: width * 0.05,)
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Cummulative Interest:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['cumulativeInterest'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Principal Payment:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['principalPayment'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Total Payment :',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['totalPayment'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Principal Applied:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['principalApplied'].ceil())}',style: style2,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }): Text(''),
                            Text('')
                          ],
                        ),
                      ),
                    ) :
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  showProjection =! showProjection;
                                });
                              },
                              child: Card(
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Loan Projections',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: width * 0.04
                                    ),),
                                    Icon(
                                      showProjection ? Icons.expand_less_outlined:Icons.arrow_drop_down, size: width * 0.07,color: Colors.white,)
                                  ],
                                ),
                              ),
                            ),
                            // Text(''),
                            showProjection ? ListView.builder(
                                itemCount: data['schedules'].length,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder:  (context, index){
                                  return Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('${index +1}'),
                                          SizedBox(width: width * 0.05,),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Interest Payment:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['interestPayment'].ceil())}',style: style2,),
                                                    // SizedBox(width: width * 0.05,)
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Cummulative Interest:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['cumulativeInterest'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Principal Payment:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['principalPayment'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Total Payment :',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['totalPayment'].ceil())}',style: style2,),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.01,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Principal Applied:',style: style1,),
                                                    SizedBox(width: width * 0.05,),
                                                    Text('${formatCurrency(values[index]['principalApplied'].ceil())}',style: style2,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }):
                            SizedBox(height: height *0.2,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  TextFormField buildAttachmentField() {
    return TextFormField(
      //  obscureText: isHidden,
      controller: _fileCtrl,
      //  onSaved: (newValue) => _passwordCtrl.text = newValue,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        //FocusScope.of(context).unfocus();
        if (result != null) {
          //File file = File(result.files.single.path);
          //File file = File(result.files.last);//result.file.single.path);

          setState(() {
            // _fileCtrl.text = file.path;
          });
        }
      },
      decoration: InputDecoration(
        // labelText: "Attachment",
        hintText: "Pick File",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        //floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }



  TextFormField sendTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      controller: _messageCtrl,
      maxLines: 5,
      onSaved: (newValue) => _messageCtrl.text = newValue!,
      validator: (value) {
        if (value!.isEmpty && !errors.contains('')) {
          setState(() {
            errors.add("Enter the Message!");
          });
          return "";
        }
        /*else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }*/
        return null;
      },
      decoration: InputDecoration(
        //labelText: "Message",
        hintText: "Enter Message",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //  suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}