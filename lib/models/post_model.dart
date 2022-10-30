class PostModel {
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;


  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.image,
    this.postImage,
    this.uid,
 });

  PostModel.fromMap(Map<String,dynamic> map){
    name = map['name'];
    dateTime = map['dateTime'];
    postImage = map['postImage'];
    image = map['image'];
    text = map['text'];
    uid = map['uid'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'dateTime':dateTime,
      'postImage':postImage,
      'image':image,
      'text':text,
      'uid':uid,
    };
  }


}