import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/bloc/theme_cubit.dart';
import 'core/theme/bloc/theme_state.dart';
import 'core/utils/app_colors.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/source/firebase_auth_data_source.dart';
import 'features/auth/domain/usecase/sign_in_usecase.dart';
import 'features/auth/domain/usecase/sign_up_usecase.dart';
import 'features/auth/domain/usecase/update_fcm_token_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/shared/screens/splash_screen.dart';
import 'firebase_options.dart';

final authDataSource = FirebaseAuthDataSourceImpl(
  FirebaseAuth.instance,
  FirebaseFirestore.instance,
  FirebaseMessaging.instance,
);
final authRepository = AuthRepositoryImpl(authDataSource);
final signUpUseCase = SignUpUseCase(authRepository);
final signInUseCase = SignInUseCase(authRepository);
final updateFcmTokenUseCase = UpdateFcmTokenUseCase(authRepository);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ThemeCubit(),
            ),
            BlocProvider(
              create: (_) => AuthCubit(
                signUpUseCase: signUpUseCase,
                signInUseCase: signInUseCase,
                updateFcmTokenUseCase: updateFcmTokenUseCase,
              ),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: AppColors.primaryColor(state.isDarkMode),
                  scaffoldBackgroundColor:
                  AppColors.scaffoldBackgroundColor(state.isDarkMode),
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  ).apply(
                    bodyColor: AppColors.textColor(state.isDarkMode),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: AppColors.textColor(state.isDarkMode),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor(state.isDarkMode),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                    color: AppColors.primaryColor(state.isDarkMode),
                  ),
                ),
                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
