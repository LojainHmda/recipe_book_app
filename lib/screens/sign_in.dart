import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/button_primary.dart';
import 'package:recipe_book_app/widgets/social_media_widget.dart';
import 'package:recipe_book_app/widgets/text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final TextEditingController emailController = TextEditingController();
        final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back! 😊🤗🤗", style: Fonts.titlesFont32),
              SizedBox(height: 10),
              Text(
                "Please enter your account details below!",
                style: Fonts.darkGreen16,
              ),
              SizedBox(height: 40),
              TextFomfieldWidget(
                icon: Icon(Icons.email_outlined, color: AppColors.darkGreen3),
                hintText: "Email Address",
                controller: emailController,
              ),
              SizedBox(height: 16),
              TextFomfieldWidget(
                controller: passController,
                icon: Icon(Icons.lock_outlined, color: AppColors.darkGreen3),
                icon2: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColors.darkGreen3,
                ),
                hintText: "Password",
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: Fonts.darkGreen15.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 24),

              PrimaryButton(label: "Login", width: double.infinity),

              //divider
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Or Login with", style: Fonts.darkGreen12),
                  ),

                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 24),

              SocialMediaWidget(),

              //text_button
              SizedBox(height: 110),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have account with us?", style: Fonts.darkGreen15),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: Text(
                      " Sign up",
                      style: Fonts.darkGreen15.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
