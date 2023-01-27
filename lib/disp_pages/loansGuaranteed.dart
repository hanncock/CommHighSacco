import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/backbtn_overide.dart';
import '../wrapper.dart';
import 'Messaging.dart';

class LoansGuaranteed extends StatefulWidget {
  const LoansGuaranteed({Key? key}) : super(key: key);

  @override
  State<LoansGuaranteed> createState() => _LoansGuaranteedState();
}

class _LoansGuaranteedState extends State<LoansGuaranteed> {
  final AuthService auth = AuthService();
  List listGuaranteed = [];
  bool loading = false;

  loansGuaranteed()async{
    var resu = await auth.loansGuaranteed();
    print(resu);
    setState(() {
      loading = true;
      listGuaranteed = resu['list'];
    });
  }

  @override
  void initState(){
    super.initState();
    loansGuaranteed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'My Guaranteed Loans',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16,left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade100
                    )
                ),
              ),
            ),
          ),
          loading ? Flexible(
            child: ListView.builder(
              itemCount: 2,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                  ),
                      elevation: 0,
                      // color: Colors.redAccent,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, customePageTransion(Messaging()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 22,
                                      child: Image.asset(
                                          'assets/design_course/userImage.png'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Member name',
                                                style: TextStyle(
                                                  fontSize: width * 0.038,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Muli",
                                                )),
                                            SizedBox(height: 6,),
                                            Text('Member No')
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text('8.06',style: TextStyle(fontWeight: FontWeight.bold),)

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  );
                }
            ),
          ): LoadingSpinCircle()
        ],
      ),
    );
  }
}
