import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/data/auth_shared_preferences.dart';
import 'package:recipe_book_app/data/category_sqlite_db.dart';
import 'package:recipe_book_app/data/recent_recipes_sqlite_db.dart';
import 'package:recipe_book_app/screens/food_list_by_country.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_book_app/screens/sign_up.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'firebase_options.dart';
import 'screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AuthSharedPreferences.init();
  await CategorySqliteDb.init();
  await RecentRecipesSqliteDb.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<LoadRecipesCubit>(create: (_) => LoadRecipesCubit()),
        BlocProvider<UserEditCubit>(
          create: (context) => UserEditCubit(context.read<AuthCubit>()),
        ),
      ],
      child: Auth(),
    ),
  );
}

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Logout) {
            final uid = AuthSharedPreferences.prefs.getString("uid");
            if (uid != null) {
              context.read<AuthCubit>().autoLogin();
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return SignInScreen();
          }

          if (state is ShowSignInScreen) {
            return SignInScreen();
          }

          if (state is ShowSignUpScreen) {
            return SignUpScreen();
          }

          if (state is SignUpSucsess || state is SignInSucsess) {
            return HomeScreen();
          }

          if (state is AuthLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          }

          return Scaffold(body: Center(child: Text('Unknown state: $state')));
        },
      ),
      routes: {
        "/foodListByCountry": (_) => FoodListByCountry(),
        "/Home": (_) => HomeScreen(),
        "/Login": (_) => SignInScreen(),
        "/signUp": (_) => SignUpScreen(),
      },
    );
  }
}
