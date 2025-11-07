import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/button_primary.dart';
import 'package:recipe_book_app/widgets/text_form_field.dart';
import '../widgets/social_media_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => CheckBoxCubit(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to Recipe Passport App", style: Fonts.titlesFont32),
                const SizedBox(height: 10),
                Text(
                  "Please enter your account details below!",
                  style: Fonts.darkGreen16,
                ),
                const SizedBox(height: 40),

                // Form fields
                TextFomfieldWidget(
                  controller: nameController,
                  icon: Icon(Icons.person_2_outlined, color: AppColors.darkGreen3),
                  hintText: "Full Name",
                ),
                const SizedBox(height: 16),
                TextFomfieldWidget(
                  controller: emailController,
                  icon: Icon(Icons.email_outlined, color: AppColors.darkGreen3),
                  hintText: "Email Address",
                ),
                const SizedBox(height: 16),
                TextFomfieldWidget(
                  controller: passwordController,
                  icon: Icon(Icons.lock_outlined, color: AppColors.darkGreen3),
                  icon2: Icon(Icons.remove_red_eye_outlined, color: AppColors.darkGreen3),
                  hintText: "Password",
                ),
                const SizedBox(height: 8),

                // Checkbox
                Row(
                  children: [
                    BlocBuilder<CheckBoxCubit, bool>(
                      builder: (context, state) {
                        return Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          activeColor: AppColors.primaryColor,
                          checkColor: Colors.white,
                          side: BorderSide(color: AppColors.primaryColor, width: 2),
                          value: state,
                          onChanged: (_) {
                            context.read<CheckBoxCubit>().toggle();
                          },
                        );
                      },
                    ),
                    Text("Accept terms & Condition", style: Fonts.primaryColor14),
                  ],
                ),
                const SizedBox(height: 12),

                // Continue button
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return BlocBuilder<CheckBoxCubit, bool>(
                      builder: (context, isChecked) {
                        return PrimaryButton(
                          label: "Continue",
                          width: double.infinity,
                          onPressed: () async {
                            if (!isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please accept terms & conditions'),
                                ),
                              );
                            }

                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill in all fields')),
                              );
                            }

                            await context.read<AuthCubit>().signUp(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                );

                                
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 25),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or continue with", style: Fonts.darkGreen12),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                // Social media widget
                const SocialMediaWidget(),
                const SizedBox(height: 50),

                // Sign in text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account with us?", style: Fonts.darkGreen15),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Login');
                      },
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
      ),
    );
  }
}
