import 'package:ezenSacco/disp_pages/savings/savings_account.dart';
import 'package:flutter/material.dart';
import '../../widgets/backbtn_overide.dart';

class SavingsHome extends StatefulWidget {
  const SavingsHome({Key? key}) : super(key: key);

  @override
  State<SavingsHome> createState() => _SavingsHomeState();
}

class _SavingsHomeState extends State<SavingsHome> {

  var title = 'Savings';
  Widget screen = SavingsAccount();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text('Savings Products',
          style: TextStyle(
              color: Colors.blue,
              fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //       width: width,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: Colors.grey[200]
            //       ),
            //       child:  Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: GridView.builder(
            //             shrinkWrap: true,
            //             itemCount: profMockData.length,
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisSpacing: 10,
            //               childAspectRatio : MediaQuery.of(context).size.width /
            //                   (MediaQuery.of(context).size.height / 8),
            //               crossAxisCount: profMockData.length,),
            //             itemBuilder: (context, index){
            //               return InkWell(
            //                   onTap: (){
            //                     setState(() {
            //                       title = profMockData[index].label;
            //                       screen = profMockData[index].widget;
            //                     });
            //                   },
            //                   child: Container(
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         color: title == profMockData[index].label ? Color(0xFF5C000E): Colors.grey[200],
            //                       ),
            //                       child: ProfView(profModel: profMockData[index],)
            //                   )
            //               );
            //             }),
            //       )
            //   ),
            // ),
            screen

          ],
        ),
      ),
    );
  }
}
