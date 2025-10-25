import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class WeeklyPickWidget extends StatelessWidget {
  const WeeklyPickWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomLeft,
      children: [
        Image.asset(
          "assets/weekly_pick.png",
          width: double.infinity,
          height: 200,
          fit: BoxFit.fill,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ),
          ),
        ),

        Positioned(
          top: 110,
          left: 15,
          child: Text(
            "Weekly Pick",
            style:Fonts.h1W
          ),
        ),
        Positioned(
          top: 146,
          left: 15,

          child: Text(
            "This Italian pasta and steak will \n warm up the faintest of hearts.",
            style: Fonts.h6,
          ),
        ),

        Positioned(
          right: 15,
          bottom: 28,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),

            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_arrow, color: Colors.black, size: 25),
            ),
          ),
        ),
      ],
    );
  }
}
