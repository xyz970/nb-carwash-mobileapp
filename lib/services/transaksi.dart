import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:projectcarwash/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiServis {
  static tambah({
    required name,
    required plat,
    required hp,
    required merk,
    required tipe,
    required total,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var res = await http.post(
      baseUrl('api/transaksi/insert'),
      body: json.encode({
        "name": name,
        "plate_number": plat,
        "no_hp": hp,
        "merk_model": merk,
        "wash_type_id": tipe,
        "total": total,
        "token": token,
      }),
      headers: {
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Access-Control-Allow-Origin': "*",
        'authorization': "Bearer $token",
      },
    );
    print(res.body);
    var data = json.decode(res.body);

    return data;
  }

  static getDetailPencucian(type) async {
    var res = await http.get(baseUrl('pencucian/detail_pencucian?type=$type'));
    var data = json.decode(res.body);

    return data;
  }
}

class TransaksiKarpetService {
  static tambah({
    required name,
    required no_hp,
    required total,
    required keterangan,
    required img_path,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      'Accept': "application/json",
      'Content-Type': "application/json",
      'Access-Control-Allow-Origin': "*",
      'authorization': "Bearer $token",
    };

    var res = http.MultipartRequest(
      'POST',
      baseUrl('api/transaksi/insert'),
    );
    res.headers.addAll(header);
    // res.headers['Authorization'] = "Bearer $token";
    res.fields['name'] = name;
    res.fields['no_hp'] = no_hp;
    res.fields['total'] = total;
    res.files.add(await http.MultipartFile.fromPath('image', img_path));
    final response = await res.send();
    final responsestr = response.stream.bytesToString();
    print(await responsestr);
    // then((response) {
    //   print(response.stream.bytesToString());
    //   if (response.statusCode == 200) print("Uploaded!");
    // });
    // return response;
    // print(res.body);
    // var data = json.decode(res.body);
  }

  static getDetailPencucian(type) async {
    var res = await http.get(baseUrl('pencucian/detail_pencucian?type=$type'));
    var data = json.decode(res.body);

    return data;
  }
}
