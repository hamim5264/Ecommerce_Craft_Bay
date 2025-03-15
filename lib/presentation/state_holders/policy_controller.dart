import 'package:ecommerce_crafty_bay/data/models/policy_model.dart';
import 'package:ecommerce_crafty_bay/data/services/network_caller.dart';
import 'package:ecommerce_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class PolicyController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  PolicyModel? _policy;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  PolicyModel? get policy => _policy;

  Future<void> fetchPolicy() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller().getRequest(Urls.policy);

    _inProgress = false;
    if (response.isSuccess) {
      _policy = PolicyModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    update();
  }
}
