import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../widgets/backbtn_overide.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({super.key});

  @override
  State<HelpDesk> createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {

  var textMeso;
  TextEditingController _control = TextEditingController();

  var start = ["~~Hello how may i be of help today~~\n"
      "below are some of the service i can offer\n"
      "(Please Select a number choise to proceed)\n"
      "1: Statement Download \n"
      "2: Loan Status \n"
      "3: Insert/ Update Next of kin \n"
      "4: Guarantor Request \n"
      "5: Guarantorsship Approval/Refusal \n"
  ];
  List allMessages = [

  ];

  _optioSelected(){
    switch(int.parse(textMeso)){
      case 1:
        allMessages.add(['On your home screen select the floating Statement icon on the lower right corner']);
        break;
      case 2:
        allMessages.add(['On your home screen under LOANS select the applications widet and your loans will be populated the navigate in the loans to see the status of loans applied']);
        break;
      case 3:
        allMessages.add(['On your home screen the floating circle on the right hand of opur name and just above the loans value click on it\n'
            'It will take you to your profile then select the nominees tab\n'
            'click on add to  input new next of kin']);
        break;
      default:
        allMessages.add(['For more info please contact your sacco admin']);
        break;
    }
  }

  void initState(){
    allMessages.add(start);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text('Help & Support',
          style: TextStyle(
              color: Colors.blue,
              fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Flexible(
              child: ListView.builder(
                  itemCount: allMessages.length,
                  itemBuilder: (context, index){
                    return Row(
                      mainAxisAlignment: allMessages[index][0] == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              color: allMessages[index][0] == 'user'? Colors.grey :Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${allMessages[index].length > 1?allMessages[index][1]: allMessages[index]}',style: TextStyle(color: Colors.white),),
                              )
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: Colors.black12
                  ),
                  width: width * 0.87,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                    child: TextField(
                      controller: _control,
                      decoration: InputDecoration(

                      ),
                      onChanged: (val){
                        textMeso = val;
                        setState(() {});
                      },
                      // onSubmitted: (val){
                      //   // setState(() {
                      //     textMeso = val;
                      //     setState(() {});
                      //   // });
                      //
                      // },
                    ),
                  ),
                ),
                InkWell(
                    onTap: (){
                      setState(() {
                        // Map<String, dynamic> textMessage = {};
                        var textMessage ;
                        textMessage = ["user",textMeso];
                        allMessages.add(["user",textMeso]);
                        _control.clear();
                      });
                      _optioSelected();
                    },
                    child: Icon(Icons.send,size:30,color: Colors.blue,))
              ],
            ),
          )
        ],
      ),
    );
  }
}
