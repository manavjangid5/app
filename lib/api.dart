import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{
  static const baseurl = "http://172.18.23.237/api/" ;
  static addLadle(Map ladleData) async{

    var url = Uri.parse("${baseurl}add_ladle");

    try{
      final res = await http.post(url, body: ladleData);

      if(res.statusCode == 200)
      {
        var data = jsonDecode(res.body.toString());
        print(data);
      }
      else{
        print("status code is not 200");
      }
    }catch(e){
      print("catch block:$e");
    }
  }
}