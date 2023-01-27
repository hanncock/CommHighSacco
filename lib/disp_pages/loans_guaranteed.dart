import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../widgets/backbtn_overide.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';

class LoansGuaranteed extends StatefulWidget {
  const LoansGuaranteed({Key? key}) : super(key: key);

  @override
  State<LoansGuaranteed> createState() => _LoansGuaranteedState();
}

class _LoansGuaranteedState extends State<LoansGuaranteed> {


  final TextEditingController textEditingController = TextEditingController();
  final AuthService auth = AuthService();
  List requested_Guarantors = [];
  bool nodata = false;
  bool nodata2 = false;
  bool initial_load = true;
  final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);

  requestedGuarantors()async{
    var response = await auth.guarantors_guaranteedissued();
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
        requested_Guarantors = response['list'];
        print(requested_Guarantors);
      });
    }
  }

  @override
  void initState() {
    requestedGuarantors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Issue Guarantance',
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli",
            fontSize: width * 0.04
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.redAccent,
            ),
            onPressed: () {
              setState(() {
                print('Reload init');
                // provider.getStatements(context, mounted, reload: true);
                // _data = ApiService().getDividends(true);
              });
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Text(''),
            TabBar(
                labelColor: Colors.blue[800],
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue[800],
                tabs: [
              Text('Issue Guarantance',style: styles,),
                  Text("Loans I've Guaranteed",style: styles,)
            ]),
            Flexible(
              child: TabBarView(children: [
                nodata2 ? Center(child: Text('No request '),):
                Center(child: Text('No request sent yet')),
                initial_load ? Center(child: LoadingSpinCircle(),):
                nodata ? Center(child: Text('No Loans Guaranteed yet')): Column(
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
                                  // color: selectedIndexes.contains(addedguarantorslst[index]['memberNo']) ? Colors.lightBlueAccent.withOpacity(0.3): Colors.white,
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
                                                SizedBox(width: 10,),

                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Loan Num.',style: styles,),
                                              Text(''),
                                              Text('${requested_Guarantors[index]['loanNo'] ?? ''}',style: styles,),
                                            ],
                                          ),
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
              ]),
            )
          ],
        ),
      ),
    );
  }
}
