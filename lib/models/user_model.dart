class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.image,
 });

  UserModel.fromMap(Map<String,dynamic> map){
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
    };
  }


}