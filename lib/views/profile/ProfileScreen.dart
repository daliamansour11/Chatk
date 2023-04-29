import 'package:chat_app/views/home/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/Users.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  late String _status, _name, _phone, _uId, image, status;
  String? Auth = FirebaseAuth.instance.currentUser?.uid;

  String? Auth_image = FirebaseAuth.instance.currentUser?.photoURL;

  // var _formKey = GlobalKey<FormState>();
  // void _submit() {
  //   final isValid = _formKey.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  //   _formKey.currentState?.save();
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _phonenumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container (
        height:500,
        child: Column(
          children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 69.0,
                    width: 69.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(62.0),
                    ),
                    child: Center(child: Image.asset("lib/images/chat.jpg")),
                  ),
                ),
            SizedBox(
              height: 10.10,

            ),

            Text("RemoveProfilePhoto", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,
            color: Colors.purple),),
            SizedBox(
              height: 10.0,
            ),

            Expanded(
              child: Container(
                 width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter userName";
                      } else if (value.length < 6) {
                        return "Too short userName,choosea username with 6 character or more characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
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
            ),

            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                  child: TextFormField(
                    controller: _phonenumberController,
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
                          color: Colors.grey,
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
            ),

            Expanded(
              child:  Container(
                       width: MediaQuery.of(context).size.width,
                height: 60,
                //  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                  child: TextFormField(
                    controller: _statusController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter status";
                      } else if (value.length < 6) {
                        return "Too short status,write status with 6 character or more characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
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

                      //babel text
                      hintText: " status ",
                      //hint text
                      prefixIcon: Icon(Icons.account_tree_outlined),
                      //prefix iocn
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200), //hint text style
                      //  labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                    ),
                  )),
            ),
            // SizedBox(
            //   height: 20.0,
            // ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 10),
              height: 63,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(160),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 0.50))
                ],
              ),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.purple[600],

                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {

                    getUpdateUser(context,
                        Users_model(_nameController.text,
                            "email", _phonenumberController.text,
                            "", Auth, true,"",
                            _statusController.text,[])
                       );
    // _submit();

                    Fluttertoast.showToast(
                      msg: "Updated Successfully", // message
                      toastLength: Toast.LENGTH_LONG, // length
                      gravity: ToastGravity.CENTER, // location
               backgroundColor: Colors.white,
                      timeInSecForIosWeb: 2,
                    );
                    Navigator.of(context).
                    push(MaterialPageRoute(builder: (context)=>HomeScreen()
                    ));
                }




                ,
                child: Text(
                    "UpDate",
                    style: TextStyle(color: Colors.white, fontSize: 18)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  getUpdateUser(BuildContext context,Users_model users_model)async{
     Map<String,dynamic> userinfo = Map();
     final usercollection =  FirebaseFirestore.instance.collection('users');
 if(users_model.image !=null &&users_model.image!="" ){
userinfo['image']= users_model.image;
 }

     if(users_model.name !=null &&users_model.name!="" ){
       userinfo['name']= users_model.name;
     }

     if(users_model.status !=null &&users_model.status!="" ){
       userinfo['status']= users_model.status;
     }
     if(users_model.phone !=null &&users_model.phone!="" ){
       userinfo['phone']= users_model.phone;
     }
usercollection.doc( users_model.uId ).update(userinfo);
  }


}
