import 'package:flutter_rest_api/Common/Constant.dart';
import 'package:flutter_rest_api/Common/Validate.dart';
import 'package:http/http.dart' as http;

class HTTPExecute {

  Uri endPointUrl;

  HTTPExecute(this.endPointUrl);


  get() async{
    return await Validate.connectionError(method: loadGet);
  }
  post(Map parameters) async{
    return await Validate.connectionError(methodParam: loadPost, parameters: parameters);
  }
  put(Map parameters) async{
    return await Validate.connectionError(methodParam: loadPut, parameters: parameters);
  }
  delete() async{
    return await Validate.connectionError(method: loadDelete);
  }

  loadGet() async{
    var response = await http.get(this.endPointUrl);
    return validateResponse(response);
  }

  loadPost(var parameters) async{
    var response = await http.post(this.endPointUrl, body: parameters);
    return validateResponse(response);
  }

  loadDelete() async{
    var response = await http.delete(this.endPointUrl);
    return validateResponse(response);
  }

  loadPut(var parameters) async{
    var response = await http.put(this.endPointUrl, body: parameters);
    return validateResponse(response);
  }

  validateResponse(response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.toString();
    }
    return Validate.errorWidget(Constant.SERVER_ERROR, content: "${response.statusCode}");
  }
}