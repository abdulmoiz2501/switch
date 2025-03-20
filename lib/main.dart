import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'core/theme/bloc/theme_cubit.dart';
import 'core/theme/bloc/theme_state.dart';
import 'core/utils/app_colors.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/source/firebase_auth_data_source.dart';
import 'features/auth/domain/usecase/sign_in_usecase.dart';
import 'features/auth/domain/usecase/sign_up_usecase.dart';
import 'features/auth/domain/usecase/update_fcm_token_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/cart/data/models/cart_item_model.dart';
import 'features/cart/data/repository/cart_repository_impl.dart';
import 'features/cart/data/source/cart_local_data_source.dart';
import 'features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'features/cart/domain/usecase/get_cart_items_usecase.dart';
import 'features/cart/domain/usecase/remove_from_cart_usecase.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/main/presentation/cubit/main_cubit.dart';
import 'features/product/data/repository/product_repository_impl.dart';
import 'features/product/data/source/product_data_source.dart';
import 'features/product/domain/usecase/fetch_products_usecase.dart';
import 'features/product/presentation/cubit/product_cubit.dart';
import 'features/shared/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';

final authDataSource = FirebaseAuthDataSourceImpl(
  FirebaseAuth.instance,
  FirebaseFirestore.instance,
  FirebaseMessaging.instance,
);
final authRepository = AuthRepositoryImpl(authDataSource);
final signUpUseCase = SignUpUseCase(authRepository);
final signInUseCase = SignInUseCase(authRepository);
final updateFcmTokenUseCase = UpdateFcmTokenUseCase(authRepository);
final productRemoteDataSource = ProductRemoteDataSourceImpl();
final productRepository = ProductRepositoryImpl(productRemoteDataSource);
final fetchProductsUseCase = FetchProductsUseCase(productRepository);
final cartLocalDataSource = CartLocalDataSourceImpl();
final cartRepository = CartRepositoryImpl(cartLocalDataSource);
final addToCartUseCase = AddToCartUseCase(cartRepository);
final removeFromCartUseCase = RemoveFromCartUseCase(cartRepository);
final getCartItemsUseCase = GetCartItemsUseCase(cartRepository);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(CartItemModelAdapter());

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
            BlocProvider(
              create: (_) => MainCubit(),
            ),
            BlocProvider(
              create: (_) => ProductCubit(fetchProductsUseCase),
            ),
            BlocProvider(
              create: (_) => CartCubit(
                addToCartUseCase: addToCartUseCase,
                removeFromCartUseCase: removeFromCartUseCase,
                getCartItemsUseCase: getCartItemsUseCase,
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
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor:
                    AppColors.scaffoldBackgroundColor(state.isDarkMode),
                    selectedItemColor: AppColors.primaryColor(state.isDarkMode),
                    unselectedItemColor: AppColors.textColor(state.isDarkMode),
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
