import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_submit/models/flowSignInUpOut.dart';
import 'package:weather_submit/common/widgets/customButton.dart';
import 'package:weather_submit/common/widgets/textFieldContainer.dart';
import 'package:weather_submit/models/GSocket.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int preventListenAgain=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign in'),
        backgroundColor: Colors.orange[800],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    'Username',
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
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    controller: usernameCtrl,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password',
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
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwordCtrl,
                    isObscure: true,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        name: 'Sign in',
                        func: () async {
                          if (_formKey.currentState!.validate()) {
                            //Ham kiem tra khop chua
                            try {
                              await sendMessage(sSocket,'{"cmd": "login", "data": {"username": \"${usernameCtrl.text}\", "password": \"${passwordCtrl.text}\"}}');
                              if(preventListenAgain==0){
                                FlowSignInUpOut.magicFunction(context);
                                setState(() {preventListenAgain+=1;});
                              }
                                
                      
                              
                            } on Exception catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext cxt) {
                                  return AlertDialog(
                                    title: Text('Unsuccessful'),
                                    content: Text('$e'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    CustomButton(
                        name: 'Sign up',
                        func: () async {
                          //Kiem tra khop chua
                          await sendMessage(sSocket,'{"cmd": "signup", "data": {"username": \"${usernameCtrl.text}\", "password": \"${passwordCtrl.text}\"}}');
                          if(preventListenAgain==0){
                              FlowSignInUpOut.magicFunction(context);
                              setState(() {preventListenAgain+=1;});
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
