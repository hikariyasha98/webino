import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_share/social_share.dart';
import 'package:webino/API/SetApi.dart';

import 'package:webino/ReminderPage/Reminder.dart';
import 'package:webino/StartPage/StartPage.dart';
import 'Feed.dart';
import 'ReminderButton.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_flutter_app_icons.dart';

class DetailFeed extends StatefulWidget {
  const DetailFeed({
    Key? key,
    @required this.slug,
    @required this.date,
    required this.from,
  }) : super(key: key);
  final slug;
  final date;
  final bool from;
  @override
  _DetailFeedState createState() => _DetailFeedState();
}

class _DetailFeedState extends State<DetailFeed> {
  Color sysolay = Color.fromRGBO(156, 223, 255, 1);
  DateTime now = new DateTime.now();
  DateTime dueDate = DateTime.now();
  ScrollController scrollController =
      new ScrollController(initialScrollOffset: 0.0);
  String token = '';
  Map produk = {};
  List category = [];
  List reminder = [];
  List<String> categorySTR = [];
  bool _loading = true, error = false, remindsudah = false;
  String name = "",
      tgl = "",
      wkt = "",
      status = "",
      jenisPembayaran = "",
      image = "",
      insta = "",
      instalink = "",
      description = "",
      linksource = "",
      source = "",
      location = "",
      image2 =
          "https://webino.id/themes/webino/assets/images/Logo%20Webino.png";
  int id = 0;

