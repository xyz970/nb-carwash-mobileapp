import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectcarwash/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservasiService {
  static get() async {
    var res = await http.get(baseUrl('api/booking'));
    var data = json.decode(res.body);

    return data;
  }

  static verif(id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var res = await http.get(baseUrl('api/booking/validasi?id=$id'), headers: {
      'Authorization': "Bearer $token",
      'Accept': "application/json",
      'Access-Control-Allow-Origin': "*",
    });
    print(res.body);

    var data = json.decode(res.body);

    if (data['status'] == "true") {
      return true;
    } else {
      return false;
    }
  }

  static done(id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var res = await http.get(baseUrl('api/booking/selesai?id=$id'), headers: {
      'Authorization': "Bearer $token",
    });

    var data = json.decode(res.body);

    if (data['status'] == "true") {
      return true;
    } else {
      return false;
    }
  }
}
