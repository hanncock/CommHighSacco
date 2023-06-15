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
  List guarantorsId = [];
  var selcted_guarantor;
  List selectedIndexes = [];

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
      } else {
        setState(() {
          nodata = false;
          initial_load = false;
          guarantorslst = response['list'];
          print(guarantorslst);
        });
      }
  }

  requestLoansGuarantorship(mbrId)async{
    print('${widget.loanId["id"]}, ${mbrId}');
    var response = await auth.requestGuarantorship(widget.loanId["id"], mbrId);
    print(response);
    // Navigator.pop(context);
    if(response['success'] == 'true' ){
      Fluttertoast.showToast(
          msg: 'Succesful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        guarantorsId.removeWhere((element) => element == mbrId);
        addedguarantorslst.removeWhere((element) => element['id'] == mbrId);
      });
      // Navigator.pop(context);
    }else {
      Fluttertoast.showToast(
          msg: 'Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

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
    return  DefaultTabController(
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('Loan id',style: styles,),
                          Text(''),
                          Text('${widget.loanId["loanNumber"]}',style: styles2,),
                        ],
                      ),
                      Text(''),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Interest type',style: styles,),
                            Text(''),
                            Text('${widget.loanId["loanType"]}',style: styles2,),
                          ],
                        ),
                      ),
                      Text(''),
                      Column(
                        children: [
                          Text('Loan Amount',style: styles,),
                          Text(''),
                          Text('${formatCurrency(widget.loanId["loanAmount"])}',style: styles2,),
                        ],
                      )

                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.6,
                child: TabBarView(

                  children: [
                    if (initial_load) LoadingSpinCircle() else Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Search a member from the dropdown list, then Click on member /members to request Guarantorship',
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
                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    // value: ,
                                    hint: Text('${selcted_guarantor ?? 'search '}',style: TextStyle(fontSize: width * 0.035)),
                                    items: guarantorslst.map((list){
                                      return DropdownMenuItem(
                                        child: Text('${list['memberNo']}, ${list['firstName'] ?? ''} ${list['surname']}',style: TextStyle(fontSize: width * 0.035),),
                                       // value: currentarray.add(),
                                        value: [list['id'],{"id":list['id'],"memberId":list['memberId'],"memberNo":list['memberNo'],"firstName":list['firstName']??'',"surname":list['surname'].toString()}],
                                      );
                                    },).toList(),
                                    onChanged: (value)=>setState(() {
                                      var vals = value![1];
                                      print(value);
                                      if(guarantorsId.contains(value![0])){
                                        print('value exists');
                                      }else{
                                        guarantorsId.add(value![0]);
                                        addedguarantorslst.add(value![1]);
                                      }

                                      addedguarantorslst.length;
                                      // int i;
                                      // for(var i = 0; i <  addedguarantorslst.length; i++){
                                      //   // list.add(new Text(strings[i]));
                                      // }
                                      // addedguarantorslst.contains(value == value)?
                                      // print('contains value') :
                                      //
                                      print(addedguarantorslst);
                                      print(selectedIndexes);
                                    }),

                                    dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    dropdownMaxHeight: height*0.6,
                                    barrierColor: Colors.black45,
                                    searchController: textEditingController,
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
                                              child: Row(
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
                                                        Text('${addedguarantorslst[index]['memberNo']}',style: styles,),
                                                        SizedBox(width: 10,),
                                                        Text('${addedguarantorslst[index]['firstName'] ?? ''}  ${addedguarantorslst[index]['surname'] ?? ''}',style: styles,),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        // requestLoans(addedguarantorslst[index]['id']);
                                                        setState(() {
                                                          guarantorsId.remove(addedguarantorslst[index]['id']);
                                                          addedguarantorslst.remove(addedguarantorslst[index]);
                                                        });
                                                      },
                                                      child: Icon(Icons.cancel)
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            (guarantorslst.length !< 5 && guarantorslst.length  !> 8)? Text('${guarantorslst.length}'): Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding:  EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: (){
                                    guarantorsId.forEach((index) {
                                      print(index);
                                      requestLoansGuarantorship(index);
                                    });
                                    // requestLoansGuarantorship(addedguarantorslst[index]['id']);
                                    // requestLoans(addedguarantorslst[index]['id']);
                                    // setState(() {
                                    //   guarantorsId.remove(addedguarantorslst[index]['id']);
                                    //   addedguarantorslst.remove(addedguarantorslst[index]['id']);
                                    // });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Request',style: styles,softWrap: true,),
                                      SizedBox(width: 10,),
                                      Icon(Icons.send)
                                    ],
                                  )
                              ),
                            ) ,
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
                                          child: Row(
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
                                        )
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),

    );
  }
}
