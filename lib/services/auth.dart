import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectcarwash/config.dart';

class AuthService {
  static login({required email, required password}) async {
    var data = await http.post(baseUrl('api/login'),
        body: json.encode({
          'email': email,
          'password': password,
        }));

    var res = json.decode(data.body);
    print(res);
    return res;
  }
}
