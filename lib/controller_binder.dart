import 'package:ecommerce_crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/create_product_review_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/invoice_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/invoice_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/list_review_by_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/policy_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_list_by_brand_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/read_profile_data_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/regular_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/send_email_otp_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/theme_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/top_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/trending_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(MainBottomNavController());
    Get.put(SendEmailOtpController());
    Get.put(VerifyOTPController());
    Get.put(ReadProfileDataController());
    Get.put(AuthController());
    Get.put(CompleteProfileController());
    Get.put(HomeBannerController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(TopProductController());
    Get.put(TrendingProductController());
    Get.put(RegularProductController());
    Get.put(ProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(CartListController());
    Get.put(CreateInvoiceController());
    Get.put(InvoiceListController());
    Get.put(InvoiceProductController());
    Get.put(PolicyController());
    Get.put(WishListController());
    Get.put(CreateProductReviewController());
    Get.put(ListReviewByProductController());
    Get.put(BrandListController());
    Get.put(ProductListByBrandController());
  }
}
