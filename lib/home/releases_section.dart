import 'package:flutter/material.dart';

import '../API_MANAGER.dart';
import '../firebase/firebase_functions.dart';
import 'home_screen_details.dart';
import '../watchlist/watch_list_model.dart';

class ReleasesSection extends StatefulWidget {
  const ReleasesSection({super.key});

  @override
  State<ReleasesSection> createState() => _ReleasesSectionState();
}

class _ReleasesSectionState extends State<ReleasesSection> {
  Set<String> markedMovies = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff282A28),
      height: 199,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Releases ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 7,
            ),
            FutureBuilder(
                future: ApiManager.getUpcomingSource(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                        final movie = upcomingResponse?[index];
                        final isMarked =
                            markedMovies.contains(movie?.id.toString());
                        final imageUrl =
                            "https://image.tmdb.org/t/p/w500${movie?.backdropPath ?? ''}";
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, HomeScreenDetails.routeName,
                                arguments: upcomingResponse?[index].id);
                            setState(() {});
                          },
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageUrl,
                                width: 100,
                                height: 250,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Positioned(
                              right: 74,
                              bottom: 113,
                              child: InkWell(
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
                                      color: isMarked
                                          ? Colors.amber
                                          : Color(0xff514F4F),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 4,
                                      child: Icon(
                                          isMarked ? Icons.done : Icons.add,
                                          size: 15,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
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
    );
  }
}