  double _opacity = 0.0;
  void initState() {
    super.initState();
    this.fetchProduk();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  fetchProduk() async {
    if (widget.date.toString().isNotEmpty) {
      var tglAcara = widget.date.toString();

      //var dueDate123 = DateTime.tryParse(widget.date.toString());
      //print(dueDate123);
      var tryParsedue = DateTime.tryParse(tglAcara);
      DateTime dueDates = DateTime(
        tryParsedue!.year,
        tryParsedue.month,
        tryParsedue.day,
        tryParsedue.hour,
        tryParsedue.minute - 30,
      );
      setState(() {
        dueDate = dueDates;
      });
    } else {
      // Navigator.pop(context);
    }

    if (widget.slug.toString().isEmpty && widget.date.toString().isEmpty) {
      setState(() {
        _loading = false;
        error = true;
      });
    }
    final storage = new FlutterSecureStorage();
    var tokenA = await storage.read(key: 'token');
    if (tokenA.toString().isNotEmpty ||
        tokenA.toString() != "null" ||
        tokenA.toString() != "Guest") {
      setState(() {
        token = tokenA.toString();
      });
    }
    var dproduk = await detailProduk(token, widget.slug);

    if (dproduk['code'] == 200) {
      if (dproduk['data'] != null) {
        setState(() {
          produk = dproduk['data'];
        });
      }

      if (produk['name'] != null) {
        setState(() {
          name = produk['name'].toString();
        });
      }
      if (produk['id'] != null) {
        setState(() {
          id = produk['id'];
        });
      }
      if (produk['tanggal_acara'] != null) {
        setState(() {
          tgl = produk['tanggal_acara'].toString().split("_")[0];
        });
      }
      if (produk['waktu'] != null) {
        setState(() {
          wkt = produk['waktu'];
        });
      }
      if (produk['jenis_pembayaran'] != null) {
        setState(() {
          jenisPembayaran = produk['jenis_pembayaran'].toString();
        });
      }
      if (produk['status'] != null) {
        setState(() {
          status = produk['status'].toString();
        });
      }

      if (status != 'Online') {
        if (produk['city_type'] == 'Kabupaten') {
          setState(() {
            location = "Kab. ${produk['city']}";
          });
        } else {
          setState(() {
            location = produk['city'];
          });
        }
      }

      if (produk['featured_image'] != null) {
        setState(() {
          image = produk['featured_image'];
        });
      }

      if (produk['link_source'] != null) {
        setState(() {
          linksource = produk['link_source'].toString();
        });
      }
      if (produk['description'] != null) {
        setState(() {
          description = produk['description'];
        });
      }
      if (produk['source'] != null) {
        setState(() {
          source = produk['source'].toString();
        });
        if (produk['categori'] != null) {
          List<String> change = [];

          setState(() {
            category = produk['categori'];
          });
          category.forEach((element) {
            change.add(element['nameb'].toString());
          });
          setState(() {
            categorySTR = change;
          });
        }
      }

      for (int i = 1; i <= 3; i++) {
        reminder.add(produk['reminder_$i']);
      }
      reminder.forEach((element) {
        if (element != null) {
          setState(() {
            remindsudah = true;
          });
        }
      });

      //  produk['reminder_1']

      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        error = true;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }

  void reminderExpired() => Fluttertoast.showToast(
      msg: "Reminder Melebihi Acara", gravity: ToastGravity.CENTER);
  // void reminderToday() => Fluttertoast.showToast(
  //     msg: "Tidak Bisa Reminder Ketika Hari H", gravity: ToastGravity.CENTER);
  void reminderAlr() => Fluttertoast.showToast(
      msg: "Acara Sudah Pernah Direminder", gravity: ToastGravity.CENTER);

  late Stream<FileResponse> fileStream;
  // late Stream<FileResponse> fileStrom;

  void _downloadFile() {
    setState(() {
      fileStream =
          DefaultCacheManager().getFileStream(image, withProgress: true);
      // fileStrom =
      //     DefaultCacheManager().getFileStream(image2, withProgress: true);
    });
  }

  void _scrollListener() {
    double newOpacity;
    if (scrollController.offset > (MediaQuery.of(context).size.height / 3.2)) {
      newOpacity = 1;
    } else if (scrollController.offset < 100) {
      newOpacity = 0;
    } else {
      newOpacity = double.parse(scrollController.offset.toString()) /
          (MediaQuery.of(context).size.height / 3.2).toDouble();
    }
    if (_opacity != newOpacity) {
      setState(() {
        _opacity = newOpacity;
      });
    }
  }

  _launchUrl(url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  @override
  Widget build(BuildContext context) {
    var category2 =
        categorySTR.toString().replaceAll("[", "").replaceAll("]", "");
    if (_loading) {
      return Container(
        color: Colors.white,
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
      );
    } else {
      // var height = MediaQuery.of(context).size.height;
      // var width = MediaQuery.of(context).size.width;

      return WillPopScope(
        onWillPop: () async {
          setState(() {
            sysolay = Colors.transparent;
          });

          widget.from
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedPage(
                      fromPage: "Detail",
                    ),
                  ),
                )
              : Navigator.pop(context, false);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight *
                0.7, //MediaQuery.of(context).size.height * 0.04,
            flexibleSpace: Image(
              height:
                  ((kToolbarHeight * 0.7) + MediaQuery.of(context).padding.top),
              image: AssetImage("assets/images/navbar.jpg"),
              fit: BoxFit.fill,
            ),
            leading: GestureDetector(
              onTap: () async {
                // NotificationAPI.cancel(id);
                widget.from
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedPage(
                            fromPage: "Detail",
                          ),
                        ),
                      )
                    : Navigator.pop(context);
              },
              child: Icon(
                MyFlutterApp.back,
                color: Colors.white,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(156, 223, 255, 1),
            actions: [
              Reminderbutton(
                token: token,
                pB: 2,
                pL: 0,
                pR: 16,
                pT: 0,
                size: 26,
              ),
              error
                  ? Container()
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        _downloadFile();
                        showModalBottomSheet<dynamic>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return SingleChildScrollView(
                              child: ShareModal(
                                image: image,
                                link: widget.slug,
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // top: 19,
                          bottom: 2,
                          right: 21.63,
                        ),
                        child: Center(
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(MyFlutterApp.share,
                                //  size: 24,
                                color: // (_opacity < 0.7)
                                    // ?
                                    Colors.white

                                //   : Colors.black,
                                ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          body: error
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 47.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/ilustrasi.png",
                          width: MediaQuery.of(context).size.width * 0.382,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(
                            "Data Tidak Ditemukan",
                            style: TextStyle(
                              color: Color.fromRGBO(85, 85, 91, 1),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Go Back'))
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        // Container(
                        //   color: Colors.blue,
                        //   height: 100,
                        //   child: CachedNetworkImage(
                        //     imageUrl:
                        //         "https://webino.id/themes/webino/assets/images/Logo%20Webino.png",
                        //   ),
                        // ),
                        Container(
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullImage(
                                        image: image,
                                      ),
                                    ));
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    // height:
                                    //     ((height > width) ? height : width) * 0.45,
                                    child: image != ""
                                        ? FadeInImage(
                                            image: CachedNetworkImageProvider(
                                              image,
                                            ),
                                            placeholder: AssetImage(
                                                "assets/images/load.jpg"),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/Picture not found.jpg',
                                                  fit: BoxFit.cover);
                                            },
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/Picture not found.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                      right: 10,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      // foregroundDecoration:
                                      //     BoxDecoration(color: Colors.transparent),
                                      //  alignment: Alignment.bottomRight,
                                      //  color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.zoom_out_map_rounded,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Container(
                            //title
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.8,
                                          child: Text(
                                            name.isNotEmpty
                                                ? name
                                                : "Future Executive Seminar",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            child: Text(
                                              "$category2",
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white
                                                      .withOpacity(0.2)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            now.isBefore(dueDate) &&
                                                    !remindsudah
                                                ? Color.fromRGBO(
                                                    105, 191, 233, 1)
                                                : remindsudah
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              side: BorderSide(
                                                  color: now.isBefore(dueDate)
                                                      ? Color.fromRGBO(
                                                          105, 191, 233, 1)
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ),
                                        onPressed: token == "Guest" ||
                                                token.toString().isEmpty ||
                                                token.toString() == 'null'
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StartPage(
                                                      tokenAB: token,
                                                    ),
                                                  ),
                                                );
                                              }
                                            : () async {
                                                if (now.isBefore(dueDate) &&
                                                    !remindsudah) {
                                                  var rldd = await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ReminderDialog(
                                                          //  refresh:
                                                          //        fetchProduk(),
                                                          dataAll: produk,
                                                          update: "",
                                                          dueDate: widget.date,
                                                          data: [
                                                            false,
                                                            false,
                                                            false
                                                          ],
                                                          id: id);
                                                    },
                                                  );

                                                  if (rldd == true) {
                                                    await fetchProduk();
                                                  }
                                                } else if (remindsudah) {
                                                  reminderAlr();
                                                }
                                                // else if (nowDate == dueDate) {
                                                //   reminderToday();
                                                // }
                                                else {
                                                  reminderExpired();
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
                                              0.277777778),
                                          child: Center(
                                            child: Text(
                                              !remindsudah
                                                  ? "Reminder"
                                                  : "Remindered",
                                              style: TextStyle(
                                                  color: remindsudah &&
                                                          now.isBefore(dueDate)
                                                      ? Color.fromRGBO(
                                                          105, 191, 233, 1)
                                                      : remindsudah
                                                          ? Colors.grey
                                                          : Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 17.0,
                                    bottom: 13.0,
                                  ),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.calendar,
                                      color: Colors.black,
                                      //  size: 12,
                                    ),
                                    Container(
                                      width: 9.5,
                                    ),
                                    Text(
                                      tgl.isNotEmpty ? tgl : "10 November 2025",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        //        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5.5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.time,
                                      color: Colors.black,
                                      //    size: 12,
                                    ),
                                    Container(
                                      width: 9.5,
                                    ),
                                    Text(
                                      wkt.isNotEmpty ? wkt : "12.00 - 14.00",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        //   fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5.5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.location,
                                      color: Colors.black,
                                      //  size: 12,
                                    ),
                                    Container(
                                      width: 9.5,
                                    ),
                                    Text(
                                      status.isNotEmpty
                                          ? status != 'Online'
                                              ? location
                                              : status
                                          : "Coming Soon",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        //   fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5.5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.web,
                                      color: Colors.black,
                                      //     size: 12,
                                    ),
                                    Container(
                                      width: 9.5,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var url;
                                        if (linksource.toString().isNotEmpty &&
                                            linksource != "") {
                                          url = linksource;
                                          await _launchUrl(url);
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          (source.toString().isNotEmpty &&
                                                  source.toString() != "null")
                                              ? source
                                              : "@seminaronline_malang",
                                          style: TextStyle(
                                            color: (source
                                                        .toString()
                                                        .isNotEmpty &&
                                                    source.toString() != "null")
                                                ? Colors.blue
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            //       fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5.5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.ticket,
                                      color: Color.fromRGBO(105, 191, 233, 1),
                                      //   size: 12,
                                    ),
                                    Container(
                                      width: 9.5,
                                    ),
                                    Text(
                                      jenisPembayaran.isNotEmpty
                                          ? jenisPembayaran
                                          : "Gratis",
                                      style: TextStyle(
                                        color: Color.fromRGBO(105, 191, 233, 1),
                                        fontWeight: FontWeight.w500,
                                        //  fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.5),
                          thickness: 5,
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 100,
                        //   color: Colors.red,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 17.0,
                            left: 14,
                            right: 14,
                          ),
                          child: Container(
                            //     color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  description.toString().isNotEmpty
                                      ? description
                                      : "The seminar will introduce you to the work of the Homer Multitext project. Our focus this year will be on Iliad 12 in the oldest complete manuscript of the Iliad, the Venetus A. Participants will work in teams of 2-3 student and faculty members to contribute to the first complete edition of the Venetus A ever. Our general pattern of work will begin each morning and afternoon with a group seminar session, followed by a break-out at midmorning and midafternoon to work in teams on the following projects.",
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          //    color: Colors.white,
                          child: AspectRatio(
                            aspectRatio: 2.6 / 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    }
  }
}

class FullImage extends StatefulWidget {
  const FullImage({
    Key? key,
    @required this.image,
  }) : super(key: key);
  final image;
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: PhotoView(
          //  initialScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          minScale: PhotoViewComputedScale.contained * 1.0,
          imageProvider: NetworkImage(widget.image),
        ),
      ),
    );
  }
}

class ShareModal extends StatefulWidget {
  const ShareModal({Key? key, required this.image, required this.link})
      : super(key: key);

  final String image, link;
  @override
  _ShareModalState createState() => _ShareModalState();
}

class _ShareModalState extends State<ShareModal> {
  bool setImage = false;
  String settheImage = "";
  String setImage2 = "";
  String asd = "";
  @override
  Widget build(BuildContext context) {
    // var bodyHeight = (MediaQuery.of(context).size.height /
    //     ((MediaQuery.of(context).size.width) > 600 ? 1.2 : 1.8));
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: Colors.white,
        // padding: EdgeInsets.fromLTRB(
        //   10,
        //   10,
        //   10,
        //   0,
        // ),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 8.0,
                      left: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //   Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Bagikan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(flex: 1, child: Container()),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var a = await findPath(widget.image);
                          //  var b = await findPath(widget.image2);

                          setState(() {
                            settheImage = a
                                .toString()
                                .replaceAll("'", "")
                                .replaceAll("LocalFile: ", "");
                            // setImage2 = b
                            //     .toString()
                            //     .replaceAll("'", "")
                            //     .replaceAll("LocalFile: ", "");

                            //      setImage = true;
                          });

                          // File(settheImage).readAsBytes().then((value) {
                          //   setState(() {
                          //     asd = value.toString();
                          //   });
                          //   return null;
                          // });

                          // File(setImage2).readAsBytes().then((value) {

                          //   // setState(() {
                          //   //   asd = value.toString();
                          //   // });
                          //   return null;
                          // });
                          var link = "https://webino.id/event/${widget.link}";

                          SocialShare.shareInstagramStory(
                            settheImage,
                            attributionURL: link,
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  //   color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/Ipng/Instaram Stories.png"),
                                  ),
                                ),
                                // child: Icon(
                                //   shareList[index].icon,
                                //   size: 30,
                                //   // color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Text("IG Stories"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      // setImage
                      //     ? Container(
                      //         //width: ,
                      //         child: Image.file(File(settheImage)),
                      //       )
                      //     : Container(),
                      GestureDetector(
                        onTap: () async {
                          var link = "https://webino.id/event/${widget.link}";

                          SocialShare.shareWhatsapp(
                            link,
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  //   color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/Ipng/Whatsapp.png"),
                                  ),
                                ),
                                // child: Icon(
                                //   shareList[index].icon,
                                //   size: 30,
                                //   // color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Text("WhatsApp"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var link = "https://webino.id/event/${widget.link}";

                          SocialShare.shareTelegram(link);
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  //   color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/Ipng/Telegram.png"),
                                  ),
                                ),
                                // child: Icon(
                                //   shareList[index].icon,
                                //   size: 30,
                                //   // color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Text("Telegram"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 10,
                      // ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     var link = "https://webino.id/event/${widget.link}";

                      //     //      SocialShare.shareInstagramStory( file.path,);

                      //   },
                      //   child: Container(
                      //     color: Colors.white,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: [
                      //         Container(
                      //           height: 50,
                      //           width: 50,
                      //           decoration: BoxDecoration(
                      //             //   color: Colors.grey,
                      //             shape: BoxShape.circle,
                      //             image: DecorationImage(
                      //               fit: BoxFit.cover,
                      //               image: AssetImage("assets/Ipng/Telegram.png"),
                      //             ),
                      //           ),
                      //           // child: Icon(
                      //           //   shareList[index].icon,
                      //           //   size: 30,
                      //           //   // color: Colors.red,
                      //           // ),
                      //         ),
                      //         Container(
                      //           child: Text("Telegram"),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var link = "https://webino.id/event/${widget.link}";
                          copied();
                          SocialShare.copyToClipboard(link);
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  //   color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/Ipng/Copy Link.png"),
                                  ),
                                ),
                                // child: Icon(
                                //   shareList[index].icon,
                                //   size: 30,
                                //   // color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Text("Copy Link"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 55,
                //   //child: ListView(children: [Text(asd)]),
                // )
              ],
            ),
            // Expanded(
            //   child: Container(
            //     child: GridView.count(
            //       padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            //       //childAspectRatio: 1 / 1,
            //       // shrinkWrap: true,
            //       // primary: false,
            //       //   physics: const NeverScrollableScrollPhysics(),
            //       crossAxisCount: 5,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       children: List.generate(
            //         shareList.length,
            //         (index) {
            //           return GestureDetector(
            //             onTap: () async {

            //               var link =
            //                   "https://webino.id/event/${widget.link}";

            //               shareList[index].title.contains('WhatsApp')
            //                   ? SocialShare.shareWhatsapp(link)
            //                   : shareList[index].title.contains("Copy")
            //                       ?
            //                       //SocialShare.shareOptions(contentText);
            //                       SocialShare.copyToClipboard(link)
            //                       : shareList[index].title.contains("Telegram")
            //                           ? SocialShare.shareTelegram(link)
            //                           : print("");

            //             child: Container(
            //               color: Colors.white,
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 mainAxisSize: MainAxisSize.max,
            //                 children: [
            //                   Container(
            //                     height: 35,
            //                     width: 35,
            //                     decoration: BoxDecoration(
            //                       //   color: Colors.grey,
            //                       shape: BoxShape.circle,
            //                       image: DecorationImage(
            //                         fit: BoxFit.cover,
            //                         image: AssetImage(shareList[index].image),
            //                       ),
            //                     ),
            //                     // child: Icon(
            //                     //   shareList[index].icon,
            //                     //   size: 30,
            //                     //   // color: Colors.red,
            //                     // ),
            //                   ),
            //                   Container(
            //                     child: Text(shareList[index].title),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void copied() => Fluttertoast.showToast(
        msg: "Copied To Clipboard",
      );
}
