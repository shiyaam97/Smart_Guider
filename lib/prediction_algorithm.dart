import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartguide/ibot_screen.dart';
import 'package:smartguide/study_matiral.dart';
import 'package:http/http.dart' as http;

import 'functions.dart';

class Prediction extends StatefulWidget {
  const Prediction({
    Key? key,
  }) : super(key: key);

  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  late final String _dropDownValue;
  final TextEditingController avgMarks = TextEditingController();
  final TextEditingController mathsA = TextEditingController();
  final TextEditingController sciA = TextEditingController();
  final TextEditingController engA = TextEditingController();
  final TextEditingController lanA = TextEditingController();
  final TextEditingController hisA = TextEditingController();
  final TextEditingController attA = TextEditingController();
  String output = 'Loading';
  String url = '';
  var data;
  List<String> _list = [];


  Future<String?> getData(List<String> data) async{

    try{
      var ur ="http://192.168.43.160:5000/api";
      var url = Uri.parse(Uri.encodeFull("http://192.168.43.160:5000/api?query="+ jsonEncode(data)));
      var response = await http
          .get(url, headers: {
        'Host': '192.168.43.160:5000',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36 Edg/94.0.992.47',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Accept-Encoding': 'gzip, deflate',
        'Accept-Language': 'en,en-US;q=0.9'
      });

//       var response = await http
//           .get(url, headers: {
//           'Host': '192.168.43.160:5000',
//           'Connection': 'keep-alive',
//           'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36 Edg/94.0.992.47',
//           'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
// 'Accept-Encoding': 'gzip, deflate',
// 'Accept-Language': 'en,en-US;q=0.9'
//
//       }
//        ,body:jsonEncode(data)
//       );



      // },'body': {data});      print(response.body);
      print(response.body);
      // debugPrint(response.body);
      // var convertDataToJson = json.decode(response.body);

      // print(convertDataToJson[0]['src']);
      // Results.val = convertDataToJson[0]['src'];
    }catch (e){
      print(e);

      // return showAlertDialog(context,Results.val.toString());
    }
    // return showAlertDialog(context,Results.val.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Academic Performance Prediction"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/bk.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              right: 30,
              left: 30,
              child: Column(
                children: [
                  Container(
                      width: 350,
                      height: 50,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          "Enter the following details",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg.Mat.Marks',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            controller: mathsA,

                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87,),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg.Eng.Marks',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            controller: engA,
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg.Sci.Marks',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg.His.Marks',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg.Lan.Marks',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'Avg Attendance',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(color: Colors.black87),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,

                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'No.Prizes (0-1)',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              filled: true,
                              // fillColor: Colors.black87,
                              border: OutlineInputBorder(),
                              hintText: 'No.Of.Compt (0-5)',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                            ),
                            onSubmitted: (value){
                              _list.add(value.toString());
                              // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                            },
                            // controller: avgMarks,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          filled: true,
                          // fillColor: Colors.black87,
                          border: OutlineInputBorder(),
                          hintText: 'No.Of.Sports.Participate (0-5)',
                          hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black87,fontWeight: FontWeight.bold),
                        ),
                        onSubmitted: (value){


                          _list.add(value.toString());
                          // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                        },
                        // controller: avgMarks,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              top: 530,
              right: 30,
              left: 30,
              child: Container(
                height: 50,
                // width: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () async{
                    print(_list);
                    url = 'http://192.168.43.160:5001/api?quer='+_list.toString();

                    data =await fetchPest(url);
                    data = await fetchPest(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      var performance = decoded['perfromance'];

                      var arr = performance.toString().split(',');
                      print(arr);
                      print(arr[1]);
                      var arr1 = arr[1].toString().split("-");
                      print(arr1[0]);
                      prdictValue.outputStudy =  int.parse(arr1[0]);
                      print(prdictValue.outputStudy);
                      output = 'Predicted Performance: $performance';
                      print(output);
                      showAlertDialog(context,output);
                    });

                  },
                  child: Text(
                    'PREDICT',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            PositionedDirectional(
                top: 620,
                start: 5,
                child: SizedBox(
                  height: 75,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IBot()),
                        );
                      },
                      child: Text('Intelligent Bot'),
                    ),
                  ),
                )),
            PositionedDirectional(
                top: 620,
                end: 5,
                child: SizedBox(
                  height: 75,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudyMaterial()),
                        );
                      },
                      child: Text('Online Study Material'),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context,String message) {
  // set up the button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Prediction Results"),
    content: Text('Over All Performance $message',style: TextStyle(fontSize: 20.0, color: Colors.black87)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

class prdictValue{
  static int outputStudy = 80;
  prdictValue();
}
