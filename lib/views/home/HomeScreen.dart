
import 'package:chat_app/Constant.dart';
import 'package:chat_app/views/TextFiledContainerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../model/Users.dart';
import '../Authentication/login/Login.dart';
//import '../GroupsScreen/GroupsListScreen.dart';
import '../GroupsScreen/GroupListScreen.dart';
import '../calls/CallsScreen.dart';
import '../camera/CameraScreen.dart';
import '../chats/ChatScreen.dart';


class HomeScreen extends StatefulWidget  {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Users_model> allUsers =  [];
  List<Widget>bottomnavScreen = <Widget>[
    ChatScreen(
      users_model: Users_model("","","","","",false,"","",[]),

    ),
   CallsScreen(),
    CameraScreen(),

    GroupListScreen(),

  ];

  List<String> popupMenu=["LogOut","Settings"];
  int _curvedIndex = 0;

  TextEditingController searchTextController = TextEditingController();
   bool isSearch =false;

  void iconClickEvent(){
    setState(() {
      isSearch=!isSearch;

      print("search");
    });
  }
  void _changeItem(int value) {
    print(value);
    setState(() {
      _curvedIndex = value;

    });
  }


  @override
  void dispose() {
    searchTextController.dispose();
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

 Widget _emptyContainer(){
    return Container(
      height: 0,width: 0,
    );
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 0.0,
        backgroundColor: isSearch== true?Colors.transparent:Colors.purple,
        title: isSearch== true?_emptyContainer():
        Text("${AppConst.appName}",
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold),

        ),
        centerTitle: true,
        flexibleSpace: isSearch ==true?_buildSearchWidget():_emptyContainer(),
        // leading:
        actions: isSearch==true?[]:[
          InkWell(
              child: Icon(Icons.search,color: Colors.white,),onTap: (){
                setState(() {
                  isSearch=!isSearch;
                });
          },),
  //

          IconButton(onPressed: () {
            signout(context: context);
          }, icon: Icon(Icons.logout), color: Colors.white,),
          SizedBox(width: 10,),

        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.grey[200],
        items: [
          Icon(Icons.message_rounded, color: Colors.purple,),
          Icon(Icons.camera_alt_outlined, color: Colors.purple),
          Icon(Icons.call_outlined, color: Colors.purple),
          Icon(Icons.people_alt_outlined, color: Colors.purple),

        ],
        onTap: _changeItem,

        index: _curvedIndex,


      ),
      body: bottomnavScreen[_curvedIndex],
    );
  }

  signout({required BuildContext context}) {
    final auth = FirebaseAuth.instance;
    auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
    );
  }

  getAllUserData() {

    String? uId;
    FirebaseFirestore.instance.collection('users')

        .get()
        .then((value) {
      print(value.docs);
      value.docs.forEach((element) {
        allUsers.add(Users_model.fromJson(element.data())) ;
      });
      // var muser = value.data();
      // model = Users_model.fromJson(muser!);


    })
        .catchError((error) {
      print(error.toString());
    });
  }
  Widget _buildSearchWidget(){
    return Container(
        margin: EdgeInsets.only(top: 25),
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0,0.50)
            )],),
        child: TextFieldContainerWidget(
          // focusNode: focusNode,
            controller: searchTextController,
            keyboardType: TextInputType.text,
              prefixIcon:Icons.arrow_back,
              hintText: "Search here..",
          borderRadius: 0.0,
          color: Colors.white,
          iconClickEvent: (){
              setState(() {
                isSearch=!isSearch;
              });
          },
            ),

    );
  }
}
