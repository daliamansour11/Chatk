import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ResetPassword extends StatefulWidget{

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController userEmailController = new TextEditingController();
  late String email;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body:Container(

        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
            //   colors:[
            //     Colors.white60,
            //     Colors.black12,
            //     Colors.black26,
            //     Colors.black45,
            //     Colors.black54,
            //   ],
            //   stops: [-3,-3,-4,-5,10]  ,
        // ),
         ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
              alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    // border: Border.all( color: Colors.purpleAccent,width: 3.0,),
                    borderRadius: BorderRadius.circular(20.0)
                ),
// color: Colors.blue,

              child: const Text("Reset Password",
                style: TextStyle(fontSize: 30,
                    color: Colors.purple),
              )
// padding: EdgeInsets.symmetric(horizontal: 40),
          ),


          SizedBox(height: 50,),
                Container(
                    // decoration: BoxDecoration(color: Colors.white,
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    //
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
// labelText: "UserEmail", //babel text
                  hintText: "Enter Email",
                  //hint text

                  prefixIcon: Icon(Icons.email),
                  //prefix iocn

                  hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                  //hint text style
                  labelStyle: TextStyle(
                      fontSize: 13, color: Colors.redAccent), //label style
                ),


              )


          ),
          SizedBox(height: size.height * 0.03,),


                Container(

                  width: 200,
                  height: 70,
                  alignment: Alignment.center,
                  margin:EdgeInsets.only(left: 10,right: 30,top: 10,bottom: 0) ,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.grey[200],
                      elevation: 5,
                      padding:  EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onPressed: ()  {
                      if (_formKey.currentState!.validate()) {
                        resetPassword();
                      }
                    },



                    child: Text(
                        "Done",
                        style: TextStyle(color: Colors.purple,fontSize: 18)
    )
                  ),
                ),


                SizedBox(height: size.height* 0.04,),
          ],
    ),

    )),
      ));
  }

  Future resetPassword() async{
try {
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: userEmailController.text);
    Fluttertoast.showToast(
    msg: "A reset email has been sent to you", // message
    toastLength: Toast.LENGTH_LONG, // length
    gravity: ToastGravity.CENTER, // location

    timeInSecForIosWeb: 2,
    );
    Navigator.of(context).pop();
    }on FirebaseAuthException catch (e){
  print(e);


}

}

  }


