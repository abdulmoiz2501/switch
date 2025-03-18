import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback? onTap;

  const CustomSearchBar({
    Key? key,
    required this.isDarkMode,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.searchBarColor(isDarkMode),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.subtleTextColor(isDarkMode),
            ),
            SizedBox(width: 8.w),
            Text(
              "Search",
              style: TextStyle(
                color: AppColors.subtleTextColor(isDarkMode),
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
