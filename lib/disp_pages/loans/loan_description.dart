import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utils/formatter.dart';
import '../../wrapper.dart';

class LoanDescription extends StatefulWidget {
  final lonvalues;
  const LoanDescription({Key? key,required this.lonvalues}) : super(key: key);

  @override
  State<LoanDescription> createState() => _LoanDescriptionState();
}

class _LoanDescriptionState extends State<LoanDescription> {
  final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width* 0.04);
  final styles2 = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width* 0.04);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        // height: height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Loan Principle',style: TextStyle(color: Colors.grey)),
                          Text(''),
                          Text('${formatCurrency(widget.lonvalues['amountAppliedFor'])}' , style: styles,),
                        ],
                      ),
                    ),

                    IntrinsicHeight(child: VerticalDivider(thickness: 10,color: Colors.black,)),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Date Applied',style: TextStyle(color: Colors.grey),),
                        Text(''),
                        Text(f.format(new DateTime.fromMillisecondsSinceEpoch(widget.lonvalues['dateOfApplication'])),style: styles,),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Loan ID/No', style:styles,),
                  Text(''),
                  Text( widget.lonvalues['loanNumber'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount Applied',
                    style: styles,),
                  Text('${formatCurrency(widget.lonvalues['amountAppliedFor'])}',style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Disbursed Amount',
                    style: styles,),
                  Text( '${formatCurrency(widget.lonvalues['loanAmount'])}',style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Loan Period(Months)',
                    style: styles,),
                  Text( widget.lonvalues['numberOfInstallments'].toString() == null ? '' : widget.lonvalues['numberOfInstallments'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interest Type',
                    style: styles,
                  ),
                  // SizedBox(
                  //   width: width * 0.5,
                  //   child: Text(
                  //     textAlign: TextAlign.left,
                  //     softWrap:true,
                  //     widget.lonvalues['loanType'].toString(),style: styles2,
                  //   ),
                  // ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Interest Rate',
                    style: styles),
                  Text(widget.lonvalues['interestRate'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Fees',
                    style: styles,),
                  Text(widget.lonvalues['totalLoanFee'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Installment Amount',
                    style: styles),
                  Text( '${formatCurrency(widget.lonvalues['installmentAmount'])}',style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grace Period',
                    style: styles,),
                  Text(widget.lonvalues['gracePeriodMonths'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Repayment Frequency',
                    style: styles,),
                  Text( widget.lonvalues['repaymentFreq'].toString(),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Repayment Start Date',
                    style: styles),
                  Text(f.format(new DateTime.fromMillisecondsSinceEpoch(widget.lonvalues['dateOfApplication'])),style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Loan Balance',
                    style: styles,),
                  Text('${formatCurrency(widget.lonvalues['loanBalance'])}' ,style: styles2,),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Loan Status',
                    style:styles,),
                  Text(
                    widget.lonvalues['status'],
                    style: TextStyle(color: widget.lonvalues['status'] == 'PENDING' ? Colors.orange: widget.lonvalues['status'] == 'APPROVED' ? Colors.green : Colors.grey),
                  ),
                ],
              ),
              Divider(),
              // widget.lonvalues['submittedForAppraisal'].toString().toUpperCase() == 'YES' ?
              // ElevatedButton(
              //   onPressed: (){
              //     // Navigator.push(context, customePageTransion(Guarantorslist(loanId: widget.lonvalues)));
              //   },
              //   child: Text(
              //     'Request Guarantors',
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontFamily: "Muli",
              //         fontSize: width* 0.035
              //     ),
              //   ),
              //   // child: Icon(Icons.add_task_outlined),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.redAccent,
              //     padding:  EdgeInsets.all(10.0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ): SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
