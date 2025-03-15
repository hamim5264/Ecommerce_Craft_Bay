import 'package:ecommerce_crafty_bay/presentation/state_holders/policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  final PolicyController _policyController = Get.put(PolicyController());

  @override
  void initState() {
    super.initState();
    _policyController.fetchPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Policy",
        ),
      ),
      body: GetBuilder<PolicyController>(
        builder: (controller) {
          if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.policy == null) {
            return Center(
                child: Text(controller.errorMessage.isEmpty
                    ? "No policy found."
                    : controller.errorMessage));
          }
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: HtmlWidget(
                controller.policy?.description ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}
