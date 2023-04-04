import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Common/Constant.dart';

class Validate {

  static Widget errorWidget(String error, {String content = ""}) {
    switch(error) {
      case Constant.CONNECTION_DISABLED:
        return textError('Error en la conexión $content');
      case Constant.WIFI_DISABLED:
        return textError('Error en la conexión wifi $content');
      case Constant.SERVER_ERROR:
        return textError('Error en el servidor $content');
      case Constant.MESSAGE:
        return textError(content);
      default:
        return textError(content);
    }
  }

  static textError(text) {
    return Text(text, style: TextStyle( color: Colors.black, fontSize: 40),);
  }

}