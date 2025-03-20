import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/bloc/theme_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/card_item_tile.dart';
import '../widgets/order_summary_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    //final isDarkMode = false;
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            color: AppColors.textColor(isDarkMode),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text(
                  "No items added to the cart",
                  style: TextStyle(
                    color: AppColors.textColor(isDarkMode),
                    fontSize: 16.sp,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Items
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemTile(
                        isDarkMode: isDarkMode,
                        item: item,
                        onRemove: () {
                          context.read<CartCubit>().removeProduct(item.productId);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  OrderSummary(
                    isDarkMode: isDarkMode,
                    subtotal: state.subtotal,
                    shippingFee: state.shippingFee,
                    discount: state.discount,
                    total: state.total,
                  ),
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
