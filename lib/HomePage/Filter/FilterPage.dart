import 'package:flutter/material.dart';
//import 'package:webino/API/SetApi.dart';
import 'package:webino/HomePage/Detail.dart';

import 'package:webino/HomePage/Filter.dart';
//import 'package:webino/HomePage/Search.dart';
import 'package:webino/ReminderPage/Reminder.dart';

import '../../my_flutter_app_icons.dart';
import '../Feed.dart';
import '../ReminderButton.dart';
import '../Search.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    Key? key,
    @required this.status,
    @required this.lokasi,
    @required this.kategori,
    @required this.month,
    @required this.year,
    @required this.biaya,
    @required this.datab,
    @required this.ctg,
    @required this.pvs,
    required this.totalPage,
  }) : super(key: key);
  final status;
  final lokasi;
  final kategori;
  final month;
  final year;
  final biaya;
  final datab;
  final ctg;
  final pvs;
  final int totalPage;
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
    this.setList();
    this.fetchToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List filteredData = [];
  List listFilter = [];
  List defaultfilter = [];
  bool sort = false;
  String token = "";
  int totalPageC = 0;
  String sortString = 'Default';
  static const items = <String>[
    'Closest Date',
    'Furthest Date',
  ];
  final List<PopupMenuItem<String>> _sortBy = items
      .map(
        (String value) => PopupMenuItem(
          child: Text(value),
          value: value,
        ),
      )
      .toList();

  setList() {
    if (widget.datab.length > 0) {
      List asd = [
        {
          'name': 'status',
          'length': widget.status.length,
          'called': '${widget.status}'
        },
        {'name': 'Lokasi', 'length': widget.lokasi.length, 'called': ''},
        {'name': 'Kategori', 'length': widget.kategori.length, 'called': ''},
        {'name': 'Tahun', 'length': widget.year.length, 'called': ''},
        {'name': 'Bulan', 'length': widget.month.length, 'called': ''},
        {
          'name': 'biaya',
          'length': widget.biaya.length,
          'called': '${widget.biaya}'
        },
      ];
      setState(() {
        totalPageC = widget.totalPage;
        defaultfilter = widget.datab;
        filteredData = widget.datab;
        listFilter = asd;
      });
    }

    //status
  }

  fetchToken() async {
    var tokenA = await storage.read(key: 'token');
    setState(() {
      token = tokenA.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).padding.top);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedPage(
              fromPage: "Filter",
            ),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            image: AssetImage("assets/images/navbar.jpg"),
            fit: BoxFit.fill,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedPage(
                    fromPage: "Filter",
                  ),
                ),
              );
            },
            child: Icon(
              MyFlutterApp.back,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(156, 223, 255, 1),
          titleSpacing: 0.0,
          title: GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                //   top: 10,
                left: 16.0,
              ),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              //  color: Colors.white,
              //     width: MediaQuery.of(context).size.width / 1.9,
              child: Row(
                children: [
                  Icon(
                    MyFlutterApp.search,
                    // size: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
                icon: Icon(
                  Icons.sort_rounded,
                  color: Colors.white,
                ),
                color: Colors.white,
                elevation: 20,
                enabled: true,
                onSelected: (String? value) {
                  value == 'Closest Date'
                      ? setState(() {
                          filteredData.sort((a, b) {
                            var adate = a['tgl'];
                            var bdate = b['tgl'];
                            return adate.compareTo(bdate);
                          });
                          //   print(filteredData);
                          sort = false;
                        })
                      : value == 'Furthest Date'
                          ? setState(() {
                              filteredData.sort((b, a) {
                                var adate = a['tgl'];
                                var bdate = b['tgl'];
                                return adate.compareTo(bdate);
                              });
                              //   print(filteredData);
                              sort = false;
                            })
                          : print('chuaakss');
                },
                itemBuilder: (context) => _sortBy),
            Reminderbutton(
              token: token,
              pB: 18,
              pL: 18,
              pR: 8,
              pT: 12,
              size: 32,
            ),
          ],
        ),
        body: widget.datab.length != 0
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // physics: const NeverScrollableScrollPhysics(),
                  // primary: false,
                  // shrinkWrap: false,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 8, bottom: 8, right: 10),
                            height: MediaQuery.of(context).size.height / 20,
                            child: MaterialButton(
                              color: Color.fromRGBO(
                                156,
                                223,
                                255,
                                1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Color.fromRGBO(156, 223, 255, 1),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    // double popUpPadding =
                                    //     MediaQuery.of(context).size.width *
                                    //         0.0338;
                                    return Filter(
                                      biaya: widget.biaya,
                                      kategori: widget.kategori,
                                      lokasi: widget.lokasi,
                                      month: widget.month,
                                      year: widget.year,
                                      status: widget.status,
                                      totalPage: totalPageC,
                                      pData: [],
                                      page: totalPageC,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: (MediaQuery.of(context).size.height *
                                    0.022),
                                width: MediaQuery.of(context).size.width / 4.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.toc,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Container(width: 2),
                                    Text(
                                      "Filter",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.height / 20,
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                itemCount: listFilter.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return listFilter[index]['length'] > 0
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                //   top: 7,
                                                //   bottom: 6,
                                                left: 22,
                                                right: 22,
                                              ),
                                              child: listFilter[index]
                                                              ['name'] ==
                                                          ('status') ||
                                                      listFilter[index]
                                                              ['name'] ==
                                                          ('biaya')
                                                  ? Text(
                                                      listFilter[index]
                                                                  ['called'] ==
                                                              'Both'
                                                          ? "Online & Offline"
                                                          : "${listFilter[index]['called']}",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                          156,
                                                          223,
                                                          255,
                                                          1,
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${listFilter[index]['name']}",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                              156,
                                                              223,
                                                              255,
                                                              1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height:
                        //     MediaQuery.of(context).size.height, // - 300,
                        color: Colors.white,
                        child: ListView(
                          children: [
                            Container(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  var jumlahkotak =
                                      (MediaQuery.of(context).size.width > 1200)
                                          ? 2
                                          : (MediaQuery.of(context).size.width >
                                                  600)
                                              ? 4
                                              : 2;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 14),
                                    child: GridView.count(
                                      //    padding: EdgeInsets.zero,
                                      childAspectRatio:
                                          ((MediaQuery.of(context).size.width /
                                                      jumlahkotak) -
                                                  26) /
                                              248,
                                      shrinkWrap: true,
                                      primary: false,
                                      crossAxisCount: jumlahkotak,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: List.generate(
                                        filteredData.length,
                                        (index) {
                                          return card2(filteredData[index]);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
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
                          "Data tidak ditemukan",
                          style: TextStyle(
                            color: Color.fromRGBO(85, 85, 91, 1),
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget card2(index) {
    String name = index['name'].toString();
    String image = index['featured_image'].toString();
    String tanggal = index['tanggal_acara'].split('_')[0].toString();
    String status = index['status'].toString();
    String waktu = index['waktu'].toString();
    String jenispembayaran = index['jenis_pembayaran'].toString();
    String slug = index['slug'].toString();
    return Padding(
      padding: EdgeInsets.only(
        top: 2,
        bottom: 5,
        // left: 14,
        // right: 14,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailFeed(
                from: false,
                date: index['tgl'],
                slug: slug,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            // borderRadius:
            //     BorderRadius.circular(
            //         20),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color.fromRGBO(156, 223, 255, 0.5),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: Offset(0, 0),
            //   ),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: 2, right: 4.0),
                //   child: Container(
                //     height: 40,
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: image != ""
                        ? FadeInImage(
                            image: NetworkImage(image),
                            placeholder: AssetImage(
                              "assets/images/load.jpg",
                              // fit: BoxFit.cover,
                            ),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/images/Picture not found.jpg',
                                  fit: BoxFit.cover);
                            },
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/Picture not found.jpg',
                            fit: BoxFit.cover,
                          ),
                    // child: CachedNetworkImage(
                    //   imageUrl: image,
                    //   fit: BoxFit.fill,
                    // ),
                    //child: imageMethod(image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty ? name : "Coming Soon",
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          tanggal.isNotEmpty ? tanggal : "Coming Soon",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        waktu.isNotEmpty ? waktu : "Coming Soon",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        status.isNotEmpty
                            ? ((status == "Both") ? "Online & Offline" : status)
                            : "Coming Soon",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 10.0, bottom: 5),
                        child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                              jenispembayaran.isNotEmpty
                                  ? (jenispembayaran == "Both"
                                      ? "Gratis & Berbayar"
                                      : jenispembayaran)
                                  : "Coming Soon",
                              style: TextStyle(
                                color: Color.fromRGBO(
                                  162,
                                  199,
                                  60,
                                  1,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
