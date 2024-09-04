import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/home_screen_details.dart';
import 'package:movie_app/image_decoration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: ApiManager.getPopSource(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                var popSource = snapshot.data?.results;
                return CarouselSlider.builder(
                  itemCount: popSource?.length ?? 0,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, HomeScreenDetails.routeName,
                            arguments: popSource?[index].id);
                      },
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                "https://image.tmdb.org/t/p/w500${popSource?[index].backdropPath ?? ''}",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      popSource?[index].title ?? "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      popSource?[index].releaseDate ?? "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Color(0xffB5B4B4),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110, left: 20),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${popSource?[index].backdropPath ?? ''}",
                              height: 220,
                              width: 129,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Stack(
                            children: [
                              Positioned(
                                top: 105,
                                left: 11,
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      size: 35,
                                      color: Color(0xff514F4F),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 5,
                                      child: Icon(Icons.add,
                                          size: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    height: 340,
                    //autoPlay: true,
                    enableInfiniteScroll: true,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Container(
              color: Color(0xff282A28),
              height: 199,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Releases ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    FutureBuilder(
                        future: ApiManager.getUpcomingSource(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          var upcomingResponse = snapshot.data?.results;
                          return Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 18,
                                );
                              },
                              itemCount: upcomingResponse?.length ?? 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${upcomingResponse?[index].backdropPath ?? ""}",
                                        width: 100,
                                        height: 250,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                      right: 74,
                                      bottom: 119,
                                      child: Stack(
                                        children: [
                                          Icon(
                                            Icons.bookmark,
                                            size: 35,
                                            color: Color(0xff514F4F),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 4,
                                            child: Icon(Icons.add,
                                                size: 15, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Color(0xff282A28),
              height: 270,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Recomended ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    FutureBuilder(
                        future: ApiManager.getTopRatedSource(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          var topRatedResponse = snapshot.data?.results;
                          return Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 18,
                                );
                              },
                              itemCount: topRatedResponse?.length ?? 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: ImageDecoration(
                                        image: topRatedResponse?[index]
                                                .backdropPath ??
                                            "",
                                        title: topRatedResponse?[index].title ??
                                            "",
                                        date: topRatedResponse?[index]
                                                .releaseDate ??
                                            ""),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
