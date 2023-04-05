import 'package:flutter_rest_api/Common/Constant.dart';

import 'HTTPExecute.dart';

class EndPoint {

  static getUser(id) {
    return HTTPExecute(generateEndPointUrl('users/$id')).get();
  }

  static getPosts() {
    return HTTPExecute(generateEndPointUrl('posts')).get();
  }

  static insertPosts(parameters) {
    return HTTPExecute(generateEndPointUrl('posts')).post(parameters);
  }

  static updatePosts(parameters) {
    return HTTPExecute(generateEndPointUrl('posts/${parameters['id']}')).put(parameters);
  }

  static deletePosts(id) {
    return HTTPExecute(generateEndPointUrl('posts/$id')).delete();
  }

  static generateEndPointUrl(resource) {
    return Uri.https('${Constant.DOMAIN}','$resource', {'limit': '5'});
  }

}