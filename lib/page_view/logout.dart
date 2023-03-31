import 'package:flutter/material.dart';
import 'package:projectcarwash/page_view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(top: 10, bottom: 30),
      title: Text("Logout"),
      content: Text("Apakah anda yakin ingin logout?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("IYA")),
            SizedBox(width: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text("TIDAK"))
          ],
        ),
      ],
    );
  }
}
