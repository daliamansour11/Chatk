import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatGroupData{

  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups');



  getChats(String groupid){
    return groupCollection
        .doc(groupid)
        .collection('messages')
        .orderBy('time')
        .snapshots();

  }

  Future getGroupAdmin(String groupId)async{
    DocumentReference documentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot =await documentReference.get();
    return documentSnapshot['admin'];
  }
 getGroupMembeers(String geoupId){
    return groupCollection.doc(geoupId).snapshots();
 }

  // saving the data to SF


  static  saveUserLoggedInStatus(bool isUserLoggedIn) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static saveUserNameSF(String userName) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return await sf.setString(userNameKey, userName);
  }

  static  saveUserEmailSF(String userEmail) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return await sf.setString(userEmailKey, userEmail);
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }

  // getting the data from SF

  static Future<bool?> getUserLoggedInStatus() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userNameKey);
  }
  }



class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
  FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "name": fullName,
      "email": email,
      "UserDroups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}