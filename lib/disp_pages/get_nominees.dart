import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';
import '../services/auth.dart';
import '../utils/formatter.dart';
import '../widgets/backbtn_overide.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';
import 'dart:math' as math;
class GetNomineed extends StatefulWidget {
  const GetNomineed({Key? key}) : super(key: key);

  @override
  State<GetNomineed> createState() => _GetNomineedState();
}

class _GetNomineedState extends State<GetNomineed> {

  final AuthService auth = AuthService();
  List nominees = [];
  var nomineeName;
  var nomineeId;
  var nomineeAddr;
  var nomineePhone;
  var updateId;
  bool addNominees = false;
  List tenants1 = [];
  var selectedDate = DateTime.now();
  List relation = ['WIFE','HUSBAND','SON','DAUGHTER','FATHER','MOTHER','BROTHER','SISTER','OTHERS'];
  var selRelation;

  getNominees()async{
    var resu = await auth.getNominees();
    print(resu);
    setState((){
      nominees = resu['list'];
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getNominees();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [


          addNominees ? Text(''):Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              ElevatedButton(
                child: Text(
                  '+ Add Nominee',
                  style: TextStyle(
                    letterSpacing: .5,
                    color: Colors.white,fontFamily: "Muli",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.8),
                  padding:  EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    addNominees = !addNominees;
                  });
                },
              ),
            ],
          ),
          addNominees ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: height * 0.6,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    initialValue: nomineeName,
                    validator: (val) => val!.isEmpty ? "Enter  filename" : null,
                    onChanged: (val){setState(() => nomineeName = val);},
                    decoration: InputDecoration(
                      hintText: 'Name',
                      // suffixIcon: Icon(Icons.file_copy_rounded),
                      labelText: "Name",
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    initialValue: nomineeId,
                    validator: (val) => val!.isEmpty ? "Enter  filename" : null,
                    onChanged: (val){setState(() => nomineeId = val);},
                    decoration: InputDecoration(
                      hintText: 'Id Number',
                      // suffixIcon: Icon(Icons.file_copy_rounded),
                      labelText: "Id Number",
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  DropdownButton2(
                    isExpanded: true,
                    // value: ,
                    hint: Text('${selRelation ?? ''}',style: TextStyle(fontSize: width * 0.035)),
                    items: relation.map((list){
                      return DropdownMenuItem(
                        child: Text('${list}',style: TextStyle(fontSize: width * 0.035),),
                        value: list.toString(),
                      );
                    },).toList(),
                    onChanged: (value)=>setState(() {
                      selRelation = value;

                    }),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      maxHeight: height*0.6,
                    ),
                    barrierColor: Colors.black45,
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Container(
                          // color: Colors.blueAccent,
                            decoration: BoxDecoration(
                                color:  Colors.blueAccent.withOpacity(0.9),
                                // color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Select D.O.B ',style: TextStyle(color: Colors.white),),
                            )),
                      ),
                      Text('${f.format(selectedDate) ?? ''}')
                    ],
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    initialValue: nomineeAddr,
                    validator: (val) => val!.isEmpty ? "Enter  Address" : null,
                    onChanged: (val){setState(() => nomineeAddr = val);},
                    decoration: InputDecoration(
                      hintText: 'P.O Box 12343 ',
                      // suffixIcon: Icon(Icons.file_copy_rounded),
                      labelText: "Address",
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    initialValue: nomineePhone,
                    validator: (val) => val!.isEmpty ? "Phone Number" : null,
                    onChanged: (val){setState(() => nomineePhone = val);},
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      // suffixIcon: Icon(Icons.file_copy_rounded),
                      labelText: "Phone Number",
                      hintStyle: TextStyle(fontSize: width * 0.04),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding:  EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: ()async{

                              // if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context, builder: (_) => LoadingSpinCircle()
                              );
                              // uploadFile();
                              // }

                              var resu = await auth.addNominees(updateId, nomineeId, nomineeName, selRelation, f.format(selectedDate), nomineeAddr, nomineePhone);
                              print(resu);
                              if(resu['success'] == 'true'){
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
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              Navigator.of(context).pop();
                              setState(() {
                                addNominees =! addNominees;
                              });

                            }, child: Text('Add Nominee')),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ) :Text(''),
          addNominees ?? nominees.length == 0 ? Text('') :Container(
            height: height * 0.56,
            child: ListView.builder(
                itemCount: nominees.length,
                itemBuilder: (BuildContext context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],//Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                            radius: 30,
                            // child: Icon(Icons.person_outline,)
                            child: Text('${getInitials(nominees[index]['name'] ?? '')}',style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${nominees[index]['name'] ?? ''} (${nominees[index]['relation'] ?? ''} )',
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text('${nominees[index]['dob'] == null ? '':f.format(new DateTime.fromMillisecondsSinceEpoch(nominees[index]['dob']))}',
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('\t'),

                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
