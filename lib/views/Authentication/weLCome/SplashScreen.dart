import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/HomeScreen.dart';
import '../login/Login.dart';

class SplashScreen extends StatefulWidget{


  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
//
    return Scaffold(
        body:  Container(
            decoration: BoxDecoration(


                borderRadius: BorderRadius.only(topLeft:Radius.zero,)
                ,color:Colors.white
            ),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Image(image: AssetImage('lib/images/chatting.jpg')
                        // backgroundImage: AssetImage('lib/images/chatting.jpg'),
                        // radius: 100,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 34,top: 5),
                       child: Center(
                         child: Text("Chatk ",style:
                         TextStyle(fontSize: 40,fontWeight: FontWeight.w900
                             ,color:Colors.black45)),
                       ),

                      ),
                      SizedBox(height: 50,),
                      // CircleAvatar(
                      //
                      //   backgroundImage: AssetImage('images/chat.jpg'),
                      //   radius: 50,
                      // ),
                      Container(
                        width: size.width ,
                        padding: EdgeInsets.only(
                            left: 60, top: 2, right: 10, bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),



                      ),



                    ]),
              ),
        )
    ));
  }
//   }


  @override
  void initState() {
    checkSignedIn(context);
  }
}

  void checkSignedIn(BuildContext context) {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser?.uid;
      if (user != null) {
      Timer(const Duration(seconds: 3),
          () =>  Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()))
      );
      }else{
        Timer(const Duration(seconds: 3),
        () =>  Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login())));

      }
    }


