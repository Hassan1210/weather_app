import 'Networking.dart';
import 'location.dart';

const apiKey = 'fdffae85314751814e420a23a1fee8af';

class WeatherModel{
  Future<dynamic> getweatherbycity(String city) async{
    Network networking = Network('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var weatherdata = await networking.getdate();
    return weatherdata;
  }

  Future<dynamic>getWlocation() async{
    Location location = Location();
    await location.getlocation();
    Network networking = Network('https://maps.googleapis.com/maps/api/place/nearbysearch/json?types=police&rankby=distance&location=31.984421990986586,73.01397394834223&sensor=true&key=AIzaSyBxzqB4G1i9FsG4xiZ60D938_CK415mTFU');
    var weatherdata = await networking.getdate();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
