import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../API_MANAGER.dart';
import '../firebase/firebase_functions.dart';
import 'home_screen_details.dart';
import '../watchlist/watch_list_model.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({super.key});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  Set<String> markedMovies = {};
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            final movie = popSource?[index];
            final isMarked = markedMovies.contains(movie?.id.toString());
            final imageUrl =
                "https://image.tmdb.org/t/p/w500${movie?.backdropPath ?? ''}";
            return InkWell(
              onTap: () {
                setState(() {});
                Navigator.pushNamed(
                  context,
                  HomeScreenDetails.routeName,
                  arguments: movie?.id,
                );
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(imageUrl),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                            Text(popSource?[index].releaseDate ?? "",
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110, left: 20),
                    child: Image.network(
                      imageUrl,
                      height: 220,
                      width: 129,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 105,
                    child: GestureDetector(
                      onTap: () {
                        final movieId = movie?.id.toString();
                        if (movieId != null) {
                          if (markedMovies.contains(movieId)) {
                            markedMovies.remove(movieId);
                          } else {
                            markedMovies.add(movieId);
                            WatchListModel model = WatchListModel(
                              image: imageUrl,
                              releaseDate: movie?.releaseDate ?? "",
                              title: movie?.title ?? "",
                              id: movieId,
                            );
                            FirebaseFunctions.addToWatch(model);
                            model.isMarked=true;
                            FirebaseFunctions.update(model);
                          }
                        }
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Icon(
                           Icons.bookmark,
                            size: 35,
                            color:  isMarked?Colors.amber:Color(0xff514F4F),
                          ),
                          Positioned(
                            left: 10,
                            top: 5,
                            child: Icon(
                              isMarked?Icons.done:Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            height: 340,
            // autoPlay: true,
            enableInfiniteScroll: true,
          ),
        );
      },
    );
  }
}
