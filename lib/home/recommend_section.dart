import 'package:flutter/material.dart';
import '../API_MANAGER.dart';
import '../firebase/firebase_functions.dart';
import 'home_screen_details.dart';
import '../watchlist/watch_list_model.dart';

class RecommendSection extends StatefulWidget {
  const RecommendSection({super.key});

  @override
  State<RecommendSection> createState() => _RecommendSectionState();
}

class _RecommendSectionState extends State<RecommendSection> {
  Set<String> markedMovies = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff282A28),
      height: 270,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Recommended ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 9),

            FutureBuilder(
              future: ApiManager.getTopRatedSource(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                var topRatedResponse = snapshot.data?.results;
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 18);
                    },
                    itemCount: topRatedResponse?.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = topRatedResponse?[index];
                      final imageUrl =
                          "https://image.tmdb.org/t/p/w500${movie?.backdropPath ?? ''}";
                      final isMarked = markedMovies.contains(movie?.id.toString());

                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, HomeScreenDetails.routeName,
                              arguments: movie?.id);
                        },
                        child: Container(
                          width: 100,
                          height: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff343534),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      width: 100,
                                      height: 99,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        movie?.voteAverage
                                                .toString()
                                                .substring(0, 3) ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie?.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium

                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    movie?.releaseDate ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Positioned(
                                left: -10,
                                top: -6,
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
                                        color: isMarked
                                            ? Colors.amber
                                            : Color(0xff514F4F),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 5,
                                        child: Icon(
                                          isMarked
                                              ? Icons.done
                                              : Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
