

import 'package:chat_app/model/Users.dart';
import 'package:chat_app/views/chats/ChatBoxScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';

import 'ChatsBox.dart';
class ChatScreen extends StatelessWidget{
 List<Users_model> allUsers =  [];
 String? Auth = FirebaseAuth.instance.currentUser?.uid;
 CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups ');
 String groupName = '';
 Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);


 getUserGroups()async{
   return     FirebaseFirestore.instance.collection('users ').where('uId',isEqualTo: FirebaseAuth.instance.currentUser?.uid) ;
   ;
 }

 ChatScreen({
   required this.users_model,
});


 @override
 void initState() {
   getUserGroups();
 }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Center(
        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: FirebaseFirestore.instance
        .collection('users').where('uId',isNotEqualTo: Auth)
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
                      //
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                      ChatBox(users_model:
                                      Users_model(
                                      data['name'],
                                      "",
                                      "",
                                      "",
                                      "",
                                      false,
                                      data['image'],
                                      data['status'],[]),

                                        // friendUid: '', friendName: '',
                                  )
                              ));

                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                           backgroundImage: NetworkImage('${data['image']}'),
                          radius: 30,
                        ),
                        title:  Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                 child: Expanded(
                                     flex: 2,
                                     child: Text("${data['name']}")),

                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Expanded(
                                    flex: 2,
                                    child: Text("now")),

                              ),
                            ],
                          ),

                        subtitle: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text("how are you"),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 180),
                                child: Icon(
                                  Icons.circle, color: Colors.blue, size: 12,)

                            ),
                          ],

                        ));

                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(thickness: 0.5,);
                  });
            }
            // }


            return Center(child: CircularProgressIndicator());
          },
        )


      )
    )
    ;


  }

  // getAllUsersData() {
  //  // Users_model model ;
  //   String? uId;
   //  if(allUsers.length ==0){
  //   FirebaseFirestore.instance.collection('users')
  //       .get()
  //       .then((value) {
  //     print(value.docs);
  //         value.docs.forEach((element) {
  //        if(element.data()['uId'] != users_model.uId)
  //          print(element.data());
  //          allUsers.add(Users_model.fromJson(element.data())) ;
  //         });
  //
  //
  //   })
  //       .catchError((error) {
  //     print(error.toString());
  //   });
  // }}
}






