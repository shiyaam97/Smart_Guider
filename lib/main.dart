import 'package:flutter/material.dart';

import 'package:smartguide/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Guider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Smart Guider'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/loginpage1.png'),
                fit: BoxFit.cover)
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 170,
              right: 30,
              left: 30,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 0),
                    child: Text(
                      "LogIn",
                      style: TextStyle(fontSize: 50, color: Colors.black87,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "user name",
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: _userName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          fillColor: Colors.white10,
                          hintText: "password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: _password,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 500,
              right: 30,
              left: 30,
              child: Container(
                height: 50,
                // width: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // ignore: unrelated_type_equality_checks
                      if (_userName.toString().contains('admin') &&
                          _password.toString().contains('admin')) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Incorrect Username and Password"),
                        ));
                      }
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
