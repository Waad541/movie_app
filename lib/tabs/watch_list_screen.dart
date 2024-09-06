import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase/firebase_functions.dart';
import 'package:movie_app/watchlist/watch_list_item.dart';

class WatchListScreen extends StatefulWidget {
  static const String routeName = 'watch';
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Watch List',
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFunctions.getToWatch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                var data = snapshot.data?.docs
                        .map((e) =>
                            e.data())
                        .toList() ??
                    [];
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return WatchListItem(model: data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color(0xff707070),
                        );
                      },
                      itemCount: data.length),
                );
              }),
        ],
      ),
    );
  }
}
