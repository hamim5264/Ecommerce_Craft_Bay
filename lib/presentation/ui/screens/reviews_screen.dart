import 'package:ecommerce_crafty_bay/presentation/state_holders/list_review_by_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ListReviewByProductController>().getReviewList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reviews",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ListReviewByProductController>(
                builder: (listReviewByProductController) {
              return Visibility(
                visible: listReviewByProductController.inProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: listReviewByProductController
                          .listReviewByProductModel.data?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person_circle_fill,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                listReviewByProductController
                                        .listReviewByProductModel
                                        .data![index]
                                        .profile
                                        ?.cusName ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listReviewByProductController
                                        .listReviewByProductModel
                                        .data![index]
                                        .description ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rating: ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    listReviewByProductController
                                            .listReviewByProductModel
                                            .data![index]
                                            .rating ??
                                        "",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                ),
              );
            }),
          ),
          reviewSection,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            CreateReviewScreen(
              productID: widget.productId,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container get reviewSection {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
          ),
          Text(
            "Reviews",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black45,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GetBuilder<ListReviewByProductController>(
              builder: (listReviewByProductController) {
            return Text(
              listReviewByProductController
                      .listReviewByProductModel.data?.length
                      .toString() ??
                  "",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black45,
              ),
            );
          }),
        ],
      ),
    );
  }
}
