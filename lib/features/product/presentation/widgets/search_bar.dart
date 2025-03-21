import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.isDarkMode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.searchBarColor(isDarkMode),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          color: AppColors.subtleTextColor(isDarkMode),
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: AppColors.subtleTextColor(isDarkMode),
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            color: AppColors.subtleTextColor(isDarkMode),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

