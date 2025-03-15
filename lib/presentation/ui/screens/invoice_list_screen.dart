import 'package:ecommerce_crafty_bay/presentation/state_holders/invoice_list_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  final InvoiceListController _invoiceListController =
      Get.put(InvoiceListController());

  @override
  void initState() {
    super.initState();
    _invoiceListController.fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.left_chevron),
        ),
        title: Text("Invoice List",
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      body: GetBuilder<InvoiceListController>(
        builder: (invoiceListController) {
          if (invoiceListController.inProgress) {
            return const CenterCircularProgressIndicator();
          }
          if (invoiceListController.invoiceList.isEmpty) {
            return Center(
                child: Text(
              "No invoices found!",
            ));
          }
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: invoiceListController.invoiceList.length,
            itemBuilder: (context, index) {
              final invoice = invoiceListController.invoiceList[index];
              return Card(
                color: Colors.white,
                // Fixed color issue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice ID: ${invoice.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Total: \$${invoice.total}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "Payable: \$${invoice.payable}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        "Status: ${invoice.paymentStatus}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        "Created: ${invoice.createdAt}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
