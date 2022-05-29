import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constents.dart';
import 'Icons.dart';

class WeatherScreen extends StatefulWidget {

  WeatherScreen({required this.weatherdata});

  final weatherdata;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late String condition;
  late int temprature;
  late String cityName;
  late String wicons;
  late String ticons;
  WeatherModel icons = WeatherModel();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    updateUI(widget.weatherdata);
  }

  void updateUI(dynamic weather){
    setState(() {
      if(weather == null){
        temprature = 0;
        ticons = 'Something went wrong';
        wicons = 'Error';
        cityName = '';
        return;
      }
      double temp = weather['main']['temp'];
      temprature = temp.toInt();
      var condition  = weather['weather'][0]['id'];

      wicons = icons.getWeatherIcon(condition);
      ticons = icons.getMessage(temprature);

      cityName   = weather['name'];

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () async{
                        var weatherdata = await icons.getWlocation();
                        updateUI(weatherdata);
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 50,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () async{
                        var name = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if(name != null){
                          print(name);
                          var weatherdata = await icons.getweatherbycity(name);
                          updateUI(weatherdata);
                        }

                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '$temprature°',
                      style: kTempratureText,
                    ),
                  ),
                  Text(
                    wicons,
                    style: kLogoSize,

                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "$ticons in $cityName!",
                  textAlign: TextAlign.right,
                  style: kCityText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget> [
                Align(
                  alignment: Alignment.topLeft,
                  child:GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,
                      size: 50,
                    ),
                  ),
                ),

              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black
                  ),
                  onChanged: (value){
                    cityName = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    hintStyle:TextStyle(
                      color: Colors.grey
                    ),
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 35,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context,cityName);
                  },
                  child: Text('Get Weather',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
