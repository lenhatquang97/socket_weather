import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather_submit/common/pages/connectSocket.dart';
import 'package:weather_submit/common/pages/homePage.dart';
import 'package:weather_submit/models/GSocket.dart';

class FlowSignInUpOut {

  static void magicFunction(BuildContext context) async {
    sSocket.listen((data) {
      final serverResponse = String.fromCharCodes(data);
      msg=serverResponse;
      print(serverResponse);
      if (serverResponse.contains('shutdown_server')){
        sSocket.flush();
        sSocket.destroy();
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ConnectSocket()));
      }
      else
        switch (jsonDecode(serverResponse)['status']) {
          case "400":
            if(serverResponse.contains('username')){
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>HomePage()));
            }
          break;
          default:
            showAllDialog(context,'Unsuccessful','Try again!',(){
              Navigator.pop(context);
            });
            break;
      }
    });
  }
}
