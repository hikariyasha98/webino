import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webino/API/StartAPI.dart';

import 'package:webino/StartPage/OTP.dart';

import 'package:webino/StartPage/StartPage.dart';

import '../../my_flutter_app_icons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameSignController = TextEditingController();
  TextEditingController _emailSignController = TextEditingController();
  TextEditingController _passSignController = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool
//  _email = false,
      _password = false,
      //   _login = true,
      //     _signUp = false,
      _obsPassword = false,
      _checkBox = false,
      //    _type = false,
      _loading = false;
  String _emailSign = "", _passSign = "", _nameSign = "", _confirmPass = "";

  void signFunct() => Fluttertoast.showToast(msg: 'Login Error');
  final focus = FocusNode();

  var currentFocus;
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(156, 223, 255, 1),
      body: GestureDetector(
        onTap: unfocus,
        child: Container(
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
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                  ),
                  Container(
                    //s    height: MediaQuery.of(context).size.height / 2,
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
                                          "Daftar",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        height: 39,
                                        child: TextField(
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          onChanged: (value) {
                                            setState(() {
                                              _nameSign = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _nameSign = value;
                                            });
                                          },
                                          controller: _nameSignController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 1,
                                            ),
                                            hintText: "Name",
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintStyle: TextStyle(
                                                height: 0.5,
                                                color: Colors.grey),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(1)),
                                            ),
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
                                          top: 10.0, bottom: 10),
                                      child: Container(
                                        height: 39,
                                        child: TextField(
                                          onEditingComplete: () =>
                                              node.nextFocus(),
                                          onChanged: (value) {
                                            setState(() {
                                              _emailSign = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _emailSign = value;
                                            });
                                          },
                                          controller: _emailSignController,
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

                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "E-mail",
                                            hintStyle: TextStyle(
                                                height: 0.5,
                                                color: Colors.grey),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                color:
                                                    Colors.white.withOpacity(1),
                                              ),
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
                                          onEditingComplete: () =>
                                              FocusScope.of(context)
                                                  .requestFocus(focus),
                                          onChanged: (value) {
                                            setState(() {
                                              _passSign = value;
                                            });
                                          },
                                          onSubmitted: (value) {
                                            setState(() {
                                              _passSign = value;
                                            });
                                          },
                                          obscureText: !this._password,
                                          controller: _passSignController,
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
                                                      this._password =
                                                          !this._password);
                                                },
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Password",
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
                                    Container(
                                      //  width: double.infinity,
                                      child: Row(
                                        //   mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Checkbox(
                                            value: this._checkBox,
                                            onChanged: (bool? value) {
                                              setState(() =>
                                                  this._checkBox = value!);
                                            },
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: RichText(
                                              textAlign: TextAlign.justify,
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                text:
                                                    'Dengan membuat atau mendaftar akun. Anda menyetujui isi ',
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap =
                                                                reminderAlr,
                                                      text:
                                                          'Persyaratan dan Ketentuan Kebijakan Privasi kami.',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          height: 39,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty
                                                      .all<Color>(Colors.white
                                                          .withOpacity(0.2)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                (_emailSign != "" &&
                                                        _passSign != "" &&
                                                        _nameSign != "" &&
                                                        _confirmPass != "" &&
                                                        _passSign ==
                                                            _confirmPass)
                                                    ? Color.fromRGBO(
                                                        0, 173, 255, 1)
                                                    : Color.fromRGBO(
                                                        156, 223, 255, 1),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            onPressed: _checkBox &&
                                                    (_emailSign != "" &&
                                                        _passSign != "" &&
                                                        _nameSign != "" &&
                                                        _confirmPass != "") &&
                                                    (_passSign == _confirmPass)
                                                ? () async {
                                                    setState(() {
                                                      _loading = true;
                                                    });
                                                    String email = _emailSign;
                                                    String password = _passSign;
                                                    String fn = _nameSign;
                                                    String cp = _confirmPass;
                                                    var signUprsp =
                                                        await signUser(
                                                      email,
                                                      password,
                                                      fn,
                                                      cp,
                                                    );
                                                    var code =
                                                        signUprsp['code'];
                                                    print(code);

                                                    print(signUprsp);

                                                    if (code == 200) {
                                                      setState(() {
                                                        _loading = false;
                                                      });
                                                      var token =
                                                          signUprsp['data']
                                                              ['access_token'];
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OTPPage(
                                                                  accesstoken:
                                                                      token),
                                                        ),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _loading = false;
                                                      });
                                                      if (code == 422) {
                                                        if (signUprsp[
                                                                'errorDetails'] !=
                                                            null) {
                                                          print(
                                                            (signUprsp[
                                                                    'errorDetails']
                                                                ['email']),
                                                          );
                                                          if (signUprsp[
                                                                      'errorDetails']
                                                                  ['email'] !=
                                                              null) {
                                                            print(
                                                                "email wrong");
                                                          }
                                                        } else {
                                                          print(
                                                              "${signUprsp['errorDetails']['password']}");
                                                        }
                                                        // if (signUprsp[
                                                        //             'errorDetails']
                                                        //         ['password'] !=
                                                        //     null) {
                                                        //   print("password wrong");
                                                        // }
                                                      } else {}
                                                    }
                                                  }
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
                                                  "Daftar",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Have an account ? ",
                                        style: TextStyle(
                                          color: Color.fromRGBO(85, 85, 91, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => StartPage(
                                                      tokenAB: "",
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _loading
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 5,
                          child: Image.asset(
                            'assets/images/tLoading.gif',
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  var urla = "https://webino.id/terms-and-conditions";
  Future<void> reminderAlr() => _launchUrl(urla);
  _launchUrl(url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
