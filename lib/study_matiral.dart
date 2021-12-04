import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide/prediction_algorithm.dart';


class StudyMaterial extends StatefulWidget {
  const StudyMaterial({Key? key}) : super(key: key);

  @override
  _StudyMaterialState createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  static String val = "";
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Study Material'),
      ),
      body:Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/bk.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: 250,
              right: 30,
              left: 30,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            int marks = prdictValue.outputStudy;
                            getData(context,marks);
                            //databese markes
                            // Navigate back to first route when tapped.

                          },
                          child: const Text('References',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
          ],
        ),
      )
    );
  }
}



showAlertDialog(BuildContext context,String val) {
  // set up the button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Study Material"),
    content: Text(Results.val),
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
Future<String?> getData(BuildContext context,int _percentage) async{

  try{
    var ur ="192.168.43.160/smartguider/";
    var url = Uri.parse(Uri.encodeFull("http://192.168.43.160/smartguider/api/Search?percentage=" +_percentage.toString()));
    var response = await http.get(url, headers: {'Accept': 'application/json',
      'Host': '192.168.43.160',
      'Connection': 'keep-alive',
      'DNT': '1',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36',
      'Origin': 'http://'+ur,
      'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'   })     ;
      // ,body: {'username':'agentkssk','password':'user1234'});
    // },body: {'username':username,'password':password});      print(response.body);

    // debugPrint(response.body);
    var convertDataToJson = json.decode(response.body);

    print(convertDataToJson[0]['src']);
    Results.val = convertDataToJson[0]['src'];
  }catch (e){
    print(e);

    return showAlertDialog(context,Results.val.toString());
  }
  return showAlertDialog(context,Results.val.toString());
}
/*showAlertDialog1(BuildContext context) {
  // set up the button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Subject Wise Study Material"),
    content: Text("https://pastpapers.wiki/o-l-mathematics-past-papers-and-answers-in-sinhala-medium-new/"),
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
}*/

class Results{
  static String val = "http://www.doenets.lk/pastpapers";
  Results();
}