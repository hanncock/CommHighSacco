import 'package:ezenSacco/disp_pages/attach_files.dart';
import 'package:flutter/material.dart';
import '../../models/class profModel.dart';
import '../../utils/formatter.dart';
import '../../widgets/backbtn_overide.dart';
import '../../widgets/profModelView.dart';
import '../../wrapper.dart';
import '../guarantorslist.dart';
import 'loan_description.dart';
import 'loan_ledger.dart';
import 'loan_schedule.dart';

class LoanDetails extends StatefulWidget {
  final loanvalues;
  const LoanDetails({Key? key,required this.loanvalues}) : super(key: key);

  @override
  State<LoanDetails> createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {

  // acceptApplication
  var title = 'Details';
  late Widget screen ;//= LoanDescription(lonvalues: loanvalues,);

  late final profMockData = [
    ProfModel(
      active: false,

      label: 'Details',
      route: '',
      widget: LoanDescription(lonvalues: widget.loanvalues,),
    ),
    ProfModel(
      active: false,

      label: 'Schedules',
      route: '',
      widget: LoanSchedule(loanId: widget.loanvalues['id'].toString()),
    ),
    ProfModel(
      active: false,

      label: 'Ledger',
      route: '',
      widget: LoanLedger(LoanLedgerId: widget.loanvalues['ledgerId'].toString(),),
    ),
    ProfModel(
      active: false,

      label: 'Files',
      route: '',
      widget: AttachFile(loanvalues: widget.loanvalues,),
    ),
    ProfModel(
      active: false,

      label: 'Guarantors',
      route: '',
      widget: Guarantorslist(loanId: widget.loanvalues),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      screen = LoanDescription(lonvalues: widget.loanvalues);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text(
          '${widget.loanvalues['product']}\t(${formatCurrency(widget.loanvalues['loanAmount'])})',
          style: TextStyle(
              color:Color(0xFF5C000E),
              fontFamily: "Muli"
          ),
        ),
        centerTitle: true,



        backgroundColor: Colors.white,
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200]
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: profMockData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        childAspectRatio : MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 8),
                        crossAxisCount: profMockData.length,),
                      itemBuilder: (context, index){
                        return InkWell(
                            onTap: (){
                              setState(() {
                                title = profMockData[index].label;
                                screen = profMockData[index].widget;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: title == profMockData[index].label ? Colors.redAccent: Colors.grey[200],
                                ),
                                child: ProfView(profModel: profMockData[index],)
                            )
                        );
                      }),
                )
            ),
          ),
          screen

        ],
      ),
    );
  }
}
