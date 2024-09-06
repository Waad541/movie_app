class WatchListModel {
  String? id;
  bool? isMarked;
  String? title;
  String? image;
  String? releaseDate;

  WatchListModel(
      { this.image,
       this.releaseDate,
      this.id = '',
      this.isMarked = false,
       this.title});

  WatchListModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            id: json['id'],
            isMarked: json['isMarked'],
            image: json['image'],
            releaseDate: json['releaseDate']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'isMarked': isMarked,
      'releaseDate':releaseDate,
      'image':image
    };
  }
}
