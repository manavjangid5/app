import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Api {
  static const baseurl = "http://172.18.23.237:5000/api";

  static Future<Map<String, dynamic>> loginUser(String username, String password) async {
    var url = Uri.parse("${baseurl}/login");
    Map<String, dynamic> data = {};

    try {
      final res = await http.post(
        url,
        body: {"username": username, "password": password},
      );
      print("Response: ${res.body}");

      if (res.statusCode == 200) {
        data = (jsonDecode(res.body) as Map<String, dynamic>).map((key,value) => MapEntry(key.toString(), value),);
        print("${data.runtimeType}---------------------Success: $data");
        return data;
      } else {
        print("Error: ${res.statusCode}, Response: ${res.body}");
      }
    } catch (e) {
      print("Unexpected error occurred: $e");
    }

    return {"success": false};
  }


  static Future<void> addLadle(Map<String, dynamic> ladleData) async {

    var url = Uri.parse("${baseurl}/add_ladle");

    try {
      final res = await http.post(url, body: ladleData);
      switch (res.statusCode) {
        case 200:
          var data = jsonDecode(res.body.toString());
          print("Success: $data");
          break;
        case 400:
          print("Bad Request: Check the data being sent.");
          print("Response: ${res.body}");
          break;
        case 401:
          print("Unauthorized: Please check your credentials or authentication token.");
          break;
        case 403:
          print("Forbidden: You do not have the required permissions.");
          break;
        case 404:
          print("Not Found: The requested resource could not be found at $url.");
          break;
        case 500:
          print("Internal Server Error: The server encountered an error.");
          print("Response: ${res.body}");
          break;
        default:
          print("Unhandled Status Code: ${res.statusCode}");
          print("Response: ${res.body}");
      }
    } catch (e) {
      if (e is http.ClientException) {
        print("ClientException: There was an issue with the request. Details: $e");
      } else if (e is FormatException) {
        print("FormatException: Unable to parse the response. Details: $e");
      } else {
        print("Unexpected error occurred: $e");
      }
    }
  }
}