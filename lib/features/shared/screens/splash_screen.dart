import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/bloc/theme_cubit.dart';
import '../../../core/theme/bloc/theme_state.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
 /*   await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(
      context,
      //MaterialPageRoute(builder: (_) => LoginScreen()),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appLogo,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 20.h),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            /*Center(
              child: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return SwitchListTile(
                    title: Text("Dark Mode"),
                    value: state.isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
