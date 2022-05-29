import 'package:flutter/material.dart';
import 'package:weather_app/Icons.dart';
import 'package:weather_app/WeatherScreen.dart';
import 'WeatherScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationData();
  }
  void getlocationData() async{

    WeatherModel modle =   WeatherModel();
    var weatherdata = await modle.getWlocation();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(
        weatherdata: weatherdata
      );
    }));

  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }}