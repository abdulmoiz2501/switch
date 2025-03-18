import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/bloc/theme_cubit.dart';
import 'core/theme/bloc/theme_state.dart';
import 'core/utils/app_colors.dart';
import 'features/shared/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => ThemeCubit(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: AppColors.primaryColor(state.isDarkMode),
                  scaffoldBackgroundColor:
                  AppColors.scaffoldBackgroundColor(state.isDarkMode),
                  textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(bodyColor: AppColors.textColor(state.isDarkMode)),
                ),
                home:SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
