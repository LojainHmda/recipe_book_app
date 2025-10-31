
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/button_primary.dart';
import 'package:recipe_book_app/widgets/text_form_field.dart';
import '../services/firestore_service.dart';
import '../widgets/social_media_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final Services service = Services();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Welcome to Recipe Passport App", style: Fonts.titlesFont32),
              SizedBox(height: 10),
              Text(
                "Please enter your account details below!",
                style: Fonts.darkGreen16,
              ),

              SizedBox(height: 40),
              Form(
                onChanged: () {},
                child: Column(
                  children: [
                    TextFomfieldWidget(
                      controller: nameController,
                      icon: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.darkGreen3,
                      ),
                      hintText: "Full Name",
                    ),

                    SizedBox(height: 16),
                    TextFomfieldWidget(
                      controller: emailController,

                      icon: Icon(
                        Icons.email_outlined,
                        color: AppColors.darkGreen3,
                      ),
                      hintText: "Email Address",
                    ),
                    SizedBox(height: 16),
                    TextFomfieldWidget(
                      controller: passwordController,

                      icon: Icon(
                        Icons.lock_outlined,
                        color: AppColors.darkGreen3,
                      ),
                      icon2: Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.darkGreen3,
                      ),
                      hintText: "Password",
                    ),
                  ],
                ),
              ),
              //checkBox
              SizedBox(height: 8),
              BlocProvider(
                create: (context) => CheckBoxCubit(),
                child: Row(
                  children: [
                    BlocBuilder<CheckBoxCubit, CheckBoxState>(
                      builder: (context, state) {
                        return Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: AppColors.primaryColor,
                          checkColor: Colors.white,
                          side: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          value: context.read<CheckBoxCubit>().flag,
                          onChanged: (value) {
                            context.read<CheckBoxCubit>().check();
                          },
                        );
                      },
                    ),
                    Text(
                      "Accept terms & Condition",
                      style: Fonts.primaryColor14,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),
              PrimaryButton(
                label: "Continue",
                width: double.infinity,
                onPressed: () async {
                 
                },
              ),
              SizedBox(height: 25),

              //divider
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Or continue with", style: Fonts.darkGreen12),
                  ),

                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 24),
              SocialMediaWidget(),
              SizedBox(height: 50),

              //text_button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account with us?",
                    style: Fonts.darkGreen15,
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Sign in",
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
