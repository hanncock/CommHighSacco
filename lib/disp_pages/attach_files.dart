import 'dart:convert';
import 'dart:io';
import 'package:ezenSacco/configs/const.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';
import '../services/auth.dart';
import '../widgets/spin_loader.dart';

class AttachFile extends StatefulWidget {
  final loanId;
  const AttachFile({Key? key, required this.loanId}) : super(key: key);

  @override
  State<AttachFile> createState() => _AttachFileState();
}

class _AttachFileState extends State<AttachFile> {

  final AuthService auth = AuthService();
  var fileName;
  var fileEncoded;
  var _imageFile;
  var filePath;
  var extra;
  final _formKey = GlobalKey<FormState>();
  var loanFiles = [];
  bool loading = true;

  getDocuemnts()async{
    var url = userData[0]+'/api/sacco_loan/files?loanId=${widget.loanId}';
    print(url);
    var res = await get(Uri.parse(url));
    var resu = jsonDecode(res.body);
    print(resu);
    setState((){
      loanFiles = resu['list'];
      loading = false;
    });
  }

  double? _progress;

  uploadDocs()async{
    var resu = await auth.uploadDocs(widget.loanId,fileName,fileEncoded);
    print(resu);
  }

  Future<void> captureImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','jpeg','png','pdf']);

    if (result != null) {
      File filess = File(result.files.single.path!);
      PlatformFile file = result.files.first;
      var mimeType = lookupMimeType(result.files.single.path!);
      print('her is file mime ${mimeType}');

      var toencode =  File(filess.path).readAsBytesSync();
      setState((){
        filePath = (filess.path);
        fileEncoded =  "data:${mimeType};base64,${base64Encode(toencode!)}";
        print(fileEncoded);
      });
    } else {
      // User canceled the picker
    }
  }

  uploadFile()async{

    var resu = await auth.uploadDocs(widget.loanId, fileName, fileEncoded);
    Navigator.of(context).pop();
    if(resu['success'] == 'true'){
      Fluttertoast.showToast(
          msg:  resu['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(
          msg:  resu['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    print(resu);
  }

  void initState(){
    getDocuemnts();
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          loading ? Center(child: LoadingSpinCircle(),) :Container(
            height: height * 0.4,
            // color: Colors.grey[200],
            child: loanFiles.length == 0 ? Center(child: Text('No files found for this loan, Please select file and upload to add')):
            ListView.builder(
                shrinkWrap: true,
                itemCount: loanFiles.length,
                itemBuilder: (context, index){
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${loanFiles[index]['notes'].toUpperCase()}\t'),
                                      ),
                                      Text('${loanFiles[index]['docName']}',style: TextStyle(color: Colors.grey[600]),),
                                    ],
                                  ),
                                  Icon(Icons.preview,color: Colors.blueAccent,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }) ,
          ),
          Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.7),
                            // backgroundColor: Colors.redAccent,
                            padding:  EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: (){
                            captureImage();
                          },
                          child: Row(
                            children: [
                              Text('SELECT FILE'),
                              Icon(Icons.file_copy_rounded)
                            ],
                          ))
                    ],
                  ),
                  filePath == null ? Text(''):Text('$filePath'),
                  Text(''),
                  TextFormField(
                    // initialValue: fileEncoded,
                    validator: (val) => val!.isEmpty ? "Enter  filename" : null,
                    onChanged: (val){setState(() => fileName = val);},
                    decoration: InputDecoration(
                      hintText: 'File Name i.e ID, Passport, PaySlip',
                      suffixIcon: Icon(Icons.file_copy_rounded),
                      labelText: "File Name",
                      // hintStyle: TextStyle(fontSize: width * 0.04),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Text(''),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blue[800],
                          backgroundColor: Colors.blue.withOpacity(0.7),

                          padding:  EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: (){
                          print('uploading');
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context, builder: (_) => LoadingSpinCircle()
                            );
                            uploadFile();
                          }
                        },
                        child: Row(
                          children: [
                            Text('UPLOAD FILE'),
                            Icon(Icons.upload)
                          ],
                        )),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
