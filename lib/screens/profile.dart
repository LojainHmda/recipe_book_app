import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';

import '../theme/fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile", style: Fonts.titlesFont24),
            SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: Image.asset(
                    "assets/weekly_pick.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: Fonts.titlesFont24.copyWith(fontSize: 20),
                    ),
                    Text(
                      "User Email@.com",
                      style: Fonts.h6.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: AppColors.grey),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: Fonts.F13.copyWith(color: AppColors.darkGreen1,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
