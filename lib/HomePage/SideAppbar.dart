import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webino/API/notificationAPI.dart';
import 'package:webino/HomePage/Component/Kalender.dart';
import 'package:webino/HomePage/Feed.dart';
import 'package:webino/ProfilePage/GantiPassword.dart';
import 'package:webino/ProfilePage/Profilepage.dart';

import '../my_flutter_app_icons.dart';

class SideAppbar extends StatefulWidget {
  const SideAppbar({
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
  _SideAppbarState createState() => _SideAppbarState();
}

class _SideAppbarState extends State<SideAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      child: Drawer(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //  physics: const NeverScrollableScrollPhysics(),
                ///    shrinkWrap: true,
                //   padding: EdgeInsets.zero,

                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/Backgrond_sidebar.jpg",
                          ),
                          fit: BoxFit.cover),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.image),
                              )),
                        ),
                        Container(
                          width: 20,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.uName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                widget.uEmail,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.profile,
                              color: Color.fromRGBO(233, 105, 105, 1),
                              size: 26,
                            ),
                            Container(
                              width: 14,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              uName: widget.uName,
                              uEmail: widget.uEmail,
                              storage: widget.storage,
                              image: widget.image,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   height: 40,
                  //   child: TextButton(
                  //     child: Padding(
                  //       padding: EdgeInsets.only(left: 12),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             MyFlutterApp.calendar,
                  //             color: Color.fromRGBO(233, 105, 105, 1),
                  //             size: 26,
                  //           ),
                  //           Container(
                  //             width: 14,
                  //           ),
                  //           Text(
                  //             'Kalender Pengingat',
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => WebinoCalender(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: 40,
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.changepassword,
                              color: Color.fromRGBO(233, 197, 105, 1),
                              size: 26,
                            ),
                            Container(
                              width: 14,
                            ),
                            Text(
                              'Ganti Password',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GantiPassword()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.logout,
                              color: Color.fromRGBO(161, 105, 233, 1),
                              size: 26,
                            ),
                            Container(
                              width: 14,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        await widget.storage.deleteAll();
                        await storage.write(
                            key: "token", value: ""); // .read(key: 'token');

                        NotificationAPI.cancelAll();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedPage(
                              fromPage: "Side",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              MyFlutterApp.helpcenter,
                              color: Colors.black,
                              size: 26,
                            ),
                            Container(
                              width: 14,
                            ),
                            Text(
                              'Syarat dan Ketentuan',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        var url = 'https://webino.id/terms-and-conditions';
                        await _launchUrl(url);
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        var url = 'https://www.instagram.com/webino.id/';
                        await _launchUrl(url);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.contacus,
                              color: Colors.black,
                              size: 26,
                            ),
                            Container(
                              width: 14,
                            ),
                            Text(
                              'Kontak Kami',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
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

  _launchUrl(url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
