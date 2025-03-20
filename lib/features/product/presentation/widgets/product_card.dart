import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final bool isDarkMode;
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.isDarkMode,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.productCardBg(isDarkMode);
    final cartCubit = context.watch<CartCubit>();
    final isInCart = cartCubit.isProductInCart(product);

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
                  product.imageUrl,
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    //context.read<CartCubit>().toggleCartItem(product);
                    context.read<CartCubit>().addOrUpdateProduct(product);
                  },
                  child: Image.asset(
                    AppAssets.cartIcon,
                    width: 40.w,
                    height: 40.h,
                    color: isInCart
                        ? AppColors.primaryColor(isDarkMode)
                        : (isDarkMode ? Colors.white : Colors.grey),
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
                    product.title,
                    style: TextStyle(
                      color: AppColors.textColor(isDarkMode),
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
                      product.rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: AppColors.ratingColor(isDarkMode),
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
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
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
