import 'dart:io';
import 'package:flutter/material.dart';

var sSocket;
var msg;
var breakpoint = 1;
void showAllDialog(BuildContext cxt, String name, String description,VoidCallback callback) {
    showDialog(
      context: cxt,
      builder: (BuildContext cxt) {
        return AlertDialog(
          title: Text(name),
          content: Text(description),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: callback,
            )
          ],
        );
      },
    );
}
Future<void> sendMessage(Socket socket, String message) async {
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(seconds: 2));
}