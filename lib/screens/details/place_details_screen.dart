import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';


class PlaceDetails extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String description;
  final String rate;

  const PlaceDetails({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.rate,
  });

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  final List<Facilities> _facilities = [];
  late Future<bool> _isFavourite;

  @override
  void initState() {
    super.initState();
    fillFacilities();
    _isFavourite = Shared.getPrefBool(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:const EdgeInsets.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: SizerExt(70).w,
                    height: SizerExt(33).h,
                  ),
                  Image.asset(
                    widget.image,
                    width: SizerExt(100).w,
                    height: SizerExt(40).h,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 25,
                    left: 15,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 5)),
                        ],
                      ),
                      //like button
                      child: FutureBuilder<bool>(
                        future: _isFavourite,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            bool _isLiked = snapshot.data ?? false;
                            return LikeButton(
                              isLiked: _isLiked,
                              onTap: (isLiked) {
                                setState(() {
                                  _isLiked = !isLiked;
                                  Shared.savePrefBool(widget.id, _isLiked);
                                });
                                return Future.value(!isLiked);
                              },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color: isLiked ? Colors.red : Colors.grey,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Show map",
                        style: TextStyle(fontSize: 14, color: Color(0xff176ef2)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 14),
                  Text(
                    "${widget.rate} (355 Reviews)",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.description,
                style:const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Container(
                margin:const EdgeInsets.fromLTRB(0, 15, 233, 0),
                width: double.infinity,
                child:const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Read more',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff176ef2),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        color: Color(0xff176ef2), size: 14),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:const EdgeInsets.fromLTRB(0, 25, 290, 10),
                    width: double.infinity,
                    child:const Text(
                      'Facilities',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics:const BouncingScrollPhysics(),
                      itemCount: _facilities.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        final facilities = _facilities[index];
                        return Container(
                          height: 70,
                          width: 85,
                          margin:const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient:const LinearGradient(
                              colors: <Color>[
                                Color(0xffe4e4ee),
                                Color(0xffe4e4ee)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                facilities.image,
                                color: Colors.grey,

                                width: 30,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                facilities.label,
                                style:const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:const EdgeInsets.fromLTRB(20, 2, 56, 30),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:const EdgeInsets.only(bottom: 5),
                      child:const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const Text(
                      '\$199',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff02be5c),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:const EdgeInsets.fromLTRB(0, 2, 0, 30),
                height: 56,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xff176ef2), Color(0xff186eee)],
                    stops: <double>[0, 1],
                  ),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.indigo,
                      offset: Offset(0, 6),
                      blurRadius: 9.5,
                    ),
                  ],
                ),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Book now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fillFacilities() {
    _facilities.addAll([
      Facilities(image: "assets/1heater.png", label: "1 Heater"),
      Facilities(image: "assets/dinner.png", label: "Dinner"),
      Facilities(image: "assets/1tub.png", label: "1 Tub"),
      Facilities(image: "assets/pool.png", label: "Pool"),
    ]);
  }
}

class Facilities {
  final String image;
  final String label;

  Facilities({
    required this.image,
    required this.label,
  });
}

class Shared {
  static Future<bool> getPrefBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> savePrefBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}