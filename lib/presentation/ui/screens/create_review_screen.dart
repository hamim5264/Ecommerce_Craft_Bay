import 'package:ecommerce_crafty_bay/presentation/state_holders/create_product_review_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/list_review_by_product_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productID});

  final int productID;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final TextEditingController _productIdTEController = TextEditingController();
  final TextEditingController _ratingTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Review",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _descriptionTEController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter description";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _ratingTEController,
                  decoration: const InputDecoration(
                    hintText: "Rating Out of 5",
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter rating";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CreateProductReviewController>(
                      builder: (createProductReviewController) {
                    return Visibility(
                      visible:
                          createProductReviewController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool response = await createProductReviewController
                                .createReview(
                              widget.productID,
                              _descriptionTEController.text.trim(),
                              int.parse(_ratingTEController.text.trim()),
                            );
                            if (response) {
                              if (mounted) {
                                Navigator.pop(context);
                                Get.find<ListReviewByProductController>()
                                    .getReviewList(widget.productID);
                              }
                              Get.snackbar(
                                "Success",
                                "Your review has been added",
                                snackPosition: SnackPosition.TOP,
                                duration: const Duration(seconds: 2),
                                backgroundColor: AppColors.primaryColor
                                    .withValues(alpha: 0.3),
                                colorText: Colors.white,
                                barBlur: 10,
                                margin: const EdgeInsets.all(10),
                              );
                            } else {
                              Get.snackbar(
                                "Failed",
                                createProductReviewController.errorMessage,
                                snackPosition: SnackPosition.TOP,
                                duration: const Duration(seconds: 2),
                                backgroundColor:
                                    Colors.red.withValues(alpha: 0.5),
                                colorText: Colors.white,
                                barBlur: 10,
                                margin: const EdgeInsets.all(10),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Submit",
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionTEController.dispose();
    _productIdTEController.dispose();
    _ratingTEController.dispose();
  }
}
