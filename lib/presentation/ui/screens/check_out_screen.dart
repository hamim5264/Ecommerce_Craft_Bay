import 'package:ecommerce_crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/payment_web_vew_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
        ),
      ),
      body: GetBuilder<CreateInvoiceController>(
          builder: (createInvoiceController) {
        if (createInvoiceController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        final invoiceWrapper =
            createInvoiceController.paymentMethodListModel.data!.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                  width: double.infinity,
                  child: Card(
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Payable: \$${invoiceWrapper.payable}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Vat: \$${invoiceWrapper.vat}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Total: \$${invoiceWrapper.total}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: invoiceWrapper.paymentMethodList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => PaymentWebViewScreen(
                            url: invoiceWrapper.paymentMethodList![index]
                                .redirectGatewayURL!));
                      },
                      leading: Image.network(
                        invoiceWrapper.paymentMethodList![index].logo ?? "",
                      ),
                      title: Text(
                        invoiceWrapper.paymentMethodList![index].name ?? "",
                      ),
                      trailing: Icon(
                        CupertinoIcons.right_chevron,
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                    indent: 10,
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
