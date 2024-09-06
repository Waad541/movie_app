import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/watchlist/watch_list_model.dart';

class FirebaseFunctions {

  static CollectionReference<WatchListModel> getCollection() {
    return FirebaseFirestore.instance.collection('WatchList').withConverter(
      fromFirestore: (snapshot, _) {
        return WatchListModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addToWatch(WatchListModel model){
    var collection=getCollection();
    var docRef=collection.doc(model.id);
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<WatchListModel>> getToWatch(){
    var collection=getCollection();
    return collection.snapshots();
  }

  static Future<void> deleteFromWatch(String id){
    var collection=getCollection();
    return collection.doc(id).delete();
  }

  static Future<void> update(WatchListModel model){
    var collection=getCollection();
    return collection.doc(model.id).update(model.toJson());
  }

}
