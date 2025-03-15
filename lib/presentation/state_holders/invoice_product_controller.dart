import 'package:ecommerce_crafty_bay/data/models/invoice_product_list_model.dart';
import 'package:ecommerce_crafty_bay/data/services/network_caller.dart';
import 'package:ecommerce_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class InvoiceProductController extends GetxController {
  bool _inProgress = false;
  List<InvoiceProductModel> _invoiceProductList = [];
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  List<InvoiceProductModel> get invoiceProductList => _invoiceProductList;

  String get errorMessage => _errorMessage;

  Future<void> fetchInvoiceProducts(int invoiceId) async {
    _inProgress = true;
    update();

    final response =
        await NetworkCaller().getRequest(Urls.invoiceProductList(invoiceId));

    _inProgress = false;

    if (response.isSuccess) {
      try {
        final List<dynamic> jsonData = response.responseData;
        _invoiceProductList =
            jsonData.map((json) => InvoiceProductModel.fromJson(json)).toList();
        update();
      } catch (e) {
        _errorMessage = "Failed to parse data!";
        update();
      }
    } else {
      _errorMessage = response.errorMessage;
      update();
    }
  }
}
