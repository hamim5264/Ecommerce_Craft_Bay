import 'package:ecommerce_crafty_bay/data/models/list_review_by_product_model.dart';
import 'package:ecommerce_crafty_bay/data/services/network_caller.dart';
import 'package:ecommerce_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ListReviewByProductController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  ListReviewByProductModel _listReviewByProductModel =
      ListReviewByProductModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  ListReviewByProductModel get listReviewByProductModel =>
      _listReviewByProductModel;

  Future<bool> getReviewList(int reviewProductId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.reviewList(reviewProductId));
    if (response.isSuccess) {
      _listReviewByProductModel =
          ListReviewByProductModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
