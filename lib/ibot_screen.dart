import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'functions.dart';

class IBot extends StatefulWidget {
  const IBot({Key? key}) : super(key: key);

  @override
  _IBotState createState() => _IBotState();
}

class _IBotState extends State<IBot> {
  String output = '';
  String url = '';
  var data;


  TextEditingController inputMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Intelligent Bot'),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/image/chat.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 280,
                        width: 300,
                        color: Colors.white24,
                        child: Text(output,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.black87,),
                        decoration: const InputDecoration(
                          fillColor: Colors.white70,
                          filled: true,
                          // fillColor: Colors.black87,
                          border: OutlineInputBorder(),
                          hintText: 'Type Here',
                          hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black87,),

                        ),
                        controller: inputMessage,
                        onSubmitted: (value){
                          String val = value;
                          print(val);

                          // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                        },
                        // controller: avgMarks,
                      ),
                    ),
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onPressed: () async{
                          print(inputMessage.text);
                          url = 'http://192.168.43.160:5001/get?msg=' +inputMessage.text.toString();

                          data =await fetchPest(url);
                          data = await fetchPest(url);
                          var decoded = jsonDecode(data);
                          setState(() {

                            output = decoded['output'];
                          });

                        }, child: const Text('Send')),

                  ],
                ),
              )


            ],
          ),
        ));
  }
}
