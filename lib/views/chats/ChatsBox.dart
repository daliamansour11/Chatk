import 'package:chat_app/model/Users.dart';
import 'package:chat_app/views/calls/CallsScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../model/Messages.dart';
import '../home/HomeScreen.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

String firebaseAuth = FirebaseAuth.instance.currentUser!.uid as String;
List message= [];


final messageTextController = TextEditingController();

class ChatBox extends StatefulWidget {

  Users_model users_model;
  ChatBox({
    required this.users_model,
    // required this.messages,
  });
  @override
  State<ChatBox> createState() => _ChatBoxState(messages: messages_model( text: messageTextController.text,  ));
}

class _ChatBoxState extends State<ChatBox> {
  String? messagetext;
  bool show = false;
  bool sendButton = false;

  FocusNode focusNode = FocusNode();
   ScrollController _scrollController = ScrollController();
   messages_model messages;
   _ChatBoxState(
  {
    required this.messages,

}
       );
  @override
  void initState() {
    sendMessage({
    required String reciverId,
    // required String senderId ,

    required String dateTime,
    required String text,

  }){
   messages_model message_model = messages_model
   (senderId:firebaseAuth,text :text,
   reciverId:reciverId,time:dateTime

   );


   //userChat
   FirebaseFirestore.instance

       .collection('users')
       .doc('${firebaseAuth}')
       .collection('chats')
       .doc(reciverId)
       .collection('messages')
   // .orderBy('')
       .add(message_model.toMap())
       .then((value){

   })
       .catchError((error){
   print(error);
   });

   //reciver chat
   FirebaseFirestore.instance
       .collection('users')
       .doc(reciverId)
       .collection('chats')
       .doc(firebaseAuth)
       .collection('messages')
       .add(message_model.toMap())
       .then((value){
             print(value);
   })
       .catchError((error){
   print(error);
   });
   }


   void getMessages({
     required String reciverId,
   }){


     FirebaseFirestore.instance
         .collection('users')
         .doc(firebaseAuth)
         .collection('chats')
         .doc(reciverId)
         .collection('messages')
         .snapshots()
         .listen((event) {
       message =[];
       event.docs.forEach((element) {
         message.add(messages_model.fromJson(element.data()));
       });
     });
  } //
  String? messagetext;

  bool show = false;

  bool sendButton = false;

  FocusNode focusNode = FocusNode();
  }
   sendMessage({
    required String reciverId,
    // required String senderId ,
    required String dateTime,
    required String text,

  }){
    messages_model message_model = messages_model
      (senderId:firebaseAuth,text :text,
        reciverId:reciverId,time:dateTime
    );
    //userChat
    FirebaseFirestore.instance

        .collection('users')
       .doc('${firebaseAuth}')
     .collection('chats')
    .doc(reciverId)
     .collection('messages')
    // .orderBy('')
    .add(message_model.toMap())
    .then((value){

    })
    .catchError((error){
      print(error);
    });

    //reciver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(firebaseAuth)
        .collection('messages')
        .add(message_model.toMap())
        .then((value){})
        .catchError((error){
      print(error);});}
  void getMessages({
    required String reciverId,
  }){
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .snapshots()
        .listen((event) {
          message =[];
          event.docs.forEach((element) {
            message.add(messages_model.fromJson(element.data()));
          });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Row(
      //     children: [
      //       CircleAvatar(
      //         radius: 21.0,
      //         backgroundColor: Colors.grey[200],
      //         backgroundImage: NetworkImage('${widget.users_model.image}'),
      //       ),
      //       SizedBox(
      //         width: 3,
      //       ),
      //       Column(
      //         children: [
      //           Text("  ${widget.users_model.name}",
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.w600)),
      //           SizedBox(
      //             height: 4,
      //           ),
      //           Text("  ${widget.users_model.status}",
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.w600)),
      //         ],
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //         color: Colors.black,
      //         icon: Icon(
      //           Icons.call_outlined,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => HomeScreen()));
      //         }),
      //     SizedBox(
      //       width: 10,
      //     ),
      //   ],
      // ),

        appBar: AppBar(
          centerTitle: true,
          title: Expanded(
            flex: 1,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 21.0,
                  backgroundImage: NetworkImage('${widget.users_model.image}'),
                ),
                SizedBox(
                  width: 3,
                ),
                Column(
                  children: [
                    Text("  ${widget.users_model.name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 4,
                    ),
                    Text("  ${widget.users_model.status}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(
                  Icons.call_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CallsScreen()));
                }),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                  decoration: BoxDecoration(

                      color: Colors.grey[300],

                      borderRadius: BorderRadiusDirectional
                          .only(topEnd: Radius.circular(10.0),topStart: Radius.circular(10.0),
                          bottomEnd: Radius.circular(10.0))),
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0),

                  child: Text("${messages.text}",style: TextStyle(fontSize: 14),)

              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                  decoration: BoxDecoration(

                      color: Colors.blue[300],

                      borderRadius: BorderRadiusDirectional
                          .only(topEnd: Radius.circular(10.0),topStart: Radius.circular(10.0),
                          bottomStart: Radius.circular(10.0))),
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0),

                  child: Text("${messages.text}",style: TextStyle(fontSize: 14),)

              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white70,
                    width: 1.0
                ),
                borderRadius: BorderRadius.circular(20.0),

              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // focusNode: focusNode,
                      controller: messageTextController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      onChanged: (value) {
                        messagetext = value;

                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message..",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: IconButton(
                          icon: Icon(
                            show
                                ? Icons.keyboard
                                : Icons.emoji_emotions_outlined,
                          ),
                          onPressed: () {

                            // });
                          },
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.attach_file),
                              onPressed: () {

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: (){
                        sendMessage(reciverId:'${firebaseAuth}',
                            dateTime: DateTime.now().toString(),
                            text: messageTextController.text
                        );
                      },
                      minWidth: 1.0,
                      child: Icon(Icons.send,
                        size: 16,color: Colors.white
                        ,),
                    ),
                  )

                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
