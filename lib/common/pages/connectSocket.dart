import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:weather_submit/common/pages/signIn.dart';
import 'package:weather_submit/common/widgets/customButton.dart';
import 'package:weather_submit/common/widgets/textFieldContainer.dart';
import 'package:weather_submit/models/validateString.dart';
import 'package:weather_submit/models/GSocket.dart';

class ConnectSocket extends StatefulWidget {
  @override
  _ConnectSocketState createState() => _ConnectSocketState();
}

class _ConnectSocketState extends State<ConnectSocket> {
  final ipAdd = TextEditingController();
  final portName = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Connect to server'),
        backgroundColor: Colors.orange[800],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                  child: SvgPicture.asset(
                      'assets/images/weather/svg/001-sun.svg',
                      color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Weather Forecast',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'IP Address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldContainer(
                    strValid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your IP address';
                      } //else if (!StringValidate.checkIsIP(value))
                      //return 'It is not an IP address';
                      return null;
                    },
                    controller: ipAdd,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Port',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormFieldContainer(
                    strValid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your port';
                      } else if (!StringValidate.checkIsNumber(value))
                        return 'Your port must be a number';
                      return null;
                    },
                    controller: portName,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  name: 'Connect',
                  func: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        print('Checkpoint');
                        sSocket = await Socket.connect(
                            ipAdd.text, int.parse(portName.text));
                        showAllDialog(
                            context, 'Connected', 'Connect successfully', () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => SignInPage()));
                        });
                      } on Exception catch (e) {
                        showAllDialog(context, 'Not connected',
                            "You are not connected because $e", () {
                          Navigator.pop(context);
                        });
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
