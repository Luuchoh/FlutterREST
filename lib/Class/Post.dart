import 'package:flutter_rest_api/HttpProtocol/EndPoint.dart';

import '../Common/Validate.dart';

class Post {

  int? id, userId;
  String? title, body;

  Post({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<dynamic, dynamic> data) {
    if(data == null) return Post();

    Validate validate = Validate(data);

    return Post(
      id: validate.keyExists('id', defaul: 0),
      title: validate.keyExists('title'),
      body: validate.keyExists('body'),
      userId: validate.checkInteger(validate.keyExists('userId', defaul: 0)),
    );
  }

  Future getPost() async{
    var data = await EndPoint.getPosts();
    return Validate(data).isWidget(getList);
  }

  getList(data) {
    return (data as List).map((e) => Post.fromJson(e)).toList();
  }

  Future update(parameters) async{
    var data = await EndPoint.updatePosts(parameters);
    print('RESPUESTA $data');

    return Validate(data).isWidget(getObject);
  }

  Future create(parameters) async{
    var data = await EndPoint.insertPosts(parameters);
    print('RESPUESTA $data');

    return Validate(data).isWidget(getObject);
  }

  Future delete() async {
    var data = await EndPoint.deletePosts(id);
    return data;
  }

  getObject(data) {
    return Post.fromJson(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'title': title,
      'body': body,
      'userId': '$userId',
    };
  }

}