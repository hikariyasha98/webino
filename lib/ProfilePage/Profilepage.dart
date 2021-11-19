import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webino/API/SetApi.dart';
import 'package:webino/HomePage/Feed.dart';
import 'package:webino/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';

class Constants {
  Constants._();
  static const double padding = 20;
}

class SizeConfig {}

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.uName,
    required this.uEmail,
    required this.storage,
    required this.image,
  }) : super(key: key);

  final String image;
  final String uName;
  final String uEmail;
  final FlutterSecureStorage storage;

  @override
  _ProfileState createState() => _ProfileState();
}

// ignore: camel_case_types
class _ProfileState extends State<Profile> {
  TextEditingController nameUser = TextEditingController();
  String newUserName = "";
  File? file;
  PickedFile? fule;
  void reminderSuccess(mesage) => Fluttertoast.showToast(msg: mesage);

  int? val = 0;
  @override
  Widget build(BuildContext context) {
    double cirHeight = 100;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            //suspect
            elevation: 12,
            shadowColor: Colors.black54,
            title: const Text('Profile'),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedPage(
                      fromPage: "Profile",
                    ),
                  ),
                );
              },
              child: Icon(
                MyFlutterApp.back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromRGBO(105, 191, 233, 1),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.873,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/Backgroundprofile.jpg',
                                    ),
                                    fit: BoxFit.fitWidth),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                      child: Container(
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            // 1st container image
                                            Container(
                                              child: file != null
                                                  ? Image.file(
                                                      file!,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : null,
                                              width: 100,
                                              height: cirHeight,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 1,
                                                    offset: Offset(0, 0),
                                                  ),
                                                ],
                                                image: file == null
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            widget.image),
                                                        fit: BoxFit.fill)
                                                    : null,
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            //2nd container button
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                              child: Container(
                                                height: cirHeight,
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 75,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 25,
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      child: Center(
                                                        child: Text(
                                                          "Ganti",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: cirHeight,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: OutlinedButton(
                                                style: ButtonStyle(
                                                  side: MaterialStateProperty
                                                      .all<BorderSide>(
                                                    BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Colors.transparent,
                                                  ),
                                                ),
                                                onPressed: () =>
                                                    showMedia(context),
                                                child: Container(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 12),
                                    child: Container(
                                      child: Text(
                                        widget.uEmail,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 7, left: 32, top: 25),
                                    child: Container(
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.redAccent,
                                        primaryColorDark: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                        ),
                                        child: Container(
                                          height: 50,
                                          child: Container(
                                            child: TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  newUserName = value;
                                                });
                                              },
                                              onSubmitted: (value) {
                                                setState(() {
                                                  newUserName = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 1,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            105, 191, 233, 1),
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            105, 191, 233, 1),
                                                        width: 1.0),
                                                  ),
                                                  hintText: '${widget.uName}',
                                                  prefixText: ""),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 33, right: 33),
                      child: Container(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              newUserName.isEmpty
                                  ? Colors.white
                                  : Color.fromRGBO(105, 191, 233, 1),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                  color: Color.fromRGBO(105, 191, 233, 1),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text("Simpan Perubahan",
                                style: TextStyle(
                                  color: newUserName.isEmpty
                                      ? Color.fromRGBO(105, 191, 233, 1)
                                      : Colors.white,
                                )),
                          ),
                          onPressed: () async {
                            var rspupprof = await userUpdate(newUserName);
                            if (rspupprof['code'] == 200) {
                              var mesage = "Perubahan Telah Tersimpan";
                              reminderSuccess(mesage);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeedPage(
                                      fromPage: "Profile",
                                    ),
                                  ));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

//   _showMessageDialog(BuildContext context) => showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(Constants.padding),
//             ),
//             elevation: 1,
//             backgroundColor: Colors.white,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
// //
//                   width: MediaQuery.of(context).size.width,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Flexible(
//                           flex: 1,
//                           child: Container(
//                             color: Colors.yellow,
//                           ),
//                         ),
//                         Flexible(
//                           flex: 2,
//                           fit: FlexFit.loose,
//                           child: Container(
//                             alignment: AlignmentDirectional.bottomCenter,
//                             child: Title(
//                                 color: Colors.black,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 12, bottom: 12),
//                                   child: Text('Jenis Kelamin',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500)),
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             alignment: AlignmentDirectional.bottomEnd,
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 'Lanjut',
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromRGBO(105, 191, 233, 0.5),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   height: 1,
//                   thickness: 1,
//                   indent: 23,
//                   endIndent: 23,
//                 ),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 37),
//                         child: Text(
//                           'Pria',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 22),
//                         child: Radio(
//                           value: 1,
//                           groupValue: val,
//                           onChanged: (int? value) {
//                             val = value;
//                           },
//                           activeColor: Color.fromRGBO(105, 191, 233, 1),
//                         ),
//                       ),
//                     ]),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 37),
//                         child: Text(
//                           'Wanita',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 22),
//                         child: Radio(
//                           value: 2,
//                           groupValue: val,
//                           onChanged: (int? value) {
//                             val = value;
//                           },
//                           activeColor: Color.fromRGBO(105, 191, 233, 1),
//                         ),
//                       ),
//                     ])
//               ],
//             ),
//           );
//         },
//       );

  void showMedia(BuildContext context) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      //   fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.image),
                ],
              ),
              onPressed: capturePhotoFromGallery,
              //imageFromGallery,
            ),
            SimpleDialogOption(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      //  fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.camera),
                ],
              ),
              onPressed: capturePhotoWithCamera,
              // async => _pickImageFromCamera(),
            ),
          ],
        );
      },
    );
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var imageFile = File(await ImagePicker()
        .pickImage(source: ImageSource.camera)
        .then((value) => value?.path ?? ""));
    // if (imageFile == null) {
    //   return;
    // }
    // .pickImage(
    //     source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0));

    setState(() {
      file = imageFile;
    });
    var image = file;
    var image2 = fule;

    var asd = await uploadImage(image!, image2);
  }

  capturePhotoFromGallery() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var imageFile = File(await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile?.path ?? ""));
    // if (imageFile == null) {
    //   return;
    // }
    // ignore: unrelated_type_equality_checks
    if (imageFile.isAbsolute) {
      setState(() {
        file = imageFile;
      });
      var image = file;
      var image2 = fule;

      var asd = await uploadImage(image!, image2);
    }

    int bytes = await file?.length() ?? 0;

    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var a = ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];

    //  final appDir = await getApplicationDocumentsDirectory();

    // final savedImage = await imageFile.copy('$fileName');
  }
}
