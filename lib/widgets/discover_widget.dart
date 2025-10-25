
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_app/theme/colors.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF5F6F5),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(width: 110, height: 60),
              Positioned(
                left: 53,
                child: Image.asset(
                  'assets/Ellipse1.png',
                  height: 62,
                  width: 62,
                ),
              ),
              Positioned(
                left: 32,
                child: Image.asset(
                  'assets/Ellipse3.png',
                  height: 62,
                  width: 62,
                ),
              ),
    
              Positioned(
                left: 12,
                child: Image.asset(
                  'assets/Ellipse2.png',
                  height: 62,
                  width: 62,
                ),
              ),
            ],
          ),
          SizedBox(width: 9),
          Text(
            "Discover more dishes \nby exploring what’s new",
            style: GoogleFonts.montserrat(fontSize: 14),
          ),
          SizedBox(width: 9),
    
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_circle_right,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
