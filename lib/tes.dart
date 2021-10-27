import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FormPage(),
    );
  }
}

enum JenisKelamin { L, P }

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  File? imageFile;
  final picker = ImagePicker();
  chooseImage(ImageSource source) async{
    final pickedFile = await picker.getImage(source: source);

    setState((){
      imageFile = File(pickedFile!.path);
    });
  }
  JenisKelamin? jk = JenisKelamin.L;
  DateTime tglLahir = new DateTime(1000);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool? hobi = false;
  List<String> fakultasList = ['FISIP', 'FEB', 'TEKNIK', 'PSIKOLOGI'];
  String fakultas = 'FISIP';
  List<String> fisipList = [
    'Ilmu Komunikasi',
    'Administrasi Bisnis',
    'Administrasi Pubilk'
  ];
  String fisip = 'Ilmu Komunikasi';
  List<String> febList = [
    'Ekonomi Manajemen',
    'Ekonomi Pembangunan',
    'Ekonomi Akuntansi'
  ];
  String feb = 'Ekonomi Manajemen';
  List<String> teknikList = [
    'Teknik Informatika',
    'Teknik Industri',
    'Teknik Mesin',
    'Teknik Sipil',
    'Teknik Elektro',
    'Teknik Arsitektur'
  ];
  String teknik = 'Teknik Informatika';
  List<String> psikologiList = ['Psikologi'];
  String psikologi = 'Psikologi';
  List<String> prodiList = [
    'Ilmu Komunikasi',
    'Administrasi Bisnis',
    'Administrasi Pubilk'
  ];
  String prodi = 'Ilmu Komunikasi';
  List<String> hobiList = [];

  TextEditingController txtNIM = new TextEditingController();
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtAlamat = new TextEditingController();
  TextEditingController txtTglLahir = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtIPK = new TextEditingController();

  String nim = "";
  String nama = "";
  String alamat = "";
  String tgl = "";
  String email = "";
  String ipk = "";
  String jks = "";
  String prod = "";
  String fak = "";
  bool? menari = false;
  bool? nontonfilm = false;
  bool? sepakbola = false;
  bool? traveling = false;
  bool? berenang = false;
  bool? bermainmusik = false;
  final format = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    void validateInput() {
      FormState? form = this.formKey.currentState;
      ScaffoldState? scaffold = this.scaffoldKey.currentState;
      SnackBar message = SnackBar(
        content: Text('Proses validasi berhasil!'),
      );

      // if (form!.validate()) {
      // ignore: deprecated_member_use
      // scaffold!.showSnackBar(message);
      // }
    }

    buildMaterialDatePicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != tglLahir)
        setState(() {
          txtTglLahir.text = format.format(picked);
        });
    }

    void proses() {
      setState(() {
        nim = txtNIM.text;
        nama = txtNama.text;
        alamat = txtAlamat.text;
        tgl = txtTglLahir.text;
        email = txtEmail.text;
        ipk = txtIPK.text;
        fak = fakultas;
        prod = prodi;
        jks = jk == JenisKelamin.L ? "Laki - Laki" : "Perempuan";
      });
    }

    void reset() {
      setState(() {
        txtNIM.text = '';
        txtNama.text = '';
        txtAlamat.text = '';
        txtTglLahir.text = '';
        txtEmail.text = '';
        txtIPK.text = '';
        nim = "";
        nama = "";
        alamat = "";
        tgl = "";
        email = "";
        ipk = "";
        jks = "";
        jk = JenisKelamin.L;
        prod = "";
        fak = "";
        menari = false;
        nontonfilm = false;
        sepakbola = false;
        traveling = false;
        berenang = false;
        bermainmusik = false;
      });
    }

    void cekhobi(value) {
      if (hobiList.contains(value)) {
        hobiList.remove(value);
      } else {
        hobiList.add(value);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: txtNIM,
                    keyboardType: TextInputType.number,
                    validator: (data) {
                      if (data.toString().isEmpty) {
                        return 'NIM tidak boleh kosong';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'NIM',
                        hintText: 'NIM',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtNama,
                    validator: (data) {
                      if (data.toString().isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Nama',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtAlamat,
                    validator: (data) {
                      if (data.toString().isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Alamat',
                        hintText: 'Alamat',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<JenisKelamin>(
                          title: Text('Pria'),
                          value: JenisKelamin.L,
                          groupValue: jk,
                          onChanged: (JenisKelamin? value) {
                            setState(() {
                              jk = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<JenisKelamin>(
                          title: Text('Wanita'),
                          value: JenisKelamin.P,
                          groupValue: jk,
                          onChanged: (JenisKelamin? value) {
                            setState(() {
                              jk = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtTglLahir,
                    validator: (data) {
                      if (data.toString().isEmpty) {
                        return 'Tanggal Lahir tidak boleh kosong';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        hintText: 'Tanggal Lahir',
                        border: OutlineInputBorder()),
                    onTap: () {
                      buildMaterialDatePicker(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hobby',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: menari,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Menari');
                                menari = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Menari"))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: nontonfilm,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Nonton Film');
                                nontonfilm = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Nonton Film"))
                        ],
                      )),
                      //CheckboxListTile(title: Text('Menari'),value: hobi,onChanged: (bool? newValue){},),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: sepakbola,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Sepak Bola');
                                sepakbola = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Sepak Bola"))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: traveling,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Traveling');
                                traveling = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Traveling"))
                        ],
                      )),
                      //CheckboxListTile(title: Text('Menari'),value: hobi,onChanged: (bool? newValue){},),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: berenang,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Berenang');
                                berenang = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Berenang"))
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: bermainmusik,
                            onChanged: (bool? newValue) {
                              setState(() {
                                cekhobi('Bermain Musik');
                                bermainmusik = newValue;
                              });
                            },
                          ),
                          Expanded(child: Text("Bermain Musik"))
                        ],
                      )),
                      //CheckboxListTile(title: Text('Menari'),value: hobi,onChanged: (bool? newValue){},),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Email harus valid!';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtIPK,
                    validator: (data) {
                      if (data.toString().isEmpty) {
                        return 'IPK tidak boleh kosong';
                      }
                      if (int.parse(data.toString()) > 4) {
                        return 'IPK tidak boleh lebih dari 4';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'IPK',
                        hintText: 'IPK',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fakultas',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: fakultas,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (data) {
                      setState(() {
                        fakultas = data.toString();
                        String val = data.toString();
                        if (val == 'FISIP') {
                          prodiList = fisipList;
                          prodi = fisipList[0];
                        } else if (val == 'FEB') {
                          prodiList = febList;
                          prodi = febList[0];
                        } else if (val == 'TEKNIK') {
                          prodiList = teknikList;
                          prodi = teknikList[0];
                        } else if (val == 'PSIKOLOGI') {
                          prodiList = psikologiList;
                          prodi = psikologiList[0];
                        }
                      });
                    },
                    items: fakultasList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Text(value)),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Prodi',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: prodi,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (data) {
                      setState(() {
                        prodi = data.toString();
                      });
                    },
                    items:
                        prodiList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Text(value)),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Foto',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              child: imageFile != null
                                  ? Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: FileImage(imageFile),
                                      )),
                                    )
                                  : Container(
                                      height: 200,
                                      width: 200,
                                      decoration:
                                          BoxDecoration(color: Colors.grey))),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                      onPressed: (){
                                        chooseImage(ImageSource.camera);
                                      },
                                      color: Colors.redAccent,
                                      child: Text("Camera",style: TextStyle(
                                        color: Colors.white
                                      ),)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                      onPressed: (){
                                        chooseImage(ImageSource.gallery);
                                      },
                                      color: Colors.redAccent,
                                      child: Text("Gallery",style: TextStyle(
                                          color: Colors.white
                                      ),)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonTheme(
                              child: RaisedButton(
                        onPressed: () {
                          validateInput();
                          proses();
                        },
                        child: Text(
                          'Proses',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ))),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: ButtonTheme(
                              child: RaisedButton(
                                  onPressed: () {
                                    reset();
                                  },
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  ))))
                    ],
                  ),
                  Text(
                    'Hasil',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [Text('NIM : '), Text(nim)]),
                  Row(children: [Text('Nama : '), Text(nama)]),
                  Row(children: [Text('Alamat : '), Text(alamat)]),
                  Row(children: [Text('Jenis Kelamin : '), Text(jks)]),
                  Row(children: [Text('Tanggal Lahir : '), Text(tgl)]),
                  Row(children: [Text('Hobby : '), Text(hobiList.join(','))]),
                  Row(children: [Text('Email : '), Text(email)]),
                  Row(children: [Text('IPK : '), Text(ipk)]),
                  Row(children: [Text('Fakultas : '), Text(fak)]),
                  Row(children: [Text('Prodi : '), Text(prod)]),
                ],
              ),
            )),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets? padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding!,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label))
          ],
        ),
      ),
    );
  }
}
