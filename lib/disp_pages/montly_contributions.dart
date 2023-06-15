import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/disp_pages/savings/savings_account.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContributionsMonthly extends StatefulWidget {
  const ContributionsMonthly({Key? key}) : super(key: key);

  @override
  State<ContributionsMonthly> createState() => _ContributionsMonthlyState();
}

class _ContributionsMonthlyState extends State<ContributionsMonthly> {
  bool isenabled = false;
  bool isVisible = false;
  var accountRef = currentUserData['memberNo'].toString();
  var amntPayable;
  var phoneNumber = currentUserData['fixedPhone'].toString();
  var currentLoanBal;
  var bizShortCode;
  List data = [];
  bool loading = false;
  bool error = false;
  final _formKey = GlobalKey<FormState>();

  var userid = userData[1]['userId'];
  final AuthService auth = AuthService();

  getPabills()async{
    var paybills = await auth.getPaybills();
    print(paybills);
    setState(() {
      data = paybills['list'];
      print(data);
    });
  }

  @override
  void initState(){
    getPabills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(currentUserData);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
        children: [
          Container(
            height: height * 0.2,
            width: width,
            color: Colors.green,
            //decoration: BoxDecoration
            child: Center(
              child: Image.asset('assets/saf.png',color: Colors.white,),
            ),
            //color: Color.fromRGBO(102,255,0,0.9),
          ),

          Container(
            height: height * 0.53,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Name" : null,
                        onChanged: (val){setState(() => accountRef = val);},
                        initialValue: currentUserData['memberNo'] ,//! ? '': currentUserData['memberNo'] ,
                        //initialValue: (currentUserData['memberNo'] == null ? '' : currentUserData['memberNo']),//! ? '': currentUserData['memberNo'] ,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_balance_wallet_outlined,color: Colors.green,),
                          labelText: "Account Number",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli",fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Phone Number" : null,
                        onChanged: (val){setState(() => phoneNumber = val);},
                        initialValue: currentUserData['fixedPhone'],
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.phone_android_rounded,color: Colors.green,),
                          labelText: "Phone Number",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli",fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Paybill',
                              style: TextStyle(
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold,
                              ),),
                            DropdownButton(
                              value: bizShortCode,
                              items: data.map((list){
                                return DropdownMenuItem(
                                  child: Text(list['shortCode'],style: TextStyle(color: Colors.black87)),
                                  value: list['shortCode'].toString(),
                                );
                              },).toList(),
                              onChanged: (value)=>setState(() {
                                bizShortCode = value.toString();
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      InkWell(
                        onTap: (){

                          setState(() {
                            isVisible = !isVisible;
                          });
                          print('is visible $isVisible');
                        },
                        child: Text(
                            'Pay Through Other Phone Number ... ?',style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent
                        )),
                      ),
                      SizedBox(height: height * 0.04),
                      isVisible ?
                      TextFormField(
                        enabled: isVisible,
                        validator: (val) => val!.isEmpty ? "Name" : null,
                        keyboardType: TextInputType.number,
                        onChanged: (val){setState(() => phoneNumber = val);},
                        initialValue: currentUserData['fixedPhone'],
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.phone,color: Colors.green,),
                          labelText: "Enter Number",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ):
                      SizedBox(height: 0),
                      SizedBox(height: 20),

                      TextFormField(
                        // enabled: isenabled,
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? "Amount to Pay " : null,
                        onChanged: (val){setState(() => amntPayable = val);},
                        initialValue: (currentUserData['totalLoanBalance'] / 2).toString() ,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                          labelText: "Amount To Pay",
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli",fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding:  EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.push(context, customePageTransion(SavingsAccount()));
                                },
                                child: Text('Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Muli",
                                  ),)),
                            ElevatedButton(
                              child: Text(
                                'Make Payment',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Muli"
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:  EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () async{
                                if(bizShortCode == null){
                                  Fluttertoast.showToast(
                                    msg:  'Select Paybill'.toUpperCase(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    fontSize: 16.0,
                                  );
                                }else{
                                  if(amntPayable != 0){
                                    var result = await auth.lipaNaMpesa(bizShortCode, amntPayable, phoneNumber, accountRef);
                                    print(result);
                                    //print(bizShortCode); print(amount); print(phoneNumber); print(accountRef);
                                    if(result['success'] == "false" ){
                                      Fluttertoast.showToast(
                                        msg:  '${result['message']}'.toUpperCase(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.red,
                                        fontSize: 16.0,
                                      );
                                    }else{
                                      Fluttertoast.showToast(
                                        msg:  '${result['message']}'.toUpperCase(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.red,
                                        fontSize: 16.0,
                                      );
                                    }
                                  }else{
                                    Fluttertoast.showToast(
                                      msg:  'Amount Should be more than 0'.toUpperCase(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.red,
                                      fontSize: 16.0,
                                    );
                                  }
                                }

                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      // ),
    );
  }
}
