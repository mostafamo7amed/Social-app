class MessageModel {
  String? text;
  String? sender;
  String? receiver;
  String? dateTime;
  String? image;


  MessageModel({
    this.text,
    this.sender,
    this.receiver,
    this.dateTime,
    this.image,

 });

  MessageModel.fromMap(Map<String,dynamic> map){
    text = map['text'];
    dateTime = map['dateTime'];
    receiver = map['receiver'];
    sender = map['sender'];
    image =map['image'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'text':text,
      'sender':sender,
      'receiver':receiver,
      'dateTime':dateTime,
      'image':image,
    };
  }


}