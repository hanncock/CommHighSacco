import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';

class ProfDisp extends StatefulWidget {
  const ProfDisp({Key? key}) : super(key: key);

  @override
  State<ProfDisp> createState() => _ProfDispState();
}

class _ProfDispState extends State<ProfDisp> {

  final AuthService auth = AuthService();
  final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.04,color: Colors.redAccent);
  final styles2 = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);
  var networkImage = userData[1]['profileFoto'];
  bool imageset = false;
  var _imageFile;
  var fileEncoded;
  final ImagePicker _picker = ImagePicker();
  var imagepath;
  var profileId;


  @override
  Widget build(BuildContext context) {
    print(userData[1]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              captureImage();
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: width * 0.15,
                  backgroundColor: Colors.grey[200],
                  child: CircleAvatar(
                    backgroundImage: userData[1]['profileFoto'] == null ? NetworkImage('assets/design_course/userImage.png'):
                    NetworkImage('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
                    // backgroundImage: imageset ? NetworkImage('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}') : null,
                    radius: width * 0.13,
                    // child: imageset ? Image.file(_imageFile): networkImage ==null ? Image.asset('assets/design_course/userImage.png'):
                    // Image.network('${userData[0]}/appfiles/uploads/fms/sacco/members/profile/${userData[1]['profileFoto']}'),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.add_a_photo, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            color: Colors.black.withOpacity(
                              0.3,
                            ),
                            blurRadius: 3,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.04,),
          Text('${userData[1]['name']}',style: styles2,),
          SizedBox(height: height * 0.04,),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Icon(Icons.call,color: Color(0xFF5C000E).withOpacity(0.5),),
                  ),
                  // backgroundImage: ,
                  backgroundColor: Colors.grey[100],
                  radius: 30,

                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone',style: TextStyle(color: Colors.grey),),
                      Text(''),
                      Text('${userData[1]['phoneNo']}',style: TextStyle(
                        // color: fo
                          letterSpacing: .4,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.email,color: Color(0xFF5C000E).withOpacity(0.5),),
                  ),
                  // backgroundImage: ,
                  backgroundColor: Colors.grey[100],
                  radius: 30,

                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',style: TextStyle(color: Colors.grey),),
                      Text(''),
                      Text('${userData[1]['phoneNo']}',style: TextStyle(
                        // color: fo
                          letterSpacing: .4,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.credit_card,color: Color(0xFF5C000E).withOpacity(0.5),),
                  ),
                  // backgroundImage: ,
                  backgroundColor: Colors.grey[100],
                  radius: 30,

                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Member Id',style: TextStyle(color: Colors.grey),),
                      Text(''),
                      Text('${userData[1]['saccoMemberId']}',style: TextStyle(
                        // color: fo
                          letterSpacing: .4,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          imageset ? Padding(
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
                    onPressed: ()async{
                      print('uploading');
                      showDialog(
                          context: context, builder: (_) => LoadingSpinCircle()
                      );
                      var res = await auth.uploadImage(fileEncoded);
                      print(res);
                      var text = res['message'];

                      var splitText = text.split("/") ;
                      print(splitText.last);

                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      var mai = jsonDecode(preferences.getString('email')!);
                      // print(mai[1]);
                      setState(() {
                        mai[1]['profileFoto'] = splitText.last;
                      });
                      print(mai);
                      preferences.setString('email', jsonEncode(mai));
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));

                    },
                    child: Text('Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Muli",
                      ),)),
                ElevatedButton(
                  child: Text(
                    'Cancel',
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
                    // Navigator.push(context, customePageTransion(ChangePassword()));
                  },
                ),
              ],
            ),
          ): Text(''),
        ],
      ),
    );
  }

  Future<void> captureImage() async {
    print('selecting');
    try {
      ImagePicker picker = ImagePicker();
      // final pickedFile = await picker.pickImage(source: source)
      final pickedFile = await picker.pickImage(source: ImageSource.gallery,);
      //preferredCameraDevice: CameraDevice.back);

      setState((){
        imagepath = pickedFile!.path.toString();
      });

      var mimeType = lookupMimeType(imagepath);

      setState(() {
        _imageFile = File(pickedFile!.path);
        imageset = true;
      });

      setState((){
        // filePath = (filess.path);
        fileEncoded =  "data:${mimeType};base64,${base64Encode(File(imagepath).readAsBytesSync())}";
        print(fileEncoded);
      });
      // } else {
      //   // User canceled the picker
      // }

    } catch (e) {
      //return e.toString();
    }
  }

}
