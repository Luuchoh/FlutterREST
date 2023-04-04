import 'package:flutter_rest_api/Common/Constant.dart';
import 'package:flutter_rest_api/Common/Validate.dart';
import 'package:http/http.dart' as http;

class HTTPExecute {

  Uri endPointUrl;

  HTTPExecute(this.endPointUrl);


  loadGet() async{
    var response = await http.get(this.endPointUrl);
    validateResponse(response);
  }

  loadPost(Map parameters) async{
    var response = await http.post(this.endPointUrl, body: parameters);
    validateResponse(response);

  }

  loadDelete() async{
    var response = await http.delete(this.endPointUrl);
    validateResponse(response);
  }

  loadPut(Map parameters) async{
    var response = await http.put(this.endPointUrl, body: parameters);
    validateResponse(response);
  }

  validateResponse(response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.toString();
    }
    return Validate.errorWidget(Constant.SERVER_ERROR, content: "${response.statusCode}");
  }
}