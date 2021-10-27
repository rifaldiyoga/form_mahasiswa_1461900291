import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_mahasiswa/model/mahasiswa.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_widget.dart';
import 'package:intl/intl.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

enum JenisKelaminCharacter { l, p }

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final viewKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> jkVal = ["Laki - Laki", "Perempuan"];
  List<String> fakultasList = [
    "FISIP",
    "FEB",
    "TEKNIK",
    "PSIKOLOGI",
  ];
  Map<String, List<String>> prodiList = {
    "FISIP": ["Ilmu Komunikasi", "Administrasi Bisnis", "Administrasi Pubilk"],
    "FEB": ["Ekonomi Manajemen", "Ekonomi Pembangunan", "Ekonomi Akuntansi"],
    "TEKNIK": [
      "Teknik Informatika",
      "Teknik Industri",
      "Teknik Mesin",
      "Teknik Sipil",
      "Teknik Elektro",
      "Teknik Arsitektur"
    ],
    "PSIKOLOGI": ["Psikologi"]
  };
  List<String> hobyList = [
    "Menari",
    "Nonton Film",
    "Sepak Bola",
    "Travelling",
    "Berenang",
    "Bermain Musik"
  ];

  String fakultas = 'FISIP';
  String prodi = 'Ilmu Komunikasi';

  List<String> hobyValList = <String>[];
  JenisKelaminCharacter? jk = JenisKelaminCharacter.l;

  DateTime tglLahir = new DateTime(1000);
  bool isSelected = false;

  final f = new DateFormat('yyyy-MM-dd');

  double marginBetween = 16;

  TextEditingController _txtNIM = new TextEditingController();
  TextEditingController _txtNama = new TextEditingController();
  TextEditingController _txtAlamat = new TextEditingController();
  TextEditingController _txtTglLahir = new TextEditingController();
  TextEditingController _txtEmail = new TextEditingController();
  TextEditingController _txtIPK = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  FocusNode _fnNIM = FocusNode();

  Mahasiswa? mahasiswa;

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _imgFromCamera() async {
      XFile? image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    _imgFromGallery() async {
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
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
          _txtTglLahir.text = f.format(picked);
        });
    }

    isHobySelected(String val) {
      for (int i = 0; i < hobyValList.length; i++) {
        if (val == hobyValList[i]) return true;
      }
      return false;
    }

    Widget checkbox() {
      return Column(
        children: [
          for (var i = 0; i < hobyList.length; i++)
            LabeledCheckbox(
                label: hobyList[i],
                padding: EdgeInsets.all(0),
                value: isHobySelected(hobyList[i]),
                onChanged: () {
                  setState(() {
                    hobyValList.add(hobyList[i]);
                  });
                }),
        ],
      );
    }

    Widget foto() {
      return Container(
        constraints: BoxConstraints(
          minHeight: 200,
          minWidth: 200,
        ),
        child: Column(
          children: [
            Card(
                child: Column(
              children: [
                _image != null
                    ? Image.file(
                        File(
                          _image!.path,
                        ),
                        width: 300,
                        height: 300,
                      )
                    : Image.asset(
                        'assets/image/image.jpg',
                        width: 300,
                        height: 300,
                      ),
              ],
            )),
            RaisedButton(
                child: Text("Pick Image"),
                onPressed: () {
                  _showPicker(context);
                }),
          ],
        ),
      );
    }

    void reset() {
      setState(() {
        mahasiswa = null;
      });
      _txtNIM.text = "";
      _txtNama.text = "";
      _txtTglLahir.text = "";
      _txtEmail.text = "";
      _txtIPK.text = "";
      _image = null;
      hobyValList = [];
      jk = JenisKelaminCharacter.l;
      _txtAlamat.text = "";
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }

    void proses() {
      setState(() {
        mahasiswa = new Mahasiswa();
        mahasiswa!.setNim(int.parse(_txtNIM.text));
        mahasiswa!.setNama(_txtNama.text);
        mahasiswa!.setAlamat(_txtAlamat.text);
        mahasiswa!
            .setJK(jk == JenisKelaminCharacter.l ? "Laki-Laki" : "Perempuan");
        mahasiswa!.setEmail(_txtEmail.text);
        mahasiswa!.setHobi(hobyValList);
        mahasiswa!.setTglLahir(_txtTglLahir.text);
        mahasiswa!.setIpk(double.parse(_txtIPK.text));
        mahasiswa!.setFakultas(fakultas);
        mahasiswa!.setProdi(prodi);
        mahasiswa!.setImgPath(_image!.path);
      });

      print(_image!.path);
      Future.delayed(Duration(milliseconds: 600), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    }

    void validateInput() {
      FormState? form = this.formKey.currentState;
      ScaffoldState? scaffold = this.scaffoldKey.currentState;
      SnackBar message = SnackBar(
        content: Text('Proses validasi berhasil!'),
      );

      if (form!.validate()) {
        proses();
      }
    }

    Widget buttonProses() {
      return Row(
        children: [
          Expanded(
              child: ButtonTheme(
                  child: RaisedButton(
                      child: Text(
                        "Proses",
                        style: TextStyle(color: Color(0xffFFFFFF)),
                      ),
                      onPressed: () {
                        validateInput();
                      }))),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: ButtonTheme(
                  child: RaisedButton(
                      child: Text("Reset",
                          style: TextStyle(color: Color(0xffFFFFFF))),
                      onPressed: () {
                        reset();
                        // FocusScope.of(context).requestFocus(_fnNIM);
                      })))
        ],
      );
    }

    Widget formInput() {
      return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            CustomTextField(
              hintText: "Masukkan NIM",
              labelText: "NIM",
              controller: _txtNIM,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: marginBetween,
            ),
            CustomTextField(
              hintText: "Masukkan Nama",
              labelText: "Nama",
              textInputAction: TextInputAction.next,
              controller: _txtNama,
            ),
            SizedBox(
              height: marginBetween,
            ),
            CustomTextField(
              hintText: "Masukkan Alamat",
              labelText: "Alamat",
              textInputAction: TextInputAction.done,
              controller: _txtAlamat,
            ),
            SizedBox(
              height: marginBetween,
            ),
            Text("Jenis Kelamin"),
            RadioListTile<JenisKelaminCharacter>(
              title: const Text('Laki-Laki'),
              value: JenisKelaminCharacter.l,
              groupValue: jk,
              onChanged: (JenisKelaminCharacter? value) {
                setState(() {
                  jk = value;
                });
              },
            ),
            RadioListTile<JenisKelaminCharacter>(
              title: const Text('Perempuan'),
              value: JenisKelaminCharacter.p,
              groupValue: jk,
              onChanged: (JenisKelaminCharacter? value) {
                setState(() {
                  jk = value;
                });
              },
            ),
            SizedBox(
              height: marginBetween,
            ),
            CustomTextField(
              hintText: "Masukkan Tanggal Lahir",
              labelText: "Tanggal Lahir",
              controller: _txtTglLahir,
              initValue: tglLahir.toString(),
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.datetime,
              onTap: () {
                buildMaterialDatePicker(context);
              },
            ),
            SizedBox(
              height: marginBetween,
            ),
            Text(
              "Hoby",
            ),
            CheckboxGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (selected) => setState(() {
                hobyValList = selected;
              }),
              labels: hobyList,
              checked: hobyValList,
              itemBuilder: (Checkbox cb, Text txt, int i) {
                return Row(
                  children: <Widget>[
                    cb,
                    txt,
                  ],
                );
              },
            ),
            SizedBox(
              height: marginBetween,
            ),
            CustomTextField(
              hintText: "Masukkan Email",
              labelText: "Email",
              controller: _txtEmail,
              textInputAction: TextInputAction.next,
              validator: (data) {
                RegExp regExp = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                if (data.toString().isEmpty) return "Email tidak boleh kosong";
                if (!regExp.hasMatch(data.toString())) {
                  return "Format email salah";
                }
              },
            ),
            SizedBox(
              height: marginBetween,
            ),
            CustomTextField(
              hintText: "Masukkan IPK",
              labelText: "IPK",
              textInputAction: TextInputAction.done,
              controller: _txtIPK,
            ),
            SizedBox(
              height: marginBetween,
            ),
            Text("Fakultas"),
            CustomDropDown(
              value: fakultas,
              itemList: fakultasList,
              onChanged: (data) {
                setState(() {
                  fakultas = data.toString();
                  prodi = prodiList[fakultas]![0];
                });
              },
            ),
            Text("Prodi"),
            CustomDropDown(
              value: prodi,
              itemList: prodiList[fakultas]!,
              onChanged: (data) {
                setState(() {
                  prodi = data.toString();
                });
              },
            ),
            SizedBox(height: marginBetween),
            Text("Foto"),
            foto()
          ],
        ),
      );
    }

    Widget view() {
      double c_width = MediaQuery.of(context).size.width * 0.9;
      return (mahasiswa != null)
          ? Card(
              key: viewKey,
              child: Container(
                width: c_width,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("NIM : "),
                        Text(mahasiswa!.getNim().toString())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [Text("Nama : "), Text(mahasiswa!.getNama())],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Alamat : "),
                        Expanded(child: Text(mahasiswa!.getAlamat()))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Jenis Kelamin : "),
                        Text(mahasiswa!.getJK())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Tanggal Lahir : "),
                        Text(mahasiswa!.getTglLahir())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Hobi : "),
                        Expanded(child: Text(mahasiswa!.getHobi()!.join(", ")))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [Text("Email : "), Text(mahasiswa!.getEmail())],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("IPK : "),
                        Text(mahasiswa!.getIPK().toString())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Fakultas : "),
                        Text(mahasiswa!.getFakultas())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [Text("Prodi : "), Text(mahasiswa!.getProdi())],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Foto"),
                    SizedBox(
                      height: 8,
                    ),
                    _image != null
                        ? Image.file(
                            File(_image!.path),
                            width: 300,
                            height: 300,
                          )
                        : Image.asset(
                            'assets/image/image.jpg',
                            width: 300,
                            height: 300,
                          )
                  ],
                ),
              ))
          : Column();
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Form Mahasiswa"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [formInput(), buttonProses(), view()],
          ),
        ),
      ),
    );
  }
}
