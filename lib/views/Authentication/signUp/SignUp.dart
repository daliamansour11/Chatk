import 'package:chat_app/Constant.dart';
import 'package:chat_app/model/Users.dart';
import 'package:chat_app/views/GroupsScreen/ChatGroupData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/HomeScreen.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool showSpinner = false;

  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (isValid!) {
  //     return;
  //   }
  //   _formKey.currentState!.save();
  // }
  TextEditingController userNameController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpassController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();
  late String _email, _password, _name, _phone, _uId, image,usergroups;
  late bool status;
  late List userGroup;
  // const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.purple[40],
        body: ModalProgressHUD(
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
            ),
            color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          // border: Border.all( color: Colors.purpleAccent,width: 3.0,),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: const Text(
                        "Sign UP",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                      // padding: EdgeInsets.symmetric(horizontal: 40),
                      ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                      // decoration: BoxDecoration(color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),

                      //  ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter userName";
                          } else if (value.length < 6) {
                            return "Too short userName,choosea username with 6 character or more characters";
                          }
                          return null;

                        },
                        onChanged: (v){
                          setState(() {
                            _name = v.trim();

                          });
                          ChatGroupData.saveUserNameSF(_name);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "UserName",
                          //babel text
                          hintText: " UserName ",
                          //hint text
                          prefixIcon: Icon(Icons.person),
                          //prefix iocn
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200), //hint text style
                          //  labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                      // decoration: BoxDecoration(color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //
                      // ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: userEmailController,
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            // !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //     .hasMatch(value)) {
                            return "please enter  your email";
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return " please enter valide email address";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                                 ChatGroupData.saveUserEmailSF(_email);
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "UserEmail",
                          //babel text
                          hintText: "Enter your email",
                          //hint text
                          prefixIcon: Icon(Icons.email),
                          //prefix iocn
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200), //hint text style
                          //    labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                      // decoration: BoxDecoration(color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //
                      // ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: userPhoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your phone number";
                          } else if (value.length < 11) {
                            return "phone number should be 11 number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "PhoneNumber",
                          //babel text
                          hintText: " PhoneNumber",
                          //hint text
                          prefixIcon: Icon(Icons.phone),
                          //prefix iocn
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200), //hint text style
                          // labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    // decoration: BoxDecoration(color: Colors.white,
                    //   borderRadius: BorderRadius.all(Radius.circular(5)),
                    //
                    // ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please password is required";
                        } else if (value.length < 6) {
                          return "password should be 6 character or more characters";
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: " Password",
                        //babel text

                        // labelText: "password", //babel text
                        hintText: "Enter your password",
                        //hint text
                        prefixIcon: Icon(Icons.password),
                        //prefix iocn
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200), //hint text style
                        // labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                      // decoration: BoxDecoration(color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                      //
                      // ),
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: confirmpassController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your password ";
                          } else if (value.length < 6) {
                            return "password should be 8 characters or more characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Comfirm Password",
                          //babel text
                          prefixIcon: Icon(Icons.password),
                          //prefix iocn
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200), //hint text style//
                          // labelStyle: TextStyle(fontSize: 13, color: Colors.b), //label style
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Container(
                    width: 200,
                    height: 70,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: 10, right: 30, top: 10, bottom: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        padding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // setState((){
                          //   showSpinner =true;
                          // });
                          signup(
                              context,
                              _name = userNameController.text,
                              _email = userEmailController.text,
                              _phone = userPhoneController.text,
                              _password = passwordController.text,
                              _uId = "",
                              image = "",
                            userGroup=[]
                          );
                          ChatGroupData.saveUserEmailSF(_email);
                          ChatGroupData.saveUserLoggedInStatus(true,);
                          ChatGroupData.saveUserNameSF(_name);


                        } else {
                          print("UnSuccessfully SignUp");
                        }
                      },
                      child: Text("SignUp",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
    //   backgroundColor: Colors.lightBlue[50],
    // );
  }

  static void signup(BuildContext context, String name, String email,
      String phone, String password, String uId, String image,List userGroups) {
    userRegister(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: uId,
        image: image);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

void userRegister({
  required String name,
  required String email,
  required String phone,
  required String password,
  required String uId,
  required String image,
}) {
  FirebaseAuth auth = FirebaseAuth.instance;
  auth
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((value) {
    userCreate(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: value.user!.uid,
        image: image,
        isEmailVerfied: false);
  });
}
userCreate({
  required String name,
  required String email,
  required String phone,
  required String password,
  required String uId,
  required String image,
  required bool? isEmailVerfied,
  String? status,
  List?userGroup ,
}) {
  Users_model model = Users_model(
      name, email, phone, password, uId, isEmailVerfied, image,
      status,userGroup);
  FirebaseFirestore.instance
      .collection("users")
      .doc(uId)
      .set(model.toMap())
      .then((value) {
    print(model.email);
    print(model.uId);
  }).catchError((error) {
    print(error);
  });
}

