import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../order/presentation/pages/checkout_page.dart';
import '../../../shared/widgets/custom_button.dart';

class OrderSummary extends StatelessWidget {
  final bool isDarkMode;
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;

  const OrderSummary({
    Key? key,
    required this.isDarkMode,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor(isDarkMode),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}", isDarkMode),
          SizedBox(height: 4.h),
          _buildRow("Shipping Fee", "\$${shippingFee.toStringAsFixed(2)}", isDarkMode),
          SizedBox(height: 4.h),
          _buildRow("Discount", "${discount.toStringAsFixed(0)}%", isDarkMode),
          Divider(
            color: isDarkMode ? Colors.white24 : Colors.grey[300],
            thickness: 1,
            height: 20.h,
          ),
          _buildRow("Total", "\$${total.toStringAsFixed(2)}", isDarkMode, bold: true),
          SizedBox(height: 20.h),

          CustomButton(
            text: "Proceed to Checkout",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isDarkMode, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 14.sp,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 14.sp,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
