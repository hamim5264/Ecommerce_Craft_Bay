import 'package:ecommerce_crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/product_list_by_brand_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/brands/brand_card_item.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({
    super.key,
    required this.brand,
    required this.brandId,
  });

  final String? brand;
  final int? brandId;

  @override
  State<BrandListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<BrandListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.brandId != null) {
        Get.find<ProductListByBrandController>()
            .getProductListByBrand(brandId: widget.brandId!);
        Get.find<BrandListController>().getBrandList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand ?? "Brands"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductListByBrandController>(
            builder: (productListByBrandController) {
          return Visibility(
            visible: productListByBrandController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Visibility(
              visible: productListByBrandController
                      .brandListModel.data?.isNotEmpty ??
                  false,
              replacement: const Center(
                child: Text("No Products Here"),
              ),
              child: GridView.builder(
                itemCount:
                    productListByBrandController.brandListModel.data?.length ??
                        0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.90,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: BrandCardItem(
                        brand: productListByBrandController
                            .brandListModel.data![index]),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
