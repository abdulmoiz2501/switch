import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../data/models/order_model.dart';
import '../../presentation/cubit/order_cubit.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          if (cartState is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (cartState is CartLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAddressSection(isDarkMode),
                  SizedBox(height: 20.h),
                  _buildOrderSummary(cartState, isDarkMode),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "Place Order",
                    onPressed: () {
                      _onPlaceOrder(cartState);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No items in cart."));
          }
        },
      ),
    );
  }

  Widget _buildAddressSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _addressController,
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on, color: AppColors.primaryColor(isDarkMode)),
            hintText: "Enter your address",
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
      ],
    );
  }

  Widget _buildOrderSummary(CartLoaded cartState, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor(isDarkMode),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartState.items.length,
            itemBuilder: (context, index) {
              final item = cartState.items[index];
              return _buildCartItemTile(item, isDarkMode);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemTile(CartItemModel item, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black12 : Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8.r)),
            child: Image.network(
              item.imageUrl,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: AppColors.textColor(isDarkMode),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
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
        ],
      ),
    );
  }

  void _onPlaceOrder(CartLoaded cartState) {
    final address = _addressController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your address.")),
      );
      return;
    }

    final authState = context.read<AuthCubit>().state;
    String userId = 'guest';
    if (authState is AuthSuccess) {
      userId = authState.user.uid;
    }

    final order = OrderModel(
      orderId: cartState.items.isNotEmpty ? cartState.items.first.productId.toString() : 'order_0',
      userId: userId,
      userEmail: (authState as AuthSuccess).user.email,
      address: _addressController.text.trim(),
      items: cartState.items.map((item) => {
        'userId': userId,
        'productId': item.productId,
      }).toList(),
      subtotal: 0.0,
      shippingFee: 0.0,
      discount: 0.0,
      total: 0.0,
      timestamp: DateTime.now(),
    );

    context.read<OrderCubit>().placeOrder(order);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully!")),
    );
  }
}
