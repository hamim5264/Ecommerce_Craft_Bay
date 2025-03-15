import 'package:ecommerce_crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/check_out_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/carts/cart_product_item.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Get.find<MainBottomNavController>().backToHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Carts",
          ),
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
            ),
          ),
        ),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          return Visibility(
            visible: cartListController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount:
                        cartListController.cartListModel.cartItemList?.length ??
                            0,
                    itemBuilder: (context, index) {
                      return CartProductItem(
                        cartItem: cartListController
                            .cartListModel.cartItemList![index],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                  ),
                ),
                totalPriceAndCheckOutSection(cartListController.totalPrice),
              ],
            ),
          );
        }),
      ),
    );
  }

  Container totalPriceAndCheckOutSection(RxDouble totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black45,
                ),
              ),
              Obx(
                () => Text(
                  "\$$totalPrice",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const CheckOutScreen());
              },
              child: const Text(
                "Checkout",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
