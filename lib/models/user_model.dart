class UserModel {
  String? name;
  String? email;
  String? uid;
  String? phone;
  String? image;
  String? bio;
  String? cover;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.bio,
    this.uid,
    this.cover,

 });

  UserModel.fromMap(Map<String,dynamic> map){
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    bio = map['bio'];
    uid = map['uid'];
    cover = map['cover'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
      'bio':bio,
      'uid':uid,
      'cover':cover,
    };
  }


}