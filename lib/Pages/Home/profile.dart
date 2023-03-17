import 'dart:convert';
import 'dart:io';
import 'package:ezenSacco/Pages/Authenticate/change_password.dart';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  var imagepath;
  bool imageset = false;
  String oldPassword ='';
  String newPassword = '';
  String confirmPassword = '';
  bool togglePassword = true;
  bool loading = false;
  bool error = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isenabled = false;

  var userid = userData[1]['userId'];
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.04,color: Colors.redAccent);
    final styles2 = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              captureImage();
            },
            child: Container(
              color: Colors.black12,
              height: height * 0.2,
              width: width,
              child:  imageset ? Image.file(_imageFile): Image.asset('assets/user.png') ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Information', style: styles,),
                InkWell(
                  onTap: (){
                    setState(() {
                      //isenabled = true;
                    });
                  },
                  child: Icon(Icons.edit,color: Colors.redAccent,),
                )
              ],
            ),
          ),

          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    children: [
                  SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Name" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: userData[1]['name'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Name",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Company" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['company'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Company",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Member No." : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['memberNo'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Member No.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Membership Type" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['membershipType'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Membership Type.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Membership Period" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['mshipPeriodInMonths'].toString()+' Months',style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Membership Period.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Member Class" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['memberClass'].toString() == "null" ? '' : currentUserData['memberClass'].toString(),style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Member Class.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Sponsor" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['sponsorName'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Sponsor",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Email" : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['email'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        enabled: isenabled,
                        validator: (val) => val!.isEmpty ? "Phone No." : null,
                        onChanged: (val){setState(() => oldPassword = val);},
                        initialValue: currentUserData['fixedPhone'],style: styles2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.account_box),
                          labelText: "Phone No.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[400],
                                  padding:  EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: (){
                                  uploadImage('image', File(imagepath),null);
                                  // var resu = await auth.uploadImage(null,imagepath,File(imagepath));
                                  // print(resu);
                                },
                                child: Text('Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Muli",
                                  ),)),
                            ElevatedButton(
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                  color: Colors.white,fontFamily: "Muli",
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding:  EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, customePageTransion(ChangePassword()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          error ? Text('data'): Text('')
        ],
      ),
    );
  }

  Future<void> captureImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,);
      //preferredCameraDevice: CameraDevice.back);
      setState((){
        imagepath = pickedFile!.path.toString();
      });

      //_imageFile = imageFile;

      print('theimagepath just below');
      print(imagepath);
      String img64 = base64Encode(File(imagepath).readAsBytesSync());
      //print('bytes'+bytes.toString());

      // print('img64:   ' + img64);

      setState(() {
        _imageFile = File(pickedFile!.path);
        imageset = true;
      });

    } catch (e) {
      //return e.toString();
    }
  }

  uploadImage(String title, file,loanId)async{

    // var url = "https://6450-197-248-34-79.in.ngrok.io";
    // Map<String, String> headers = {
    //   "Content-Type":"multipart/form-data",
    //   "Connection":"keep-alive",
    //   'Accept': 'application/json',
    // };
    //
    // Map data = {
    //   "memberId": userData[1]['saccoMembershipId'],
    //   loanId ?? "loanId": loanId,
    //   "companyId": userData[1]['companyId'],
    //   "document": base64Encode(File(imagepath).readAsBytesSync())
    // };
    //
    // var send = jsonEncode(data);
    // var response = await http.post(Uri.parse(url), body: send,headers: headers);
    // var use = jsonDecode(response.body);
    // print (use);

    // print('uploading');
    //
    // var url =  Uri.parse("https://7e19-197-248-34-79.in.ngrok.io");
    // var request = await http.MultipartRequest("POST",url);
    //
    // // request.files.add(await http.MultipartFile.fromPath('fileToUpload', imagepath));
    //
    // // Map data = {
    // //   "memberId": userData[1]['saccoMembershipId'],
    // //   // loanId ?? "loanId": loanId,
    // //   "companyId": userData[1]['companyId'],
    // //   // "document": await http.MultipartFile.fromPath('fileToUpload', imagepath),
    // // };
    // //
    // // Map<String, String>obj = {"values": json.encode(data).toString()};
    // //
    // // request.fields.addAll(obj);
    //
    // Map<String, String> data = {
    //   "memberId" : '1234',
    // };
    //
    // request.fields['memberId'] = '1234';
    //
    // var response = await request.send();
    //
    // var responsedata = await response.stream.toBytes();
    //
    // var result = String.fromCharCodes(responsedata);
    //
    // print(result);

    // var uri = Uri.parse("https://7e19-197-248-34-79.in.ngrok.io");
    // var request = http.MultipartRequest('POST', uri)
    //   ..fields['memberId'] = '1234'
    //   ..files.add(await http.MultipartFile.fromPath('fileToUpload', imagepath));
    // var response = await request.send();
    // // if (response.statusCode == 200) print('Uploaded!');
    // var responsedata = await response.stream.toBytes();
    //
    // var result = String.fromCharCodes(responsedata);
    //
    // print(result);


  }
}