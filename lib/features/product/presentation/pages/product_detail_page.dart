import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:switch_test_task/features/shared/widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final bool isDarkMode;
  final ProductModel product;

  const ProductDetailPage({
    Key? key,
    required this.isDarkMode,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _reviewController = TextEditingController();
  double _userRating = 0.0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor(isDarkMode)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Details",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 250.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: TextStyle(
                      color: AppColors.textColor(isDarkMode),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primaryColor(isDarkMode),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              product.description,
              style: TextStyle(
                color: AppColors.textColor(isDarkMode).withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: TextStyle(
                    color: AppColors.textColor(isDarkMode),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "(${product.totalRatings} ratings)",
                  style: TextStyle(
                    color: AppColors.textColor(isDarkMode).withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            Text(
              "Add a review",
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            _buildRatingRow(isDarkMode),
            SizedBox(height: 8.h),
            TextField(
              controller: _reviewController,
              style: TextStyle(
                color: AppColors.textColor(isDarkMode),
                fontSize: 14.sp,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write your review here...",
                hintStyle: TextStyle(
                  color: AppColors.textColor(isDarkMode).withOpacity(0.5),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.black12 : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              text: "Submit Review",
              onPressed: () {
                _submitReview();
              },
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 0.4.sw,
                  text: "Add to cart",
                  color: AppColors.productCardBg(isDarkMode),
                  onPressed: () {
                    context.read<CartCubit>().addOrUpdateProduct(product);
                  },
                ),
                SizedBox(width: 16.w),
                CustomButton(
                  width: 0.4.sw,
                  text: "Buy Now",

                  onPressed: () {
                   //Get.to(() => CartPage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(bool isDarkMode) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final starIndex = index + 1;
          return IconButton(
            onPressed: () {
              setState(() {
                _userRating = starIndex.toDouble();
              });
            },
            icon: Icon(
              Icons.star,
              color: _userRating >= starIndex ? Colors.amber : Colors.grey,
            ),
          );
        }),
        SizedBox(width: 10.w),
        Text(
          "${_userRating.toStringAsFixed(1)}/5.0",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  void _submitReview() {
    final reviewText = _reviewController.text.trim();
    if (_userRating == 0.0 || reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide a rating and review.")),
      );
      return;
    }

    // TODO: Save to Firestore: e.g. productId -> reviews -> doc(userId) ...
    setState(() {
      _userRating = 0.0;
      _reviewController.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Review submitted!")));
  }
}
