import 'dart:async';

import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../services/auth.dart';
import '../widgets/backbtn_overide.dart';
import '../widgets/spin_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Guarantorslist extends StatefulWidget {
  final loanId;
  const Guarantorslist({Key? key,required this.loanId}) : super(key: key);

  @override
  State<Guarantorslist> createState() => _GuarantorslistState();
}

class _GuarantorslistState extends State<Guarantorslist> {

  final TextEditingController textEditingController = TextEditingController();
  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  List guarantorslst = [];
  List addedguarantorslst = [];
  var selcted_guarantor;
  List selectedIndexes = [];
  List guaranteedAmnt = [];
  var guarantorRegNote;
  var guarantorRegAmnt;

  List requested_Guarantors = [];
  bool nodata2 = false;
  bool initial_load2 = true;
  var currentarray;
  getList() async {
    var response = await auth.membersList();
    print(response);
    if (response['count'] == 0) {
      setState(() {
        initial_load = false;
        nodata = true;
      });

      // int i
    } else {
      setState(() {
        nodata = false;
        initial_load = false;
        guarantorslst = response['list'];
        print(guarantorslst);
        // guaranteedAmnt = formatCurrency(guarantorslst['guaranteedAmount'].reduce((a, b) => a + b));
      });
    }
  }



  requestLoans(mbrId)async{
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        // title: Text('Success!'),
          content: LoadingSpinCircle()
      ),
    );
    print('${widget.loanId["id"]}, ${mbrId}');
    var response = await auth.requestGuarantorship(widget.loanId["id"], mbrId,guarantorRegAmnt,guarantorRegNote);
    if(response['success'] == 'true' ){
      print('clearing');
      addedguarantorslst.clear();
      setState(() {

      });
    }
    print(response);
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        // title: Text('Success!'),
          content: response['success'] == 'true' ?
          Text("Request Succesful",style: TextStyle(color: Colors.green),):
          Text('Error : ${response}',style: TextStyle(color: Colors.redAccent),)
      ),
    );
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
    });

  }

  requestedGuarantors()async{
    var response = await auth.guarantors_guaranteedloan(widget.loanId["id"],);
    print(response);

    if (response['count'] == 0) {
      setState(() {
        initial_load = false;
        nodata = true;
      });
    } else {
      setState(() {
        nodata2 = false;
        initial_load2 = false;
        requested_Guarantors = response['list'];
        print(requested_Guarantors);
      });
    }
  }

  @override
  void initState() {
    getList();
    requestedGuarantors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
    final styles2 = TextStyle(fontFamily: 'Muli',color: Colors.black45,fontSize: width * 0.035);
    return widget.loanId['acceptApplication'].toString().toUpperCase()== 'NO' ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Please Await Loan Approval to continue'),
      ],
    ):Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Number of Requests Sent:'),
                    Text('${requested_Guarantors.length}')
                  ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Total Amnt Guaranteed:'),

                        // Text('${ guaranteedAmnt.isNotEmpty ? formatCurrency(guaranteedAmnt.reduce((a, b) => a + b)) : 0}'),
                        // Text('${ guarantorslst.map((bill) => bill['guaranteedAmount'] ?? 0).reduce((acc, bill) => bill + acc)}')
                        // Text('${ guarantorslst[2]['guaranteedAmount']}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Approved Guarantors:'),
                        // Text('${ guarantorslst.map((bill) => bill['status'].toString().toUpperCase() == 'APPROVED').reduce((acc, bill) => bill + acc)}'),
                      ],
                    ),
                  )
                ],)
            ],),
        ),
        Divider(),
        Container(
          height: height * 0.7,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.blue[800],
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.blue[800],
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Request Guarantors',style: TextStyle(fontSize: width * 0.035),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Requested Guarantors',style: TextStyle(fontSize: width * 0.035),),
                    )
                  ],),
                Text(''),
                Divider(),
                // Container(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         Column(
                //           children: [
                //             Text('Loan id',style: styles,),
                //             Text(''),
                //             Text('${widget.loanId["loanNumber"]}',style: styles2,),
                //           ],
                //         ),
                //         Text(''),
                //         Expanded(
                //           child: Column(
                //             children: [
                //               Text('Interest type',style: styles,),
                //               Text(''),
                //               Text('${widget.loanId["loanType"]}',style: styles2,),
                //             ],
                //           ),
                //         ),
                //         Text(''),
                //         Column(
                //           children: [
                //             Text('Loan Amount',style: styles,),
                //             Text(''),
                //             Text('${formatCurrency(widget.loanId["loanAmount"])}',style: styles2,),
                //           ],
                //         )
                //
                //       ],
                //     ),
                //   ),
                // ),
                Flexible(
                    child: TabBarView(
                      children: [
                        initial_load?
                        LoadingSpinCircle():
                        // nodata ?
                        // Center(
                        //   child: Text(
                        //     'Sorry !\n\nNo Members to request ',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Colors.blue,
                        //         fontSize: 20,
                        //         fontFamily: "Muli"
                        //     ),
                        //   ),):
                        widget.loanId['status'].toString().toUpperCase() == 'APPROVED' ? Center(child: Text('Loan Has been approved')) : Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Search a member from the drodown list, then Click on member /members to request Guarantorship',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontFamily: "Muli"
                                ),),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<dynamic>(
                                          isExpanded: true,
                                          // value: ,
                                          hint: Text('${selcted_guarantor ?? 'search '}',style: TextStyle(fontSize: width * 0.035)),
                                          items: guarantorslst.map((list){
                                            return DropdownMenuItem(

                                              child: Text('${list['memberNo']}, ${list['firstName'] ?? ''} ${list['surname']}',style: TextStyle(fontSize: width * 0.035),),
                                              // value: currentarray.add(),
                                              value: {"id":list['id'],"memberId":list['memberId'],"memberNo":list['memberNo'],"firstName":list['firstName']??'',"surname":list['surname'].toString()},
                                            );
                                          },).toList(),
                                          onChanged: (value)=>setState(() {
                                            print(value);
                                            addedguarantorslst.length;
                                            // int i;
                                            for(var i = 0; i <  addedguarantorslst.length; i++){
                                              // list.add(new Text(strings[i]));
                                            }
                                            addedguarantorslst.contains(value == value)?
                                            print('contains value') :
                                            addedguarantorslst.add(value);
                                            print(addedguarantorslst);
                                            print(selectedIndexes);
                                          }),
                                          dropdownSearchData: DropdownSearchData(
                                            searchController: textEditingController,
                                            searchInnerWidgetHeight: height*0.6,

                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                controller: textEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText: 'Search for Member...',
                                                  hintStyle: const TextStyle(fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                onChanged: (text){

                                                },
                                              ),
                                            ),
                                          ),
                                          barrierColor: Colors.black45,

                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: addedguarantorslst.length,
                                        itemBuilder: (context,index){
                                          return Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: InkWell(
                                              onTap: (){
                                                // print(addedguarantorslst[index]['memberNo']);
                                                // selectedIndexes.contains(addedguarantorslst[index]['memberNo'])?
                                                // setState(() {
                                                //   print('removing value');
                                                //   selectedIndexes.remove(addedguarantorslst[index]['memberNo']);
                                                // }) :
                                                // setState(() {
                                                //   requestLoans(addedguarantorslst[index]['memberId']);
                                                //   print('adding value');
                                                //   selectedIndexes.add(addedguarantorslst[index]['memberNo']);
                                                // });
                                              },
                                              child: Card(
                                                  color: selectedIndexes.contains(addedguarantorslst[index]['memberNo']) ? Colors.lightBlueAccent.withOpacity(0.3): Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Card(
                                                              elevation: 0,
                                                              color: Colors.blue,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Icon(Icons.person_outline_rounded,color: Colors.white,),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('${addedguarantorslst[index]['memberNo']}',style: styles,),
                                                                      SizedBox(width: 10,),
                                                                      SizedBox(width: 10,),
                                                                      Text('${addedguarantorslst[index]['firstName'] ?? ''}  ${addedguarantorslst[index]['surname'] ?? ''}',style: styles,),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  Container(
                                                                    // width: 200,
                                                                    child: TextFormField(
                                                                      onChanged: (val){setState((){
                                                                        guarantorRegNote = val;

                                                                      },
                                                                      );},

                                                                      decoration: InputDecoration(
                                                                        suffixIcon: Icon(Icons.money_off,color: Colors.green,),
                                                                        labelText: "Amount",
                                                                        floatingLabelAlignment: FloatingLabelAlignment.center,
                                                                        floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        border: OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Colors.redAccent),
                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),


                                                          ],
                                                        ),
                                                        SizedBox(height: 20,),
                                                        TextFormField(
                                                          onChanged: (val){setState((){
                                                            guarantorRegNote = val;

                                                          },
                                                          );},
                                                          minLines: 2,
                                                          maxLines: 2,
                                                          decoration: InputDecoration(
                                                            suffixIcon: Icon(Icons.edit_note_outlined,color: Colors.green,),
                                                            labelText: "Request Description (optional)",
                                                            floatingLabelAlignment: FloatingLabelAlignment.center,
                                                            floatingLabelStyle: TextStyle(color: Colors.green,fontFamily: "Muli"),
                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                            border: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.redAccent),
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.redAccent,
                                                              padding:  EdgeInsets.all(10.0),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                            ),
                                                            onPressed: (){
                                                              requestLoans(addedguarantorslst[index]['id']);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Request',style: styles,),
                                                                Icon(Icons.send)
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        initial_load2 ? Center(child: LoadingSpinCircle(),):
                        Column(
                          children: [
                            Text(''),
                            Flexible(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: requested_Guarantors.length,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: InkWell(
                                        onTap: (){
                                        },
                                        child: Card(
                                          // color: requested_Guarantors[index]['status'] == null? Colors.orange :
                                          // requested_Guarantors[index]['status'] == 'APPROVED'? Colors.green :
                                          // requested_Guarantors[index]['status'] == 'REJECTED'? Colors.red: Colors.grey.shade200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Card(
                                                        elevation: 0,
                                                        color: Colors.blue,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Icon(Icons.person_outline_rounded,color: Colors.white,),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Text('${requested_Guarantors[index]['memberNo']}',style: styles,),
                                                            SizedBox(width: 10,),
                                                            Text('${requested_Guarantors[index]['memberName'] ?? ''}',style: styles,),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        color: requested_Guarantors[index]['status'] == null? Colors.orange :
                                                        requested_Guarantors[index]['status'] == 'APPROVED'? Colors.green :
                                                        requested_Guarantors[index]['status'] == 'REJECTED'? Colors.red: Colors.grey.shade200,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text('${requested_Guarantors[index]['status'] ?? 'PENDING'}',style: styles,),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('Amount Requested',style: styles2,),
                                                        Text('${formatCurrency(requested_Guarantors[index]['guaranteedAmountReq']) ?? ''}'),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                      children: [
                                                        Text('Amount Guarenteed',style: styles2,),

                                                        Text('${formatCurrency(requested_Guarantors[index]['guaranteedAmount']) ?? ''}'),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${requested_Guarantors[index]['guaranteeApprovalMsg'] ?? ''}',style: styles2,),
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
