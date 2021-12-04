import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide/functions.dart';
import 'package:file_picker/file_picker.dart';

class Grade extends StatefulWidget {

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  String grade = '';
  String url = '';
  late File selectFile;
  var data;
  uploadFile(typefile) async {
    try {
      final request = http.MultipartRequest(
          "POST", Uri.parse("http://faf0-175-157-98-233.ngrok.io/upload"));
      request.headers['Host'] = 'faf0-175-157-98-233.ngrok.io';
      request.headers['Connection'] = 'keep-alive';
      request.headers['DNT'] = '1';
      request.headers['User-Agent'] =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36';
      request.headers['Origin'] = 'http://faf0-175-157-98-233.ngrok.io';
      request.headers['Accept-Language'] = 'en-GB,en-US;q=0.9,en;q=0.8';
      request.headers['Referer'] = 'http://faf0-175-157-98-233.ngrok.io/upload';
     request.fields['test'] = typefile;
      final headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile('image',
          selectFile.readAsBytes().asStream(), selectFile.lengthSync(),
          filename: selectFile.path.split("/").last));

      request.headers.addAll(headers);
      final response = await request.send();
      http.Response res = await http.Response.fromStream(response);
      final resJson = jsonDecode(res.body);
      var message = resJson['message'];
      var button = true;
      print(resJson['message']);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  Future getfiles(String typefile) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      selectFile = File(result.files.single.path ?? "");
      setState(() {
        uploadFile(typefile);
      });
    } else {
      // User canceled the picker
    }


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Automatic Grading Component"),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/bk.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 30,
              left: 30,

              child: Column(
                children: [
                  Container(
                      color: Colors.white38,
                      child: Text("SMART GUIDER",style: const TextStyle(fontSize: 40),)),

                ],
              ) ,
            ),

            Positioned(
              top: 125,
              right: 30,
              left: 30,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      grade,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, // light
                          fontStyle: FontStyle.italic,
                          backgroundColor: Colors.white,
                          fontSize: 40 // italic
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            getfiles('teacher');
                            // Navigate back to first route when tapped.
                          },
                          child: const Text('Teacher Scheme Upload \n .txt format'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            getfiles('student');
                            // Navigate back to first route when tapped.
                          },
                          child: Text('Student Answers Upload \n .txt format'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 75,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async{
                            // url = 'http://192.168.43.191:5001/api?query=a';
                            url = 'http://192.168.43.160:5001/member2';
                            // url = 'http://192.168.43.64:5001/member3';

                            data =await fetchPest(url);
                            var decoded = jsonDecode(data);
                            setState(() {
                              var temp = decoded['output'].toString();
                              grade = 'Grade is : $temp';
                              print(' Grade is : $grade ');
                              // leafD = '  Leaf Effected By :   $pestMem3';
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Pest Page')));
                          },
                          child: const Text('Grade'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),

          ],
        ),
      ),
    );
  }
}

