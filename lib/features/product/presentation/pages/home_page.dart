import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:switch_test_task/features/product/presentation/pages/product_detail_page.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    final authState = context.watch<AuthCubit>().state;
    UserModel? user;
    if (authState is AuthSuccess) {
      user = authState.user;
    }

    context.read<ProductCubit>().fetchProducts();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hello, ${user?.email ?? 'Guest'}",
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(isDarkMode: isDarkMode, onTap: () {}),
            SizedBox(height: 20.h),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text("Dark Mode", style: TextStyle(color: AppColors.textColor(isDarkMode)),),
                  value: state.isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
            Text(
              "Categories",
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("ALL", isDarkMode),
                  _buildCategoryChip("Rings", isDarkMode),
                  _buildCategoryChip("Necklaces", isDarkMode),
                  _buildCategoryChip("Earrings", isDarkMode),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                AppAssets.bannerImage,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 160.h,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Best sellers",
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220.h,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          print("The product clicked on is: $product");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ProductDetailPage(
                                    isDarkMode: isDarkMode,
                                    product: product,
                                  ),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductDetailPage(
                          //       product: product,
                          //     ),
                          //   ),
                          // );
                        },
                        child: ProductCard(
                          isDarkMode: isDarkMode,
                          product: product,
                        ),
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: TextStyle(color: AppColors.textColor(isDarkMode)),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.chipBackgroundColor(isDarkMode),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.textColor(isDarkMode),
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
