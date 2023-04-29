import 'package:chat_app/views/MessageTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../model/Users.dart';
import '../GroupsScreen/GroupInfo.dart';

TextEditingController _messageController = TextEditingController();

class ChatBoxScreen extends StatefulWidget {
  final String? groupName;
  final String? UserName;
  final String? groupId;
  final String? groupImage;

  ChatBoxScreen({
    required this.groupName,
    required this.groupId,
    required this.UserName,
    required this.groupImage,
  });

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  @override
  CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  // void dispose() {
  //   _messageController.dispose();
  // }
  Users_model users_model = Users_model(
      "", "email", "phone", "password", "", true, "image", "status", []);

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('groups').doc(groupId);
    DocumentSnapshot d = await documentReference.get();

    return d['admin'];

    // DocumentReference documentReference = groupCollection.doc(groupId);
    // DocumentSnapshot documentSnapshot = await documentReference.get();
    // return documentSnapshot['admin'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Expanded(
          flex: 1,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 21.0,
                backgroundImage: NetworkImage('${widget.groupImage}'),
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                children: [
                  Text("  ${widget.groupName}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("  ${widget.groupId}",
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupInfo(
                              groupName: '${widget.groupName}',
                              groupId: '${widget.groupId}',
                              UserName: '${users_model.name}',
                              groupImage: '${widget.groupImage}',
                              admin: '${getGroupAdmin(widget.groupId!)}',
                            )));
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _listMessagesWidget()),
          _inputMessagesTextField(),
        ],
      ),
    );
  }

  _listMessagesWidget() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("groups")
            .doc("${widget.groupId}")
            .collection("messages")
            .orderBy('time')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          print("we are here");
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    print("${snapshot.data.docs[index]['message']}");
                    return MessageTile(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        sendByMe: users_model.name ==
                            snapshot.data.docs[index]['sender']);
                  },
                )
              : Container(
            child: Text("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"),

          );
          return CircularProgressIndicator();
        });
  }

  _inputMessagesTextField() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.purple,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        maxLines: null,
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "type message here",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.camera_alt_outlined, color: Colors.purple),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.link, color: Colors.purple),
                  SizedBox(
                    width: 4,
                  ),
                ],
              ),
            ),
          ),



          SizedBox(
            width: 10,
          ),
          Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(45),
              ),
              child: InkWell(
                onTap: () {
                  setMessage();
                },
                child: Icon(
                  _messageController.text.isEmpty ? Icons.mic : Icons.send,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
  setMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = ({
        'message': _messageController.text,
        'sender': widget.UserName,
        'time': DateTime.now(),
      });
      setMessages("${widget.groupId}", chatMessageMap);
      _messageController.clear();
    }
  }

  setMessages(String groupId, Map<String, dynamic> chatMessageData) {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData["message"],
      "recentMessageSender": chatMessageData["sender"],
      "recentMessageTime": chatMessageData["time"].toString(),
    });
    SetOptions(merge: true);
  }
}

class MessageTile extends StatefulWidget {
  final String message;

  final String sender;

  final bool sendByMe;

  MessageTile(
      {required this.message, required this.sender, required this.sendByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sendByMe ? 0 : 24,
          right: widget.sendByMe ? 24 : 0),
      alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sendByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          color: widget.sendByMe
              ? Colors.purple[400]
              : Colors.blueGrey,
          borderRadius: widget.sendByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.sender.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,

                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5),
          ),
          SizedBox(
            height: 10,
          ),
          Text(" ${ widget.message}"
           ,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
        ]),
      ),
    );
  }
}

