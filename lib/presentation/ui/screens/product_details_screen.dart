import 'package:ecommerce_crafty_bay/data/models/product_details_data.dart';
import 'package:ecommerce_crafty_bay/data/services/network_caller.dart';
import 'package:ecommerce_crafty_bay/data/utility/urls.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> noOfItems = ValueNotifier(1);
  List<Color> colors = [
    Colors.purpleAccent,
    Colors.blue,
    Colors.amber,
    Colors.red,
    Colors.green,
  ];
  List<String> sizes = [
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ];

  Color? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        final productDetails = productDetailsController.productDetails;

        if (productDetailsController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        if (productDetails == null) {
          return const Center(child: Text("No product details available."));
        }
        return Visibility(
          visible: productDetailsController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarousel(
                        urls: [
                          productDetails.img1 ?? "",
                          productDetails.img2 ?? "",
                          productDetails.img3 ?? "",
                          productDetails.img4 ?? "",
                        ],
                      ),
                      productDetailsBody(productDetails),
                    ],
                  ),
                ),
              ),
              priceAndAddToCartSection,
            ],
          ),
        );
      }),
    );
  }

  Padding productDetailsBody(ProductDetailsData productDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              ValueListenableBuilder(
                  valueListenable: noOfItems,
                  builder: (context, value, _) {
                    return ItemCount(
                      initialValue: value,
                      minValue: 1,
                      maxValue: 20,
                      decimalPlaces: 0,
                      step: 1,
                      color: AppColors.primaryColor,
                      onChanged: (v) {
                        noOfItems.value = v.toInt();
                      },
                    );
                  }),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          reviewAndRatingRow(productDetails.product?.star ?? 0),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Color",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          ColorSelector(
            colors: productDetails.color
                    ?.split(",")
                    .map((e) => getColorFromString(e))
                    .toList() ??
                [],
            onChange: (selectedColor) {
              _selectedColor = selectedColor;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Size",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizeSelector(
            sizes: productDetails.size?.split(",") ?? [],
            onChange: (s) {
              _selectedSize = s;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            productDetails.des ?? "",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Row reviewAndRatingRow(int rating) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              CupertinoIcons.star_fill,
              color: Colors.amber,
              size: 16,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              rating.toStringAsPrecision(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
            onPressed: () {
              Get.to(ReviewsScreen(
                productId: widget.productId,
              ));
            },
            child: Text(
              "Reviews",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            )),
        const SizedBox(
          width: 8,
        ),
        const SizedBox(
          width: 8,
        ),
        GetBuilder<ProductDetailsController>(
            builder: (productDetailsController) {
          return InkWell(
            onTap: () async {
              final response = await NetworkCaller().getRequest(
                  Urls.createWishList(
                      productDetailsController.productDetails?.product!.id ??
                          0));
              if (response.isSuccess) {
                Get.snackbar(
                  "Success",
                  "This product has been added to wish list",
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor:
                      AppColors.primaryColor.withValues(alpha: 0.3),
                  colorText: Colors.white,
                  barBlur: 10,
                  margin: const EdgeInsets.all(10),
                );
              } else {
                Get.snackbar(
                  "Failed",
                  productDetailsController.errorMessage,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red.withValues(alpha: 0.5),
                  colorText: Colors.white,
                  barBlur: 10,
                  margin: const EdgeInsets.all(10),
                );
              }
            },
            onLongPress: () async {
              Get.find<WishListController>().deleteWishList(
                  productDetailsController.productDetails?.product!.id ?? 0);
              Get.snackbar(
                "Success",
                "This product has been successfully removed from wish list",
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
                colorText: Colors.white,
                barBlur: 10,
                margin: const EdgeInsets.all(10),
              );
            },
            child: Card(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  CupertinoIcons.heart,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Container get priceAndAddToCartSection {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black45,
                  ),
                ),
                Text(
                  "\$${productDetailsController.productDetails?.product?.price ?? ""}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              child: GetBuilder<AddToCartController>(
                  builder: (addToCartController) {
                return Visibility(
                  visible: addToCartController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectedColor != null && _selectedSize != null) {
                        if (Get.find<AuthController>().isTokenNotNull) {
                          final stringColor = colorToString(_selectedColor!);
                          final response = await addToCartController.addToCart(
                              widget.productId,
                              stringColor,
                              _selectedSize!,
                              noOfItems.value);
                          if (response) {
                            Get.snackbar(
                              "Success",
                              "Product has been added to cart",
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 2),
                              backgroundColor:
                                  AppColors.primaryColor.withValues(alpha: 0.3),
                              colorText: Colors.white,
                              barBlur: 10,
                              margin: const EdgeInsets.all(10),
                            );
                          } else {
                            Get.snackbar(
                              "Add to Cart Failed!",
                              addToCartController.errorMessage,
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 2),
                              backgroundColor:
                                  Colors.red.withValues(alpha: 0.5),
                              colorText: Colors.white,
                              barBlur: 10,
                              margin: const EdgeInsets.all(10),
                            );
                          }
                        } else {
                          Get.to(() => const VerifyEmailScreen());
                          Get.snackbar(
                            "Unauthorized!",
                            "You have to log in before purchase something",
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.red.withValues(alpha: 0.5),
                            colorText: Colors.white,
                            barBlur: 10,
                            margin: const EdgeInsets.all(10),
                          );
                        }
                      } else {
                        Get.snackbar(
                          "Add to Cart Failed!",
                          "Please select color and size",
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red.withValues(alpha: 0.5),
                          colorText: Colors.white,
                          barBlur: 10,
                          margin: const EdgeInsets.all(10),
                        );
                      }
                    },
                    child: const Text(
                      "Add To Cart",
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  /// If Color Code is Hex ->>
  // Color getColorFromString(String colorCode) {
  //   String code = colorCode.replaceAll("#", "");
  //   String hexCode = "FF$code";
  //   return Color(int.parse("0x$hexCode"));
  // }

  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == "red") {
      return Colors.red;
    } else if (color == "white") {
      return Colors.white;
    } else if (color == "green") {
      return Colors.green;
    }
    return Colors.grey;
  }

  String colorToString(Color color) {
    if (color == Colors.red) {
      return "Red";
    } else if (color == Colors.white) {
      return "White";
    } else if (color == Colors.green) {
      return "Green";
    }
    return "Grey";
  }
}
