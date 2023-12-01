import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectcarwash/services/transaksi.dart';

class TransaksiKarpet extends StatefulWidget {
  const TransaksiKarpet({super.key});

  @override
  State<TransaksiKarpet> createState() => _TransaksiKarpetState();
}

class _TransaksiKarpetState extends State<TransaksiKarpet> {
  List dataReservasi = [];

  TextEditingController _nama = new TextEditingController();
  TextEditingController _hp = new TextEditingController();
  TextEditingController _plat = new TextEditingController();
  TextEditingController _merk = new TextEditingController();
  TextEditingController _total = new TextEditingController();
  TextEditingController _jumlah = new TextEditingController();
  TextEditingController _keterangan = new TextEditingController();
  String _tipe = '';
  String _tipeId = '';
  final formKey = GlobalKey<FormState>();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List detailcuci = [];

  insert() async {
    var res = await TransaksiKarpetService.tambah(
        name: _nama.text,
        no_hp: _hp.text,
        total: _total.text,
        img_path: image?.path,
        keterangan: _keterangan.text);

    //   if (res['status'] == "true") {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           actionsPadding: EdgeInsets.only(top: 10, bottom: 30),
    //           title: Text("Data Berhasil ditambahkan"),
    //           actions: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 ElevatedButton(
    //                     style: ElevatedButton.styleFrom(shape: StadiumBorder()),
    //                     onPressed: () {
    //                       _nama.text = '';
    //                       _plat.text = '';
    //                       _hp.text = '';
    //                       _merk.text = '';
    //                       _tipeId = '';
    //                       _total.text = '';
    //                       Navigator.pop(context, 'Cancel');
    //                     },
    //                     child: Text("OK")),
    //               ],
    //             )
    //           ],
    //         );
    //       },
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text("Gagal melakukan transaksi")));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 2),
                  color: Colors.grey.withOpacity(.25))
            ]),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Transaksi Karpet",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Nama pelanggan',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _nama,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Masukkan nama pelanggan',
                    hintStyle: TextStyle(
                        fontFamily: "Inter", fontWeight: FontWeight.w300)),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Kolom harus diisi';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                'No. Handphone',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _hp,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Masukkan nomor handphone pelanggan',
                    hintStyle: TextStyle(
                        fontFamily: "Inter", fontWeight: FontWeight.w300)),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Kolom harus diisi';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Total harga',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                child: TextFormField(
                  controller: _total,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Total harga',
                      hintStyle: TextStyle(
                          fontFamily: "Inter", fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Jumlah Karpet',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                child: TextFormField(
                  controller: _jumlah,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Jumlah',
                      hintStyle: TextStyle(
                          fontFamily: "Inter", fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Keterangan',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                child: TextFormField(
                  controller: _keterangan,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Keterangan',
                      hintStyle: TextStyle(
                          fontFamily: "Inter", fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  myAlert();
                  // print(image!.path);
                },
                child: Text('Upload Photo'),
              ),
              SizedBox(
                height: 10,
              ),
              //if image not null show the image
              //if image null show text
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.

                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
              SizedBox(height: 28),
              Center(
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text(
                      "TAMBAH",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        insert();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
