
class Users_model{

  String? name;
  String? email;
  String? password;
  String? phone;
  String? uId;
  bool? isEmailVerfied;
   String? image;
  String? status;
  List? UserGroups;

  // , key;

  Users_model(
      this.name,
      this.email,
      this.phone,
      this.password,
      this.uId,
      this.isEmailVerfied,
      this.image,
      this.status,
      this.UserGroups
      // this.key,
      );
  Users_model.fromJson(Map<String, dynamic>json)
  {
     name = json["name"];
     email  = json["email"];
     password = json["password"];
     phone = json["phone"];
     uId = json["uId"];
     isEmailVerfied = json["isEmailVerfied"];
      image = json["image"];
     status = json["status"];





  }
  Map<String, dynamic> toMap()
  {
    return{
      'name':name,
      "email":email,
      "password":password,
      "phone":phone,
      "uId":uId,
      "isEmailVerfied":isEmailVerfied ,
      "image":image ,
      "status":status ,
    };


  }
}