import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
final randomColor=[0xffFF0090,0xff7A6CF2,0xff28E0AE,0xffFFAD00];
class CardWeather extends StatelessWidget {
  final String imgPath;
  final String temperature;
  final String dateTime;
  final String cityID;
  final String cityName;
  final String weatherState;
  CardWeather({required this.imgPath,required this.temperature,required this.dateTime,required this.cityID,required this.cityName,required this.weatherState});
  final Random rnd=Random();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(10,10,10,10),
        decoration: BoxDecoration(
            color: Colors.orange[800],
            //border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [
                0.1,
                0.6,
              ],
              colors: [
                Colors.orange,
                Colors.orange.shade800,
              ],
            )
            
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dateTime,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'ID '+cityID,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(80, 80)),
                    //height: MediaQuery.of(context).size.height / 20,
                    child: SvgPicture.asset(
                        'assets/images/weather/svg/'+imgPath,
                        color: Colors.white)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      temperature,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      weatherState,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              cityName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ],
        ));
  }
}
