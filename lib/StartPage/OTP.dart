import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:webino/API/StartAPI.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webino/HomePage/Feed.dart';
import '../my_flutter_app_icons.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    Key? key,
    @required this.accesstoken,
  }) : super(key: key);
  final accesstoken;

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String pinOTP = "";
  bool complete = false;
  String _otp = "";
  TextEditingController otpcontroller = TextEditingController();

  void resendOTP() => Fluttertoast.showToast(
      fontSize: 13,
      backgroundColor: Color.fromRGBO(137, 196, 224, 1),
      msg: 'Kode OTP telah dikirim ulang');
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
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
                                        "Verifikasi \n" "E-mail",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   child: OTPTextField(
                                  //     otpFieldStyle: OtpFieldStyle(
                                  //       backgroundColor: Colors.white,
                                  //       borderColor:
                                  //           Color.fromRGBO(105, 191, 233, 1),
                                  //     ),
                                  //     length: 6,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     textFieldAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     fieldWidth: 40,
                                  //     fieldStyle: FieldStyle.box,
                                  //     outlineBorderRadius: 15,
                                  //     style: TextStyle(fontSize: 17),

                                  //     // keyboardType: TextInputType.number,
                                  //     onChanged: (pin) {
                                  //       _otp = pin.toString();
                                  //     },
                                  //     onCompleted: (pin) {
                                  //       setState(() {
                                  //         _otp = pin.toString();
                                  //         complete = true;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  Form(
                                    //  key: formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 0),
                                      child: PinCodeTextField(
                                        //  controller: otpcontroller,
                                        // onTap: () {

                                        // },
                                        // dialogConfig: ,
                                        useExternalAutoFillGroup: false,

                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        appContext: context,
                                        //  dialogConfig: null,
                                        // pastedTextStyle: TextStyle(
                                        //   color: Color.fromRGBO(
                                        //       105, 191, 233, 1),
                                        //   fontWeight: FontWeight.bold,
                                        // ),
                                        length: 6,
                                        obscureText: false,
                                        // obscuringCharacter: '*',
                                        // obscuringWidget: FlutterLogo(
                                        //   size: 24,
                                        // ),
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        // validator: (v) {
                                        //   if (v!.length < 3) {
                                        //     return "I'm from validator";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                        //     useExternalAutoFillGroup: true,
                                        pinTheme: PinTheme(
                                          activeFillColor: Colors.white,
                                          selectedColor:
                                              Color.fromRGBO(105, 191, 233, 1),
                                          selectedFillColor: Colors.white,
                                          inactiveColor:
                                              Color.fromRGBO(105, 191, 233, 1),
                                          inactiveFillColor: Colors.white,
                                          activeColor:
                                              Color.fromRGBO(105, 191, 233, 1),
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration:
                                            Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        //    errorAnimationController: errorController,
                                        //    controller: textEditingController,
                                        keyboardType: TextInputType.number,
                                        // boxShadows: [
                                        //   BoxShadow(
                                        //     offset: Offset(0, 1),
                                        //     color: Colors.black12,
                                        //     blurRadius: 10,
                                        //   )
                                        // ],

                                        onCompleted: (v) {
                                          print("Completed");
                                        },
                                        // onTap: () {
                                        //   print("Pressed");
                                        // },
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            _otp = value;
                                          });
                                        },

                                        beforeTextPaste: (num) {
                                          //print("object");
                                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                          return true;
                                        },
                                      ),
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
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              _otp != ""
                                                  ? Color.fromRGBO(
                                                      0, 173, 255, 1)
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
                                          onPressed: () async {
                                            String token = widget.accesstoken;
                                            var otprsp = await otp(_otp, token);

                                            var code = otprsp['code'];
                                            if (code == 200) {
                                              await storage.write(
                                                  key: 'token', value: token);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FeedPage(
                                                    fromPage: "OTP",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.022),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4),
                                            child: Center(
                                              child: Text(
                                                "Verifikasi",
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
                            Container(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                //color: Colors.green,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  // TextAlignVertical.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color.fromRGBO(85, 85, 91, 1),
                                      fontWeight: FontWeight.bold,
                                    ),

                                    text:
                                        "Kode verifikasi telah di kirim ke E-mail anda, silahkan check Inbox atau Spam. ",
                                    //              'Dengan membuat atau mendaftar akun. Anda menyetujui isi ',
                                    children: <TextSpan>[
                                      TextSpan(text: "\n"),
                                      TextSpan(
                                        text: "\n Tidak menerima kode OTP ? ",
                                        style: TextStyle(
                                          color: Color.fromRGBO(85, 85, 91, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = send,
                                        text: "Kirim Ulang",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 20.0),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 20, bottom: 20.0),
                            //   child: Align(
                            //     alignment: Alignment.bottomCenter,
                            //     child: TextSpan()
                            //     // Column(
                            //     //   children: [
                            //     //     Container(
                            //     //       color: Colors.red,
                            //     //       child: Row(
                            //     //         mainAxisAlignment:
                            //     //             MainAxisAlignment.center,
                            //     //         children: [
                            //     //           Text(
                            //     //             "Kode verifikasi telah di kirim ke E-mail anda, silahkan check Inbox atau Spam.",
                            //     //             overflow: TextOverflow.clip,
                            //     //             style: TextStyle(
                            //     //               color:
                            //     //                   Color.fromRGBO(85, 85, 91, 1),
                            //     //               fontWeight: FontWeight.bold,
                            //     //             ),
                            //     //           ),
                            //     //         ],
                            //     //       ),
                            //     //     ),
                            //     //     Row(
                            //     //       mainAxisAlignment:
                            //     //           MainAxisAlignment.center,
                            //     //       children: [
                            //     //         Text(
                            //     //           "Tidak menerima kode OTP ? ",
                            //     //           style: TextStyle(
                            //     //             color:
                            //     //                 Color.fromRGBO(85, 85, 91, 1),
                            //     //             fontWeight: FontWeight.bold,
                            //     //           ),
                            //     //         ),
                            //     //         GestureDetector(
                            //     //           onTap: () async {
                            //     //             String _token = widget.accesstoken;
                            //     //             var resend = await reOTP(_token);
                            //     //             print(resend);
                            //     //             if (resend['code'] == 200) {
                            //     //               resendOTP();
                            //     //             }
                            //     //           },
                            //     //           child: Text(
                            //     //             "Kirim Ulang",
                            //     //             style: TextStyle(
                            //     //               color: Colors.white,
                            //     //               fontWeight: FontWeight.bold,
                            //     //             ),
                            //     //           ),
                            //     //         )
                            //     //       ],
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //   ),
                            // ),
                          ],
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
    );
  }

  send() async {
    String _token = widget.accesstoken;
    var resend = await reOTP(_token);
    if (resend['code'] == 200) {
      resendOTP();
    }
  }
}
