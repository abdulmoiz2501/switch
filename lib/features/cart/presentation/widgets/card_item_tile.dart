import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/data/models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  final bool isDarkMode;
  final CartItemModel item;
  final VoidCallback onRemove;

  const CartItemTile({
    Key? key,
    required this.isDarkMode,
    required this.item,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isDarkMode ? Colors.white12 : Colors.grey[300]!;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor(isDarkMode),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
            child: Image.network(
              item.imageUrl,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: AppColors.textColor(isDarkMode),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "\$${item.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primaryColor(isDarkMode),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            icon: Image.asset(
              AppAssets.binIcon,
              width: 20.w,
              height: 20.h,
              color: isDarkMode ? Colors.white : Colors.grey,
            ),
            onPressed: onRemove,
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
