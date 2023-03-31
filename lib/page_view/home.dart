// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectcarwash/page_view/reservasi.dart' as reservasi;
import 'package:projectcarwash/page_view/transaksi.dart' as transaksi;
import 'package:projectcarwash/page_view/logout.dart';
import 'package:projectcarwash/page_view/transaksiKarpet.dart';
import 'package:projectcarwash/services/reservasi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  List dataReservasi = [];
  int notVerifs = 0;

  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
    getData();
  }

  getData() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      var res = await ReservasiService.get();

      setState(() {
        notVerifs = 0;
      });

      res['data'].forEach((item) {
        if (item['is_valid'] == "false") {
          setState(() {
            notVerifs += 1;
          });
        }
      });

      setState(() {
        dataReservasi = res['data'];
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff8d8ffd),
      appBar: AppBar(
        leading: Image.asset("img/bb.png"),
        leadingWidth: 70.0,
        titleSpacing: 4,
        title: Text("NB-Carwash",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.white),
            tooltip: "Logout",
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return Logout();
                }),
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(
              fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w500),
          controller: controller,
          tabs: [
            Tab(
              text: "Transaksi Karpet",
            ),
            Tab(
              text: "Transaksi",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          new TransaksiKarpet(),
          new transaksi.Transaksi(),
        ],
      ),
    ));
  }
}
