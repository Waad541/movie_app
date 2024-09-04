import 'package:flutter/material.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/image_decoration.dart';
import 'package:movie_app/models/home_screen_details_response.dart';
import 'package:movie_app/small_container.dart';

class HomeScreenDetails extends StatefulWidget {
  static const String routeName = 'details';
  const HomeScreenDetails({super.key});

  @override
  State<HomeScreenDetails> createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  @override
  Widget build(BuildContext context) {
    var movie = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: Column(
        children: [
          Container(
            height: 599,
            width: 420,
            child: FutureBuilder(
              future: ApiManager.getHomeDetailsSource(movie),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }

                var movieDetails = snapshot.data!;
                return Scaffold(
                  backgroundColor: Color(0xff1A1A1A),
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(
                      color: Colors.white
                    ),
                    title: Text(
                      movieDetails.title ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${movieDetails.posterPath ?? ''}",
                        width: 410,
                        height: 210,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieDetails.title ?? "",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              movieDetails.releaseDate ?? "",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffB5B4B4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(children: [
                                    Image.network(
                                      "https://image.tmdb.org/t/p/w500${movieDetails.posterPath ?? ''}",
                                      width: 120,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      right: 96,
                                      top: -5,
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
                                  ]),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: SmallContainer()),
                                            SizedBox(width: 10),
                                            Expanded(child: SmallContainer()),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(child: SmallContainer()),
                                            SizedBox(width: 10),
                                            Expanded(child: SmallContainer()),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          movieDetails.overview ?? "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xffCBCBCB),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 17,
                                            ),
                                            Text(
                                              '7.7',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
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
                );
              },
            ),
          ),
          Container(
            height: 250,
            child: FutureBuilder(
              future: ApiManager.getMoreLikeSource(movie),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }
                var model = snapshot.data?.results;
                return Container(
                  color: Color(0xff282A28),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'More Like This',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 18,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff343534),
                                ),
                                child: Stack(children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://image.tmdb.org/t/p/w500${model?[index].posterPath ?? ""}",
                                            width: 105,
                                            height: 93,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '7.7',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          model?[index].title ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          model?[index].releaseDate ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ]),
                                  Positioned(
                                    right: 72,
                                    top: -4,
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
                                  //
                                ]),
                              );
                            },
                            itemCount: model?.length ?? 0,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
