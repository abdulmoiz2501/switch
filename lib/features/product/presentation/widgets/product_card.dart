import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class ProductCard extends StatefulWidget {
  final bool isDarkMode;
  final String imageUrl;
  final String title;
  final double price;
  final double rating;

  const ProductCard({
    Key? key,
    required this.isDarkMode,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.productCardBg(widget.isDarkMode);

    return Container(
      width: 160.w,
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _addedToCart = !_addedToCart;
                    });
                  },
                  child: Image.asset(
                    AppAssets.cartIcon,
                    width: 35.w,
                    height: 35.h,
                    color: _addedToCart
                        ? AppColors.primaryColor(widget.isDarkMode)
                        : (widget.isDarkMode ? Colors.white : Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.textColor(widget.isDarkMode),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      AppAssets.ratingIcon,
                      width: 14.w,
                      height: 14.h,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      widget.rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: AppColors.ratingColor(widget.isDarkMode),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "\$${widget.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: AppColors.textColor(widget.isDarkMode),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
