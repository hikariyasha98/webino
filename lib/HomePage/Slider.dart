import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:webino/HomePage/Detail.dart';

class Sliderver2 extends StatefulWidget {
  const Sliderver2({
    Key? key,
    @required this.jumlahkotak,
    required this.sliderapiList,
    @required this.sliderLoading,
    required this.sliderData,
    @required this.newData,
  }) : super(key: key);
  final jumlahkotak;
  final sliderLoading;
  final List<String> sliderapiList;
  final List sliderData;
  final newData;
  @override
  _Sliderver2State createState() => _Sliderver2State();
}

class _Sliderver2State extends State<Sliderver2> {
//  bool loading = true;

  int current = 0;

  // @override
  // void initState() {
  //   super.initState();
  // //  this.fetchSlider();
  // }

  // final List<String> imgList = [
  //   'assets/images/slider 1.jpg',
  //   'assets/images/banner 2.jpg',
  // ];
  // List<String> apiList = [];
  // List<dynamic> apiresult = [];

  // List<T> map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Builder(
        builder: (context) {
          //  final double width = MediaQuery.of(context).size.width;
          if (widget.sliderLoading == true) {
            return Container(
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 4,
                    bottom: 10,
                    left: 8,
                    right: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Shimmer.fromColors(
                      baseColor: Color.fromRGBO(156, 223, 255, 1),
                      highlightColor: Colors.white,
                      child: Container(
                        // height: 100,
                        // width: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //  color: Colors.red,
                ),
              ),
            );
          }
          return Container(
            child: AspectRatio(
              aspectRatio: 16 / 8,
              child: sliderComponent(),
            ),
          );
        },
      ),
    );
  }

  CarouselController buttonCarouselController = CarouselController();
  Widget sliderComponent() {
    return Column(
      children: [
        Stack(
          //center
          children: <Widget>[
            // Container(),
            Center(
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  autoPlay: widget.newData ? false : true,
                  //  autoPlayInterval: Duration(seconds: 10),
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 16 / 8,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        current = index;
                      },
                    );
                  },
                ),
                items: widget.sliderapiList
                    .map(
                      (item) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailFeed(
                                  from: false,
                                  date: "",
                                  slug: widget.sliderData[current]['slug']),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 8, right: 8, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image:
                                  //  item.contains('http') == true
                                  //     ?
                                  DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                  item,
                                ), // : AssetImage(item),
                              ),
                              // : DecorationImage(
                              //     fit: BoxFit.fill,
                              //     image: AssetImage(item),
                              //   ),
                              // boxShadow: [
                              //   BoxShadow(: AssetImage(item)
                              //     color: Colors.grey.withOpacity(1.0),
                              //     spreadRadius: 1,
                              //     blurRadius: 5,
                              //     offset: Offset(0, 0),
                              //   ),
                              // ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
