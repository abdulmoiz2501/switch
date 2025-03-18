import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:switch_test_task/core/utils/app_assets.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_state.dart';

class CustomBottomNavMainPage extends StatelessWidget {
  const CustomBottomNavMainPage({Key? key}) : super(key: key);

  final _pages = const [
    HomePage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;
        final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) => context.read<MainCubit>().selectTab(index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.homeIcon,
                  width: 40.w,
                  height: 40.h,
                  color: selectedIndex == 0
                      ? AppColors.primaryColor(isDarkMode)
                      : (isDarkMode ? Colors.white : Colors.grey),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.cartIcon,
                  width: 40.w,
                  height: 40.h,
                  color: selectedIndex == 1
                      ? AppColors.primaryColor(isDarkMode)
                      : (isDarkMode ? Colors.white : Colors.grey),
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Page"),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Cart Page"),
    );
  }
}


