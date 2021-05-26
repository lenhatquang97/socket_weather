import 'dart:convert';

class DayWeather {
  final String day;
  final String temperature;
  final String weatherBrief;
  DayWeather({required this.day,required this.temperature,required this.weatherBrief});
}

class Weather {
  late int uid;
  late String name;
  late List<DayWeather> weather;
  Weather({required dynamic json}) {
    this.weather=[];
    this.uid =json['uid'];
    this.name = json['name'];
    json['list'].map((ele) {
      DayWeather wt = DayWeather(day:ele['day'],temperature:ele['nd'],weatherBrief:ele['tt']);
      this.weather.add(wt);
    }).toList();
  }
}
class WeatherDisplay{
  final int uid;
  final String name;
  final String day;
  final String temperature;
  final String weatherBrief;
  WeatherDisplay({required this.uid,required this.name,required this.day,required this.temperature,required this.weatherBrief});
}
bool shouldReturn(String rawJson){
  final jsonArray = jsonDecode(rawJson);
  if(jsonArray!=null && jsonArray['status']=='400')
    return true;
  return false;
}

List<WeatherDisplay> readWeatherArray(String rawJson){
  var displayWeather=<WeatherDisplay>[];
  final jsonArray = jsonDecode(rawJson);
  if(rawJson.contains('name',rawJson.indexOf('name')+4)==false){
    Weather wt=Weather(json: jsonArray['data']);
    wt.weather.map((e){
          WeatherDisplay wd=WeatherDisplay(uid: wt.uid, name: wt.name, day: e.day, temperature: e.temperature, weatherBrief: e.weatherBrief);
          displayWeather.add(wd);
    }).toList();
  }
  else {
    jsonArray['data'].map((element) {
      try{
        Weather wt=Weather(json: element);
      wt.weather.map((e){
          WeatherDisplay wd=WeatherDisplay(uid: wt.uid, name: wt.name, day: e.day, temperature: e.temperature, weatherBrief: e.weatherBrief);
          displayWeather.add(wd);
      }).toList();
      }
      catch(ex){
        print('Pass errors');
      }
    }).toList();
  }

  return displayWeather;
}