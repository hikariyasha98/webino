import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webino/API/SetApi.dart';

import '../../my_flutter_app_icons.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({Key? key}) : super(key: key);

  @override
  _GantiPasswordPageState createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPassword> {
  TextEditingController _passSignController = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  String _pass = "", _confirmPass = "", _newPass = "";
  bool _password = false, _obsPassword = false, _newPasswordbol = false;
  final focus = FocusNode();
  final focus2 = FocusNode();
  void reminderSuccess(mesage) => Fluttertoast.showToast(msg: mesage);
  var currentFocus;
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocus,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(156, 223, 255, 1),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Image.asset(
                        "assets/images/Background.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              new Positioned(
                top: 50.0,
                left: 0.0,
                right: 0.0,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4.5,
                        //  color: Colors.blue,
                        child: Image.asset(
                          "assets/images/Logo Webino.png",
                          width: MediaQuery.of(context).size.width * 0.382,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      MyFlutterApp.back,
                      color: Colors.white,
                    ),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.white.withOpacity(0.0),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      //  color: Colors.red,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    //   height: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 44.0, left: 44.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          //  color: Colors.red,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //   color: Colors.green,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, bottom: 20.0),
                                        child: Text(
                                          "Ganti Password",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10,
                                      ),
                                      child: Container(
                                        height: 39,
                                        child: TextField(
                                          onEditingComplete: () =>
                                              FocusScope.of(context)
                                                  .requestFocus(focus),
                                          onChanged: (value) {
                                            setState(() {
                                              _pass = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _pass = value;
                                            });
                                          },
                                          obscureText: !this._password,
                                          controller: _passSignController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 1),
                                            //  labelText: "Alamat Email",
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  MyFlutterApp.eye,
                                                  color: Colors.grey,
                                                  size: 26,
                                                ),
                                                onPressed: () {
                                                  setState(() =>
                                                      this._password =
                                                          !this._password);
                                                },
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Password Lama",
                                            hintStyle: TextStyle(
                                                height: 0.5,
                                                color: Colors.grey),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10,
                                      ),
                                      child: Container(
                                        height: 39,
                                        child: TextField(
                                          focusNode: focus,
                                          onEditingComplete: () =>
                                              FocusScope.of(context)
                                                  .requestFocus(focus2),
                                          onChanged: (value) {
                                            setState(() {
                                              _newPass = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _newPass = value;
                                            });
                                          },
                                          obscureText: !this._newPasswordbol,
                                          controller: _newPassword,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 1),
                                            //  labelText: "Alamat Email",
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  MyFlutterApp.eye,
                                                  color: Colors.grey,
                                                  size: 26,
                                                ),
                                                onPressed: () {
                                                  setState(() => this
                                                          ._newPasswordbol =
                                                      !this._newPasswordbol);
                                                },
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Password Baru",
                                            hintStyle: TextStyle(
                                                height: 0.5,
                                                color: Colors.grey),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10,
                                      ),
                                      child: Container(
                                        height: 39,
                                        child: TextField(
                                          focusNode: focus2,
                                          onChanged: (value) {
                                            setState(() {
                                              _confirmPass = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _confirmPass = value;
                                            });
                                          },
                                          obscureText: !this._obsPassword,
                                          controller: _confirmPassword,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 1),
                                            //  labelText: "Alamat Email",
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: IconButton(
                                                icon: Icon(
                                                  MyFlutterApp.eye,
                                                  color: Colors.grey,
                                                  size: 26,
                                                ),
                                                onPressed: () {
                                                  setState(() =>
                                                      this._obsPassword =
                                                          !this._obsPassword);
                                                },
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Confirm Password",
                                            hintStyle: TextStyle(
                                                height: 0.5,
                                                color: Colors.grey),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            (_newPass != "")
                                                ? Color.fromRGBO(
                                                    105, 191, 233, 1)
                                                : Color.fromRGBO(
                                                    156, 223, 255, 1),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              side: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        onPressed: (_pass != "" &&
                                                    _confirmPass != "" &&
                                                    _newPass != "") &&
                                                (_newPass == _confirmPass)
                                            ? () async {
                                                var as = await gantiPassword(
                                                    _pass,
                                                    _newPass,
                                                    _confirmPass);
                                                if (as['code'] == 200) {
                                                } else {
                                                  Map detail =
                                                      as['errorDetails'];
                                                  detail.forEach((key, value) {
                                                    var mesage = value
                                                        .toString()
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "");
                                                    reminderSuccess(mesage);
                                                  });
                                                }
                                                print(as);
                                              }
                                            : (_newPass != _confirmPass)
                                                ? () {}
                                                : null, // () {},
                                        child: Container(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.022),
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1),
                                          child: Center(
                                            child: Text(
                                              "Lanjut",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Masukan E-mail yang terdaftar. "
                          "Kami akan mengirimkan \n"
                          "kode verifikasi atur ulang password ke E-mail Anda.",
                          style: TextStyle(
                            color: Color.fromRGBO(85, 85, 91, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
