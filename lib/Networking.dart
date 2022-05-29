import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{

  Network(this.url);
  final String url;

  Future getdate() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      print('Hello');
      String data = response.body;
      var decodedata = jsonDecode(data);
      return decodedata;
    }
    else{
      print(response.body);
    }
  }

}