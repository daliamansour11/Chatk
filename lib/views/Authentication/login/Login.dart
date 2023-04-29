
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../home/HomeScreen.dart';
import '../SignUp/SignUp.dart';
import 'ResetPassword.dart';




class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();



  static void signin(BuildContext context, String email, String password) {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: email, password: password).then((_) {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
    }
    );
  }
}
class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
   bool showSpinner =false;
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }


  TextEditingController userEmailController =  TextEditingController();

  TextEditingController passwordController =  TextEditingController();

  bool ischecked = false;

  late String? email;

  late String? password;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;



    return Scaffold(



      body:ModalProgressHUD(

        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors:[
              //     Colors.white60,
              //     Colors.black12,
              //     Colors.black26,
              //     Colors.black45,
              //     Colors.black54,
              //   ],
              //   stops: [-3,-3,-4,-5,10]  ,
              // ),
              borderRadius:
              BorderRadius.only(topLeft:Radius.zero,),color:Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
          child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                child: CircleAvatar(
              backgroundImage: AssetImage('lib/images/chat2.jpg'),
                  radius: 60,
                ),

              ),
              SizedBox(height: 10,),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
                  child: const Text("LOGIN",
                    style: TextStyle(fontSize: 27,
                        color: Colors.white),
                  ),
               padding: EdgeInsets.symmetric(horizontal: 40),
              ),


              SizedBox(height: size.height * 0.03,),
              Container(
             // decoration: BoxDecoration(color: Colors.white,
                    // borderRadius: BorderRadius.all(Radius.circular(10)),

                 // ),

                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(

                    controller: userEmailController,
                    obscureText: false,
                      validator:(value){
                        if (value!.isEmpty  ||value ==null)
                          {
                          return "please enter  your email";
                        }
                        else if(!value .contains("@") ||!value .contains(".") ){
                          return " please enter valide email address";

                        }
                        return null;

                      },
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    decoration: InputDecoration(

                        border: OutlineInputBorder(borderRadius:
                        BorderRadius.all(Radius.circular(20)
                        ),),
                      enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                          width: 1,

                        ),

                        borderRadius: BorderRadius.all(Radius.circular(20)
                      ),

                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,

                        ),
                          borderRadius: BorderRadius.all(Radius.circular(20)

                    ),
                      ),
                      // labelText: "UserEmail", //babel text
                      hintText: "Enter Email",
                      contentPadding:EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                      //hint text
                      prefixIcon: Icon(Icons.email),
                      //prefix iocn
                      hintStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,
                          color:Colors.black45),
                      //hint text style
                      labelStyle: TextStyle(
                          fontSize: 13, color: Colors.redAccent), //label style

                    ),

                  )

              ),
              SizedBox(height: size.height * 0.03,),

              Container(

                // decoration: BoxDecoration(color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                // ),

                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                      validator:(value){
                        if(value == null|| value.isEmpty){
                          return "please password is required";
                        }
                        else if(value .length < 8){
                          return "password should be 8 character or more characters";

                        }
                        return null;

                      },

                      onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                          width: 1,

                        ),

                        borderRadius: BorderRadius.all(Radius.circular(20)
                        ),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,

                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)

                        ),
                      ),
                      // labelText: "password", //babel text
                      hintText: "Enter your password",
                      contentPadding:EdgeInsets.symmetric(vertical: 1,horizontal: 10),

                      //hint text
                      prefixIcon: Icon(Icons.password),
                      //prefix iocn
                      hintStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,
                          color: Colors.black45),
                      //hint text style
                      labelStyle: TextStyle(
                          fontSize: 13, color: Colors.redAccent), //label style

                    ),

                  )


              ),
              SizedBox(height: size.height * 0.03,),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      "Forget yourPassword",
                      //babel text
                    )
                ),
              ),
              SizedBox(width: size.width * 0.07,),

              Container(

                width: 200,
                height: 70,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    elevation: 5,
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: ()  {


                    if( userEmailController.text.isEmpty || userEmailController.text == null &&
                        passwordController.text .isEmpty || passwordController.text == null ) {

                     _submit();
                    }
                    else {
                      // setState((){
                      //   showSpinner =true;
                      // });
                      Login.signin(context, email = userEmailController.text,
                          password = passwordController.text);

                      // // _submit();
                      // setState((){
                      //   showSpinner =false;
                      // });
                    }
                  },
                  child: Text(
                      "LogIn",
                      style: TextStyle(color: Colors.purple, fontSize: 18)
                  ),
                ),
              ),


              SizedBox(height: size.height * 0.04,),

              Container(

                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(left: 70, right: 10, top: 0, bottom: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(""
                        "Don't Have an account? Sign Up",
                      style: TextStyle(fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),),
                  )
              )
          ])
          )


          ),
        ),
      ),
      );

  }


  //
}