import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/auth.dart';
import '../wrapper.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  var mbrNo;
  var idNo;
  String url = 'https://web.ezenfinancials.com';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(''),
              Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.05,
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontFamily: "Muli"
              ),
            ),
              Text(''),
              Container(
                  height:height * 0.15,
                  child: Image.asset('assets/app_icon.png')
              ),
              SizedBox(height: height * 0.15,),
              Form(
                key: _formKey,
                child: Container(
                  height: height* 0.3,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) => val!.isEmpty ? "Member No" : null,
                          onChanged: (val){setState(() => mbrNo = val);},
                          decoration: InputDecoration(
                            hintText: 'Member No',
                            suffixIcon: Icon(Icons.account_box),
                            labelText: "member no",
                            hintStyle: TextStyle(fontSize: width * 0.04),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        Text(''),
                        TextFormField(
                          validator: (val) => val!.isEmpty ? "Member Id Number" : null,
                          onChanged: (val){setState(() => idNo = val);},
                          decoration: InputDecoration(
                            hintText: 'Id No',
                            suffixIcon: Icon(Icons.account_box),
                            labelText: "Id No.",
                            hintStyle: TextStyle(fontSize: width * 0.04),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Forget password?',
                  //   style: TextStyle(fontSize: 12.0),
                  // ),
                  Expanded(
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          padding:  EdgeInsets.all(22.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context, builder: (_) => LoadingSpinCircle()
                            );
                            var res = await auth.CreateUser(mbrNo, idNo, url);
                            Navigator.pop(context);
                            print(res);
                            Navigator.pop(context);
                            if(res['success'] == 'false'){
                              setState(() {
                                loading = false;
                                Fluttertoast.showToast(
                                    msg:  res['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    //backgroundColor: Colors.white,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              });
                            }else{

                            }
                          }

                        },
                      ),
                    ),
                  ),
                  Text(''),
                  Text(''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
