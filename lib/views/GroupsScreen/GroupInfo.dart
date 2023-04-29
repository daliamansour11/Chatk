import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget{
  final String? groupName;
  final String? UserName;
  final String? groupId;
  final String? groupImage;
  String? admin;
  GroupInfo( {
    required this.groupName,
    required this.groupId,
    required this.UserName,
    required this.groupImage,
    required this.admin,

  });

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}
class _GroupInfoState extends State<GroupInfo> {
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:Text("Group Info",style: TextStyle(fontSize: 20,color: Colors.white),),
      backgroundColor: Colors.purple,
       leading: IconButton(onPressed: (){
         Navigator.pop(context);
       }, icon:Icon(Icons.arrow_back_ios,color: Colors.white,)),
        actions: [IconButton(onPressed: (){
        // Navigator.pop(context);
    }, icon:Icon(Icons.exit_to_app ,color: Colors.white,))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
             Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(

                      radius: 30,

                      backgroundColor: Colors.grey[300],

                      child: Text("${widget.groupName!}"
                       //   .substring(0,1).toUpperCase()}"
                             ,style:TextStyle(fontWeight: FontWeight.w700),
                    ),),
                    SizedBox(height: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Group:${widget.groupName}',style:
                    TextStyle(fontWeight: FontWeight.w600),),
                        SizedBox(height: 15,),
                        Text('Admin:${widget.admin!}'),
                // ,style: TextStyle(fontWeight: FontWeight.w600),),
                        SizedBox(height: 15,),
                      ],
                    )

                  ],
                ),
              ),

      SizedBox(height: 10,),
      memberList(),
          ],
        ),
      ),



    );
  }
String getName(String s){
     return s.substring(s.indexOf("_" +"${1}"));
}
  @override
  void initState() {
    getGroupMembeers("${widget.groupId}");
  }



  Future getGroupAdmin(String groupId) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('groups').doc(groupId);
    DocumentSnapshot d = await documentReference.get();

    return d['admin'];
  }
    getGroupMembeers(String geoupId){
    return groupCollection.doc(geoupId).snapshots();
  }

  Widget memberList() {
    return  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('groups').snapshots(),
          builder: (context,AsyncSnapshot snapshot){

      if (snapshot.hasError)
      return Text('Error = ${snapshot.error}');
      final docs = snapshot.data?.docs;
      if(snapshot.hasData){
               // if(docs!= null){
               //    if(snapshot.data['member'].length != 0)
                   return  Expanded(
                     child: Container(
                         child: ListView.builder(
                             itemCount: docs!.length,
                               shrinkWrap: true,
                               physics: BouncingScrollPhysics(),
                               itemBuilder: (context,i){
                                 print("last member");
                                  final member = docs[i].data();
                             return Container(
                               padding:EdgeInsets.symmetric(horizontal: 5,vertical: 10) ,
                               child: ListTile(
                                 leading: CircleAvatar(
                                   radius: 30,
                                   backgroundColor: Colors.grey[200],
                                   backgroundImage:AssetImage("lib/images/chat2.jpg"),
                                 ),
                                 title: Text("${getName("${snapshot.data['member'][i]}")}") ,
                                 subtitle:Text("${widget.groupId}")
                             ));
                           }),

                       ),
                   );

                 }
              // }else{
              //   return Center(
              //     child: Text("NO MEMBERS"),
              //   );
              //    }
           return CircularProgressIndicator();

           }

      );

  }
}