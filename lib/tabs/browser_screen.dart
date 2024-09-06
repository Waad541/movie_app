import 'package:flutter/material.dart';
import 'package:movie_app/API_MANAGER.dart';
import 'package:movie_app/browser_details.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Category ',
        ),
      ),

      body: FutureBuilder(
        future: ApiManager.getCategoriesNameSource(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          var nameCategory = snapshot.data?.genres ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(20), // Padding for the GridView
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    BrowserDetails.routeName,
                    arguments: nameCategory[index].id,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        nameCategory[index].name ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: nameCategory.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 2 / 1,
            ),
          )
          ;
        },
      ),
    );
  }
}
