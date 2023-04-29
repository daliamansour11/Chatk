
class messages_model{
   String? senderId;
  String? text;
  String? reciverId;
  String? time;


  // , key;

  messages_model( {
    this.senderId,
     this.text,
     this.time,
     this.reciverId,
  });
  messages_model.fromJson(Map<String, dynamic>json)
  {
     senderId = json["senderId"];
    text  = json["text"];
    time = json["time"];
    reciverId = json["reciverId"];



  }
  Map<String, dynamic> toMap()
  {
  return{
   'senderId':senderId,
  "text":text,
  "time":time,

  };


  }

}