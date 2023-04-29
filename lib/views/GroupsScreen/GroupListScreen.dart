import 'package:chat_app/views/GroupsScreen/CreateNewGroup.dart';
import 'package:chat_app/views/chats/ChatBoxScreen.dart';
import 'package:chat_app/views/profile/ProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/Users.dart';

class GroupListScreen extends StatefulWidget{
  String? Auth = FirebaseAuth.instance.currentUser?.email;
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups ');
  String groupName = '';

  String getId(String s){
    return s.substring(0,s.indexOf('_'));
  }

  String getName(String s){
    return s.substring(0,s.indexOf('_')+1);
  }
  getUserGroups()async{
    return     FirebaseFirestore.instance.collection('users ').where('uId',isEqualTo: FirebaseAuth.instance.currentUser?.uid) ;
  }


  @override
  void initState() {
    getUserGroups();
  }
  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewGroup()));
          },
          child: Icon(Icons.people_alt_outlined),
         backgroundColor: Colors.purple,
        ),
          body:  Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0,top: 10),
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 5, right: 270, bottom: 10),
                    height: 56,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).
                        push(MaterialPageRoute(builder: (context)=>ProfileScreen()
                        ));
                      },
                      child: Text(
                          "EditProfile",
                          style: TextStyle(color: Colors.white, fontSize: 12)
                      ),
                    ),
                  ),
                ),
 SizedBox(height: 10,),
                Container(
                  margin:EdgeInsets.only(right: 250),
                    child: Text("GroupsList",style: TextStyle(color:Colors.purple,fontSize: 25,
                        fontWeight: FontWeight.w600),)),
                Expanded(
                  child: Container(
                    child: Center(
                        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('groups')
                              // .where('member',arrayContains: '${FirebaseAuth.instance.currentUser?.uid}')
                               .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasError)
                              return Text('Error = ${snapshot.error}');
                            final docs = snapshot.data?.docs;
                            if (snapshot.hasData ) {
                              return ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: docs!.length,
                                  itemBuilder: (_, i) {
                                    final data = docs[i].data();
                                    return ListTile(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                                  ChatBoxScreen(groupName: '${data['groupName']}'
                                                    , groupId: '${data['groupId']}', UserName: '${users_model.name}'
                                                    , groupImage: '${data['groupImage']}',),
                                                    // friendUid: '', friendName: '',
                                                  )
                                              );
                                        },
                                        leading: CircleAvatar(

                                          backgroundColor: Colors.grey[200],
                                          // backgroundImage: NetworkImage('${data['groupImage']}'),
                                          radius: 30,
                                        ),
                                        title: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("${data['groupName']}"),
                                            ),
                                          ],
                                        ),
                                        subtitle:
                                            Text("${data['groupId']}"),
                                        );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(thickness: 0.5,);
                                  });
                            }
                            // }

                            return Center(child: CircularProgressIndicator());
                          },
                        )


                    ),
                  ),
                ),
              ],
            ),
          )
      );

  }
}

class GroupTile extends StatefulWidget{
  final String userName;
  final String groupId;
  final String groupName;

  GroupTile({

 required this.userName, required this.groupId, required this.groupName});
  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
return Container(
  color: Colors.grey,


);

  }
}