import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Mock data for grid items
  final List<Map<String, dynamic>> mockProducts = const [
    {
      "title": "Gaming Headset: Blue VO!CE Detachable Boom Mic",
      "imageUrl": "https://m.media-amazon.com/images/I/71IL4SsThNL.__AC_SX300_SY300_QL70_FMwebp_.jpg",
      "price": 84.99,
      "rating": 4.8,
    },
    {
      "title": "Samsung S24 FE",
      "imageUrl": "https://m.media-amazon.com/images/I/61uakkLoHxL._AC_UY218_.jpg",
      "price": 614.00,
      "rating": 4.5,
    },
    {
      "title": "Google Pixel 9",
      "imageUrl": "https://m.media-amazon.com/images/I/61fh21u3DJL._AC_UY218_.jpg",
      "price": 645.00,
      "rating": 4.2,
    },
    {
      "title": "18 Piece Dinnerware set",
      "imageUrl": "https://m.media-amazon.com/images/I/61QUTfInRxL._AC_UL320_.jpg",
      "price": 39.99,
      "rating": 4.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    final authState = context.watch<AuthCubit>().state;
    UserModel? user;
    if (authState is AuthSuccess) {
      user = authState.user;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Hello, ${user?.email ?? 'Guest'}",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              isDarkMode: isDarkMode,
              onTap: () {

              },
            ),
            SizedBox(height: 20.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Best sellers",
                  style: TextStyle(
                    color: AppColors.textColor(isDarkMode),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220.h,
              ),
              itemBuilder: (context, index) {
                final product = mockProducts[index];
                return ProductCard(
                  isDarkMode: isDarkMode,
                  imageUrl: product["imageUrl"],
                  title: product["title"],
                  price: product["price"],
                  rating: product["rating"],
                );
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
