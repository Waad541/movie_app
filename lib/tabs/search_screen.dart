import 'package:flutter/material.dart';
import 'package:movie_app/search/search_tab.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void _startSearch() async {
    showSearch(
      context: context,
      delegate: SearchTab(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Color(0xff514F4F),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,size: 25,),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: Center(
        child: Text("Tap the search icon to search for movies",style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.w400,fontSize: 17
        ),),
      ),
    );
  }
}
