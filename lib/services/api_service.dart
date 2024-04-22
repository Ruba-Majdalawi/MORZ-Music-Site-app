
import 'dart:convert';
import 'package:http/http.dart' as http;



class ApiService {
  static const String baseUrl = 'https://192.168.1.4'; // Replace with your actual API URL

  static Future<http.Response> getData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return response;
  }


  // method for performing login
  Future login(username, password) async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/authLogin.php";
    var res = await http.post(Uri.parse(url),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      return data;
    }
  }

  // method for performing signup
  Future signup(username, password, firstName, lastName, address, email ) async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/authSignup.php";
    var res = await http.post(Uri.parse(url),
      body: {
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'email': email
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      return data;
    }
  }
}