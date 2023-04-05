import 'package:flutter_rest_api/Common/Validate.dart';
import 'package:flutter_rest_api/HttpProtocol/EndPoint.dart';

class User {

  int id;
  String name, userName, email, image;

  User({
    this.id = 0,
    this.name = '',
    this.userName = '',
    this.email = '',
    this.image = '',
  });

  factory User.fromJson(Map<dynamic, dynamic> data) {
    if(data == null) return User();

    Validate validate = Validate(data);

    return User(
      id: validate.keyExists('id', defaul: 0),
      name: validate.keyExists('name'),
      userName: validate.keyExists('userName'),
      email: validate.keyExists('email'),
      // image: validate.keyExists('image'),
    );
  }

  Future getUser(id) async {
    var data = await EndPoint.getUser(id);
    return Validate(data).isWidget(getObject);
  }

  getObject(data) {
    return User.fromJson(data);
  }

}