import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:webino/API/SetApi.dart';
import 'package:webino/HomePage/Detail.dart';

import '../my_flutter_app_icons.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List traget = [];
  bool _isSearching = true, _loading = false, load = true, searced = false;
  List searchresult = [];
  String _searchText = "";
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    this.loadData();
    this._searchListExampleState();
  }

  _searchListExampleState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = searchController.text;
        });
      }
    });
  }

  loadData() async {
    var resp = await feedprodukPlus(1);

    if (resp['code'] == 200) {
      traget.addAll(resp['data']);
      int pageLength = resp['meta']['total_pages'];
      var bol4 = List.generate(pageLength - 1, (i) => i + 2);
      var bol5 = List.generate(pageLength - 1, (i) => false);
      if (bol4.length > 0) {
        bol4.forEach((element) async {
          var getdata = await feedprodukPlus(element);
          if (getdata['code'] == 200) {
            traget.addAll(getdata['data']);
            bol5[element - 2] = true;
            bol5[element - 2] = bol5[element - 2];
          }

          if (!bol5.contains(false)) {
            setState(() {
              load = false;
            });
          }
        });
      }
    }
  }

  void searchOperation(String searchText) async {
    searchresult.clear();

    setState(() {
      _loading = true;
    });
    if (_isSearching == true) {
      // var asd = await searchProduk(_searchText.toLowerCase());
      //print(asd);
      traget.forEach((element) {
        String name = element['name'];
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          searchresult.add(element);
        }
      });
      setState(() {
        searced = true;
        _loading = false;
      });
    }
  }

  // void _handleSearchStart() {
  //   print("start");
  //   setState(() {
  //     _isSearching = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return load
        ? Container(
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
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(156, 223, 255, 1),

              //actions: [],
              leading: GestureDetector(
                child: Icon(
                  MyFlutterApp.back,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // close(context, 'null');
                },
              ),
              // centerTitle: true,
              titleSpacing: 20,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                    Expanded(
                      child: Container(
                        //    width: MediaQuery.of(context).size.width / 1.9,
                        child: TextField(
                          autofocus: true,
                          onSubmitted: searchOperation,
                          cursorColor: Colors.black,
                          // onTap: _handleSearchStart,
                          controller: searchController,
                          //onChanged: searchOperation,
                          decoration: InputDecoration.collapsed(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontSize: 15,

                                // height: 0.5,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (searced && searchresult.length == 0)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 47.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/ilustrasi.png",
                                width:
                                    MediaQuery.of(context).size.width * 0.382,
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
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 20, left: 16, right: 10),
                        itemCount: searchresult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return reminderCard(
                            searchresult[index],
                            //  index,
                            // true,
                          );
                        }),
          );
  }

  Widget reminderCard(index) {
    // int id = index['id'];
    String name = index['name'];
    String image = index['featured_image'].toString();
    String tgl = index['tanggal_acara'].toString().split('_')[0];
    String tglSet = index['tgl'].toString();
    String status = index['status'];
    String slug = index['slug'].toString();

    // var date = DateTime.tryParse(tglSet);

    //var dueDate = DateTime.tryParse(tglSet.toString().split("T")[0]);
    // DateTime now = new DateTime.now();
    // var nowDate = DateTime.tryParse(now.toString().split(" ")[0]);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFeed(
              from: false,
              date: tglSet,
              slug: slug,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: EdgeInsets.all(5),
                  //   width: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: image != ""
                          ? FadeInImage(
                              image: NetworkImage(image),
                              placeholder: AssetImage(
                                "assets/images/load.jpg",
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    'assets/images/Picture not found.jpg',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.fill,
                              fadeInDuration: const Duration(milliseconds: 300),
                            )
                          : Image.asset(
                              "assets/images/Picture not found.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        //    width: MediaQuery.of(context).size.width * 0.6,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.36,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        MyFlutterApp.calendar,
                                        color: Colors.grey,
                                        size: 12,
                                      ),
                                      Container(
                                        width: 9.5,
                                      ),
                                      Text(
                                        tgl.isNotEmpty
                                            ? tgl
                                            : "10 November 2025",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          //        fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        MyFlutterApp.location,
                                        color: Colors.grey,
                                        size: 12,
                                      ),
                                      Container(
                                        width: 9.5,
                                      ),
                                      Text(
                                        status.isNotEmpty
                                            ? (status == "Both"
                                                ? "Online & Offline"
                                                : status)
                                            : "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          //   fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              //   color: Colors.red,
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // GestureDetector(
                                  //   behavior: HitTestBehavior.translucent,
                                  //   onTap: (dueDate == nowDate)
                                  //       ? () {
                                  //           String message =
                                  //               "Tidak Bisa Reminder Ketika Hari H";
                                  //       //    reminderSuccess(message);
                                  //         }
                                  //       : () async {
                                  //           bool a =
                                  //               index['notification_1'] != null
                                  //                   ? true
                                  //                   : false;
                                  //           bool b =
                                  //               index['notification_2'] != null
                                  //                   ? true
                                  //                   : false;
                                  //           bool c =
                                  //               index['notification_3'] != null
                                  //                   ? true
                                  //                   : false;
                                  //           List<bool> dataNotif = [c, b, a];

                                  //           var asd = await showDialog(
                                  //             context: context,
                                  //             builder: (context) {
                                  //               return ReminderDialog(
                                  //                 //   refresh: fetchreminder(true),
                                  //                 dataAll: index,
                                  //                 update: "update",
                                  //                 dueDate: date,
                                  //                 id: id,
                                  //                 data: dataNotif,
                                  //               );
                                  //             },
                                  //           );
                                  //           if (asd != null) {
                                  //             if (asd) {
                                  //           //    reload();
                                  //             }
                                  //           }
                                  //         },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 16.0, left: 8, right: 8),
                                  //     child: Container(
                                  //       color: Colors.transparent,
                                  //       child: Icon(
                                  //         MyFlutterApp.timer,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   behavior: HitTestBehavior.translucent,
                                  //   onTap: () async {
                                  //     var delRSP = await deleteReminder(id);
                                  //     if (delRSP['code'] == 200) {
                                  // //      reload();
                                  //     }
                                  //   },
                                  //   child: Container(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(
                                  //         top: 16,
                                  //       ),
                                  //       child: Container(
                                  //         color: Colors.transparent,
                                  //         child: Icon(
                                  //           MyFlutterApp.trash,
                                  //           color: Colors.grey,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class SearchProduk extends SearchDelegate<String> {
//   SearchProduk({
//     String? hintText,
//   }) : super(
//           searchFieldLabel: hintText = "Search",
//           keyboardType: TextInputType.text,
//           searchFieldDecorationTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: Colors.white,
//             border: InputBorder.none,
//           ),
//           textInputAction: TextInputAction.search,
//         );

//   List produk = [];
//   bool? isLoading;

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     assert(context != null);
//     final ThemeData theme = Theme.of(context);
//     assert(theme != null);
//     return theme.copyWith(
//       appBarTheme: AppBarTheme(
//         backgroundColor: Color.fromRGBO(156, 223, 255, 1),
//         // brightness: colorScheme.brightness,
//         // backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
//         iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
//         textTheme: theme.textTheme,
//       ),
//       inputDecorationTheme: searchFieldDecorationTheme ??
//           InputDecorationTheme(
//             hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
//             border: InputBorder.none,
//           ),
//     );
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = '';
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return GestureDetector(
//       child: Icon(
//         MyFlutterApp.back,
//       ),
//       onTap: () {
//         close(context, 'null');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     var length = produk.length > 0 ? produk.length : 0;

//     return FutureBuilder(
//       future: _produkData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return resultContent(snapshot.data);
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   ScrollController scrollController = new ScrollController();
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ListView.builder(
//       controller: scrollController,
//       itemBuilder: (context, index) {
//         return listTile(produk[index], query, context);
//       },
//       itemCount: produk.length,
//     );
//   }

//   Widget resultContent(data) {
//     var redata = data['data'];
//     var length = query.length > 0 ? redata.length : 0;

//     return ListView.builder(
//       itemBuilder: (context, index) {
//         return reminderCard(context, redata[index], query);
//       },
//       itemCount: length,
//     );
//   }

//   Widget listTile(index, query, context) {
//     print(index);
//     var image = index['featured_image'];
//     var title = index['name'];
//     var sku = index['sku'];
//     // var url = "https://sokormuni.id/api/products/" + "$sku";

//     var wasd = title.toString().contains(query);
//     // var asd = title.toString().contains(query.toString().toLowerCase());
//     var gg = title.toString().toLowerCase().contains(query.toString());
//     return wasd || gg
//         ? Container(
//             width: MediaQuery.of(context).size.width,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           DetailFeed(slug: "slug", date: "date")),
//                 );
//               },
//               child: Card(
//                 child: IntrinsicHeight(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 8.0),
//                             child: SizedBox(
//                               height: 120,
//                               width: 100,
//                               child: Image.network(
//                                 image,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                         child: VerticalDivider(
//                           color: Colors.grey.withOpacity(0.5),
//                           thickness: 1,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 20.0, top: 25, right: 20, bottom: 25),
//                         child: Text(
//                           "$title",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         : Container();
//   }

//   Widget reminderCard(context, index, query) {
//     print(index);
//     // int id = index['id'];
//     String name = index['name'];

//     String image = index['featured_image'].toString();
//     String tgl = index['tanggal_acara'].toString().split('_')[0];
//     String tglSet = index['tgl'].toString();
//     String status = index['status'];
//     String slug = index['slug'].toString();

//     var date = DateTime.tryParse(tglSet);

//     var dueDate = DateTime.tryParse(tglSet.toString().split("T")[0]);
//     DateTime now = new DateTime.now();
//     var nowDate = DateTime.tryParse(now.toString().split(" ")[0]);

//     return name.toString().contains(query)
//         ? GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailFeed(
//                     date: tglSet,
//                     slug: slug,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               color: Colors.transparent,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.08,
//                         padding: EdgeInsets.all(5),
//                         //   width: MediaQuery.of(context).size.width * 0.25,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: AspectRatio(
//                             aspectRatio: 1 / 1,
//                             child: image != ""
//                                 ? FadeInImage(
//                                     image: NetworkImage(image),
//                                     placeholder: AssetImage(
//                                       "assets/images/load.jpg",
//                                     ),
//                                     imageErrorBuilder:
//                                         (context, error, stackTrace) {
//                                       return Image.asset(
//                                           'assets/images/Picture not found.jpg',
//                                           fit: BoxFit.cover);
//                                     },
//                                     fit: BoxFit.fill,
//                                     fadeInDuration:
//                                         const Duration(milliseconds: 300),
//                                   )
//                                 : Image.asset(
//                                     "assets/images/Picture not found.jpg",
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 20,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.66,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               name,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               softWrap: false,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Container(
//                               height: 10,
//                             ),
//                             Container(
//                               //    width: MediaQuery.of(context).size.width * 0.6,

//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width *
//                                         0.36,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               MyFlutterApp.calender,
//                                               color: Colors.grey,
//                                               size: 12,
//                                             ),
//                                             Container(
//                                               width: 9.5,
//                                             ),
//                                             Text(
//                                               tgl.isNotEmpty
//                                                   ? tgl
//                                                   : "10 November 2025",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w400,
//                                                 //        fontSize: 10,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Container(
//                                           height: 4,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               MyFlutterApp.location,
//                                               color: Colors.grey,
//                                               size: 12,
//                                             ),
//                                             Container(
//                                               width: 9.5,
//                                             ),
//                                             Text(
//                                               status.isNotEmpty
//                                                   ? (status == "Both"
//                                                       ? "Online & Offline"
//                                                       : status)
//                                                   : "",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w400,
//                                                 //   fontSize: 10,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.2,
//                                     //   color: Colors.red,
//                                     alignment: Alignment.bottomCenter,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         // GestureDetector(
//                                         //   behavior: HitTestBehavior.translucent,
//                                         //   onTap: (dueDate == nowDate)
//                                         //       ? () {
//                                         //           String message =
//                                         //               "Tidak Bisa Reminder Ketika Hari H";
//                                         //           reminderSuccess(message);
//                                         //         }
//                                         //       : () async {
//                                         //           bool a =
//                                         //               index['notification_1'] != null
//                                         //                   ? true
//                                         //                   : false;
//                                         //           bool b =
//                                         //               index['notification_2'] != null
//                                         //                   ? true
//                                         //                   : false;
//                                         //           bool c =
//                                         //               index['notification_3'] != null
//                                         //                   ? true
//                                         //                   : false;
//                                         //           List<bool> dataNotif = [c, b, a];

//                                         //           var asd = await showDialog(
//                                         //             context: context,
//                                         //             builder: (context) {
//                                         //               return ReminderDialog(
//                                         //                 //   refresh: fetchreminder(true),
//                                         //                 dataAll: index,
//                                         //                 update: "update",
//                                         //                 dueDate: date,
//                                         //                 id: id,
//                                         //                 data: dataNotif,
//                                         //               );
//                                         //             },
//                                         //           );
//                                         //           if (asd != null) {
//                                         //             if (asd) {
//                                         //               reload();
//                                         //             }
//                                         //           }
//                                         //         },
//                                         //   child: Padding(
//                                         //     padding: const EdgeInsets.only(
//                                         //         top: 16.0, left: 8, right: 8),
//                                         //     child: Container(
//                                         //       color: Colors.transparent,
//                                         //       child: Icon(
//                                         //         MyFlutterApp.timer,
//                                         //         color: Colors.grey,
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                         // GestureDetector(
//                                         //   behavior: HitTestBehavior.translucent,
//                                         //   onTap: () async {
//                                         //     var delRSP = await deleteReminder(id);
//                                         //     if (delRSP['code'] == 200) {
//                                         //       reload();
//                                         //     }
//                                         //   },
//                                         //   child: Container(
//                                         //     child: Padding(
//                                         //       padding: const EdgeInsets.only(
//                                         //         top: 16,
//                                         //       ),
//                                         //       child: Container(
//                                         //         color: Colors.transparent,
//                                         //         child: Icon(
//                                         //           MyFlutterApp.trash,
//                                         //           color: Colors.grey,
//                                         //         ),
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 10,
//                   ),
//                   Divider(
//                     height: 1,
//                     thickness: 1,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       bottom: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Container();
//   }

//   Future _produkData() async {
//     var a = feedprodukV2;
//     print(a);

//     var url = Uri.parse("https://webino.id/api/products");

//     var response = await http.get(
//       url,
//       headers: {
//         "Accept": "Application/json",
//         HttpHeaders.authorizationHeader:
//             "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
//       },
//     );
//     var gg = jsonDecode(response.body);

//     return gg;
//   }
// }
