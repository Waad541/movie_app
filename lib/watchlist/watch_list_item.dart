import 'package:flutter/material.dart';
import 'package:movie_app/firebase/firebase_functions.dart';

import 'watch_list_model.dart';

class WatchListItem extends StatelessWidget {
  WatchListModel model;
  WatchListItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Image.network(
            model.image ?? "",
            height: 106,
            width: 140,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title ?? "",
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(model.releaseDate ?? "",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseFunctions.deleteFromWatch(model.id.toString());
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
