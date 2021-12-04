import 'package:flutter/material.dart';
import 'package:smartguide/prediction_algorithm.dart';

import 'auto_grading.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/bk.png'), fit: BoxFit.cover)),
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
                      child: const Text(
                        "SMART GUIDER",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                        color: Colors.white54,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Smart Guider is an easy use mobile application Implemented to manage the students online and acts as a Help desk. The main features are providing and guiding with Chat assistance,developing automatic grading component, Generating study material referencing and Predicting Academic performances.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Positioned(
              top: 400,
              right: 30,
              left: 30,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Prediction()),
                          );
                        },
                        child: Text(
                          'Academic Performance Prediction',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Grade()),
                          );
                        },
                        child: Center(
                            child: Text('Automatic Grading Component',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        /* child: Column(
          children: [
            Container(
              // height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text("SMART GUIDER",style: TextStyle(fontSize: 40),)),


                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 100,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Prediction()),
                          );
                        },
                        child: Text('Academic Performance Prediction'),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to first route when tapped.
                        },
                        child: Text('Automatic Grading Component'),
                      ),
                    ),
                  ),
                ],

              ),
            ),


          ],
        ),*/
      ),
    );
  }
}
