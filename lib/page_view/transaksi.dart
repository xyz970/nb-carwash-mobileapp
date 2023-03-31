import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:projectcarwash/services/transaksi.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  List dataReservasi = [];

  TextEditingController _nama = new TextEditingController();
  TextEditingController _hp = new TextEditingController();
  TextEditingController _plat = new TextEditingController();
  TextEditingController _merk = new TextEditingController();
  TextEditingController _total = new TextEditingController();
  String _tipe = '';
  String _tipeId = '';
  final formKey = GlobalKey<FormState>();

  List detailcuci = [];

  insert() async {
    var res = await TransaksiServis.tambah(
        name: _nama.text,
        plat: _plat.text,
        hp: _hp.text,
        merk: _merk.text,
        tipe: _tipeId,
        total: _total.text);

    if (res['status'] == "true") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(top: 10, bottom: 30),
            title: Text("Data Berhasil ditambahkan"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      onPressed: () {
                        _nama.text = '';
                        _plat.text = '';
                        _hp.text = '';
                        _merk.text = '';
                        _tipeId = '';
                        _total.text = '';
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Text("OK")),
                ],
              )
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal melakukan transaksi")));
    }
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
                  "Transaksi",
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
                'Tipe pencucian',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              Container(
                // padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  borderRadius: BorderRadius.circular(10),
                  value: _tipe,
                  onChanged: (val) async {
                    setState(() {
                      _tipe = val.toString();
                    });

                    var res = await TransaksiServis.getDetailPencucian(_tipe);
                    setState(() {
                      _tipeId = '';
                      detailcuci = res;
                    });
                  },
                  validator: (val) {
                    if (val.toString().isEmpty) {
                      return 'Kolom harus diisi';
                    }

                    return null;
                  },
                  items: const [
                    DropdownMenuItem(
                      child: Text(
                        "Pilih tipe pencucian",
                        style: TextStyle(
                            fontFamily: "Inter", fontWeight: FontWeight.w300),
                      ),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text("Motor"),
                      value: "Motor",
                    ),
                    DropdownMenuItem(
                      child: Text("Mobil"),
                      value: "Mobil",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Detail pencucian',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              Container(
                // padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: DropdownButtonFormField(
                  validator: (val) {
                    if (val.toString().isEmpty) {
                      return 'Kolom harus diisi';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  borderRadius: BorderRadius.circular(10),
                  value: _tipeId,
                  onChanged: (val) {
                    setState(() {
                      _tipeId = val.toString();
                    });

                    var indexDariId = detailcuci
                        .indexWhere((element) => _tipeId == element['id']);

                    var dataketemu = detailcuci[indexDariId];
                    _total.text = dataketemu['price'];
                  },
                  items: List.generate(detailcuci.length + 1, (index) {
                    if (index == 0) {
                      return DropdownMenuItem(
                        child: Text(
                          "Pilih detail tipe pencucian",
                          style: TextStyle(
                              fontFamily: "Inter", fontWeight: FontWeight.w300),
                        ),
                        value: "",
                      );
                    } else {
                      var item = detailcuci[index - 1];
                      return DropdownMenuItem(
                        child: Text(
                          item['name'],
                          style: TextStyle(
                              fontFamily: "Inter", fontWeight: FontWeight.w300),
                        ),
                        value: item['id'],
                      );
                    }
                  }),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Plat nomor',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _plat,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Masukkan plat nomor kendaraan',
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
                'Merk kendaraan',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _merk,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Masukkan merk kendaraan bermotor',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                child: TextFormField(
                  enabled: false,
                  controller: _total,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Total harga',
                      hintStyle: TextStyle(
                          fontFamily: "Inter", fontWeight: FontWeight.w300)),
                ),
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
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
