import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Common/Constant.dart';

typedef void VoidCallBackParam(Map parameters);

class Validate {

  var data;

  Validate(this.data);

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

  static emptyMap(parameters) {
    return parameters.toString() == '[]' ? null : parameters;
  }

  static connectionError({VoidCallback? method, VoidCallBackParam? methodParam, Map? parameters}) async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none) {
      return errorWidget(Constant.CONNECTION_DISABLED);
    }
    return (emptyMap(parameters) != null)
            ? methodParam!(parameters!)
            : method!();

  }

  isWidget(VoidCallBackParam method) {
    return (data is Widget)
            ? data
            : data.isNotEmpty
              ? method(json.decode(data))
              : null;
  }

  keyExists(String key, {var defaul = ''}) {
    return (data.containsKey(key) && data[key] != null)
            ? data[key]
            : defaul;
  }

}