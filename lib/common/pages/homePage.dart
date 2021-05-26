import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_submit/common/pages/connectSocket.dart';
import 'package:weather_submit/common/widgets/cardWeather.dart';
import 'package:weather_submit/common/widgets/customButton.dart';
import 'package:weather_submit/common/widgets/customTextField.dart';
import 'package:weather_submit/models/validateString.dart';
import 'package:weather_submit/models/weatherInform.dart';
import 'package:weather_submit/models/GSocket.dart';
import 'package:intl/intl.dart';


final mpSvg = {
  "Nóng": "001-sun.svg",
  "Nắng": "001-sun.svg",
  "Mây": "002-cloud.svg",
  "Mây và Nắng": "003-cloudy.svg",
  "Mây và nắng": "003-cloudy.svg",
  "Mưa": "004-rain.svg",
  "Mưa và nắng": "005-rainy.svg",
  "Mưa và Nắng": "005-rainy.svg",
  "Mưa đá": "008-hail.svg",
  "Tuyết": "009-snowy.svg",
  "Gió": "015-windy.svg",
  "Lạnh": "018-cold.svg"
};

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final findController = TextEditingController();
  var weatherArray = <WeatherDisplay>[];
  @override
  Widget build(BuildContext context) {
    print('${sSocket.remoteAddress} and ${sSocket.remotePort}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Homepage'),
        backgroundColor: Colors.orange[800],
        actions: [
          Center(
              child: Text(
            'Logout',
            style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
          )),
          SizedBox(
            width: 5,
          ),
          IconButton(
              onPressed: () async {
                await sendMessage(sSocket,'{"cmd":"logout","data":"noo"}');
                sSocket.flush();
                sSocket.destroy();
                Navigator.push(context,MaterialPageRoute(builder: (context) => ConnectSocket()));
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 30,
              )),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints.tight(const Size(70, 70)),
                          //height: MediaQuery.of(context).size.height / 20,
                          child: SvgPicture.asset(
                              'assets/images/weather/svg/001-sun.svg',
                              color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Weather Forecast',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        hintText: 'CityID or DateTime',
                        strValid: (value) {
                          return null;
                        },
                        controller: findController),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        name: 'Search ID',
                        func: () async {
                          if (StringValidate.checkIsNumber(findController.text)) {
                            await sendMessage(sSocket,'{"cmd":"getcity","data":"${findController.text}"}');
                            if(shouldReturn(msg) && !msg.contains('username')){
                              setState(() {
                                weatherArray=readWeatherArray(msg);
                              });
                            }
                          }
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        name: 'Find all',
                        func: () async {
                          if (findController.text.length == 0 ||StringValidate.checkValidDates(findController.text)) {
                            if (findController.text.length == 0) await sendMessage(sSocket,'{"cmd":"listall","data":"${DateFormat('dd/MM/yyyy').format(DateTime.now())}"}');
                            else await sendMessage(sSocket,'{"cmd":"listall","data":"${findController.text}"}');
                            if(shouldReturn(msg)&&!msg.contains('username')){
                              setState(() {
                                weatherArray=readWeatherArray(msg);
                              });
                            }
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (weatherArray.length != 0)
                  Wrap(
                      children: weatherArray.map((e) {
                    return CardWeather(
                        imgPath: '${mpSvg[e.weatherBrief]}',
                        temperature: '${e.temperature}\'C',
                        dateTime: '${e.day}',
                        cityID: '${e.uid.toString()}',
                        cityName: '${e.name}',
                        weatherState: '${e.weatherBrief}');
                  }).toList()),
              ],
            )),
      ),
    );
  }
}
