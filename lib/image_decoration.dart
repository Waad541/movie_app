import 'package:flutter/material.dart';

class ImageDecoration extends StatelessWidget {
  String image;
  String title;
  String date;
   ImageDecoration({required this.image,super.key,required this.title,required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    borderRadius:
                    BorderRadius.circular(10),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500$image}",
                      width: 100,
                      height: 99,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '7.7',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11),
                  ),
                ]),
            Positioned(
              right: 74,
              bottom: 187,
              child: Stack(
                children: [
                  Icon(
                    Icons.bookmark,
                    size: 35,
                    color: Color(0xff514F4F),
                  ),
                  Positioned(
                    left: 10,
                    top: 5,
                    child: Icon(Icons.add,
                        size: 15,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            //
          ]),
    );
  }
}
