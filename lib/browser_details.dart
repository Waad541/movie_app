import 'package:flutter/material.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/home/home_screen_details.dart';

class BrowserDetails extends StatefulWidget {
  static const String routeName = 'browserDetails';
  const BrowserDetails({super.key});

  @override
  State<BrowserDetails> createState() => _BrowserDetailsState();
}

class _BrowserDetailsState extends State<BrowserDetails> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: ApiManager.getCategoryDetailsSource(id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          var CategoryDetails = snapshot.data?.results ?? [];
          return ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    HomeScreenDetails.routeName,
                    arguments: CategoryDetails[index].id,
                  );
                },
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Color(0xff343534),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${CategoryDetails[index].posterPath ?? ""}",
                            width: 170,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CategoryDetails[index].title ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                CategoryDetails[index].releaseDate ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 15,
                                  ),
                                  Text(
                                    CategoryDetails[index]
                                        .voteAverage
                                        .toString()
                                        .substring(0, 3),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: CategoryDetails.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Color(0xff707070));
            },
          );
        },
      ),
    );
  }
}
