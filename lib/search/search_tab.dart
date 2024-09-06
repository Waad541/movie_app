import 'package:flutter/material.dart';
import 'package:movie_app/home/home_screen_details.dart';
import 'package:movie_app/main_screen.dart';
import '../API_MANAGER.dart';

class SearchTab extends SearchDelegate{


  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return  ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff514F4F),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        showResults(context);
      },icon: Icon(Icons.search),)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.popAndPushNamed(context, MainScreen.routeName);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildUi();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BuildUi();
  }

  Widget BuildUi(){
    return  Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body:  FutureBuilder(
        future: ApiManager.getSearchSource(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          var searchData=snapshot.data?.results??[];
          return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, HomeScreenDetails.routeName,arguments: searchData[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 130,
                      width: 500,
                      decoration: BoxDecoration(
                          color:Color(0xff282A28),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(8),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${searchData[index].posterPath??""}}",
                                width: 170,
                                height: 105,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(searchData[index].title??"",style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white
                                  ),),
                                  Text(searchData[index].releaseDate??"",style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey)
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star,color: Colors.amber,size: 15,),
                                      Text(searchData[index].voteAverage.toString().substring(0,3),style: TextStyle(
                                        color: Colors.white,fontSize: 12,
                                      ),),
                                    ],
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
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Color(0xff707070),
                );
              },
              itemCount: searchData.length);
        },
      ),
    );
  }

}