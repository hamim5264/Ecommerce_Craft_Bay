import 'package:ecommerce_crafty_bay/data/models/brand_model.dart';
import 'package:ecommerce_crafty_bay/data/models/product_model.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/invoice_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/regular_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/theme_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/top_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/trending_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/brand_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/invoice_list_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/invoice_product_list_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/policy_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/brands/brand_item.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/category_item.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/home/banner_carousel.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/product_card_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              searchTextField,
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 220,
                child: GetBuilder<HomeBannerController>(
                  builder: (homeBannerController) {
                    return Visibility(
                      visible: homeBannerController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: BannerCarousel(
                        bannerList:
                            homeBannerController.bannerListModel.bannerList ??
                                [],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: "All Categories",
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              const SizedBox(
                height: 8,
              ),
              GetBuilder<BrandListController>(builder: (brandListController) {
                return SectionTitle(
                  title: "Brands",
                  onTapSeeAll: () {
                    Get.to(() => BrandScreen());
                  },
                );
              }),
              brandList,
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Trending",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<TrendingProductController>(
                  builder: (trendingProductController) {
                return Visibility(
                  visible: trendingProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      trendingProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Regular",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<RegularProductController>(
                  builder: (regularProductController) {
                return Visibility(
                  visible: regularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      regularProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Popular",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                return Visibility(
                  visible: popularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      popularProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                return Visibility(
                  visible: popularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      popularProductController.productListModel.productList ??
                          []),
                );
              }),
              SectionTitle(
                title: "Special",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              const SizedBox(
                height: 8,
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                return Visibility(
                  visible: specialProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      specialProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "New",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      newProductController.productListModel.productList ?? []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Top",
                onTapSeeAll: () {
                  Get.to(const ProductListScreen());
                },
              ),
              GetBuilder<TopProductController>(builder: (topProductController) {
                return Visibility(
                  visible: topProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      topProductController.productListModel.productList ?? []),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: 130,
      child: GetBuilder<BrandListController>(builder: (brandListController) {
        return Visibility(
          visible: brandListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount: brandListController.branListModel.data?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BrandItem(
                brandModel: brandListController.branListModel.data![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox brandListItems(List<BrandModel> brandList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: brandList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return BrandItem(brandModel: brandList.toList().first);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}

SizedBox get categoryList {
  return SizedBox(
    height: 130,
    child: GetBuilder<CategoryController>(builder: (categoryController) {
      return Visibility(
        visible: categoryController.inProgress == false,
        replacement: const CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount:
              categoryController.categoryListModel.categoryList?.length ?? 0,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryItem(
              category:
                  categoryController.categoryListModel.categoryList![index],
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      );
    }),
  );
}

SizedBox productList(List<ProductModel> productList) {
  return SizedBox(
    height: 190,
    child: ListView.separated(
      itemCount: productList.length,
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ProductCardItem(
          product: productList[index],
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          width: 8,
        );
      },
    ),
  );
}

TextFormField get searchTextField {
  return TextFormField(
    decoration: InputDecoration(
        hintText: "Search",
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: const Icon(
          CupertinoIcons.search,
          color: Colors.grey,
        )),
  );
}

AppBar get appBar {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Image.asset(
      AssetsPath.appLogoNav,
    ),
    actions: [
      const SizedBox(
        width: 8,
      ),
      CircleIconButton(
        onTap: () {},
        iconData: CupertinoIcons.phone,
      ),
      const SizedBox(
        width: 8,
      ),
      CircleIconButton(
        onTap: () {},
        iconData: CupertinoIcons.bell,
      ),
      const SizedBox(
        width: 8,
      ),
    ],
  );
}

Drawer buildDrawer() {
  return Drawer(
    child: Column(
      children: [
        GetBuilder<AuthController>(
          builder: (authController) {
            return UserAccountsDrawerHeader(
              accountName: Text(authController.readProfileData?.cusName ?? ""),
              accountEmail:
                  Text(authController.readProfileData?.user?.email ?? ""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(color: AppColors.primaryColor),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.list,
            color: AppColors.primaryColor,
          ),
          title: Text("Invoice List"),
          onTap: () {
            if (Get.find<AuthController>().isTokenNotNull) {
              Get.to(() => const InvoiceListScreen());
            } else {
              Get.to(() => const VerifyEmailScreen());
            }
          },
        ),
        ListTile(
          leading: Icon(
            Icons.list_alt,
            color: AppColors.primaryColor,
          ),
          title: Text("Invoice Product List"),
          onTap: () {
            if (Get.find<AuthController>().isTokenNotNull) {
              final invoiceListController = Get.find<InvoiceListController>();
              if (invoiceListController.invoiceList.isNotEmpty) {
                int invoiceId = invoiceListController.invoiceList.first.id ?? 0;
                Get.to(() => InvoiceProductListScreen(invoiceId: invoiceId));
              } else {
                Get.snackbar("Error", "No invoices available");
              }
            } else {
              Get.to(() => const VerifyEmailScreen());
            }
          },
        ),
        ListTile(
          leading: Icon(
            Icons.policy,
            color: AppColors.primaryColor,
          ),
          title: Text("Policy"),
          onTap: () {
            Get.to(() => const PolicyScreen());
          },
        ),
        ListTile(
          leading: Obx(() => Icon(
                Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Get.find<ThemeController>().themeMode.value ==
                        ThemeMode.dark
                    ? AppColors.primaryColor
                    : Colors.orange,
              )),
          title: Text("Dark Mode"),
          trailing: Obx(
            () => Switch(
              value:
                  Get.find<ThemeController>().themeMode.value == ThemeMode.dark,
              onChanged: (value) {
                Get.find<ThemeController>().toggleTheme();
              },
              activeColor: AppColors.primaryColor,
              activeTrackColor: AppColors.primaryColor.withValues(alpha: 0.5),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: AppColors.primaryColor,
          ),
          title: Text("Log Out"),
          onTap: () {
            AuthController.clearAuthData();
            Get.offAll(() => const VerifyEmailScreen());
          },
        ),
      ],
    ),
  );
}
