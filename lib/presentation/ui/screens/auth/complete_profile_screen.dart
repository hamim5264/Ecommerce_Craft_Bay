import 'package:ecommerce_crafty_bay/data/models/create_profile_params.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _cusNameTEController = TextEditingController();
  final TextEditingController _cusAddTEController = TextEditingController();
  final TextEditingController _cusCityTEController = TextEditingController();
  final TextEditingController _cusStateTEController = TextEditingController();
  final TextEditingController _cusPostCodeTEController =
      TextEditingController();
  final TextEditingController _cusCountryTEController = TextEditingController();
  final TextEditingController _cusPhoneTEController = TextEditingController();
  final TextEditingController _cusFaxTEController = TextEditingController();
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipAddTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostCodeTEController =
      TextEditingController();
  final TextEditingController _shipCountryTEController =
      TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Complete Profile",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Get started with us with your details",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusNameTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Name",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusAddTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Address",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusCityTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer City",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer city";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusStateTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer State",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer state";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusPostCodeTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Post Code",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer post code";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusCountryTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Country",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer country";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusPhoneTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Phone",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer phone";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusFaxTEController,
                  decoration: const InputDecoration(
                    hintText: "Customer Fax",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter customer fax";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipNameTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship Name",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipAddTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship Address",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCityTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship City",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship city";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipStateTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship State",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship state";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPostCodeTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship Post Code",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship post code";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCountryTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship Country",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship Country";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPhoneTEController,
                  decoration: const InputDecoration(
                    hintText: "Ship Phone",
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter ship phone";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(
                      builder: (completeProfileController) {
                    return Visibility(
                      visible: completeProfileController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final createProfileParams = CreateProfileParams(
                              cusName: _cusNameTEController.text.trim(),
                              cusAdd: _cusAddTEController.text.trim(),
                              cusCity: _cusCityTEController.text.trim(),
                              cusState: _cusStateTEController.text.trim(),
                              cusPostcode: _cusPostCodeTEController.text.trim(),
                              cusCountry: _cusCountryTEController.text.trim(),
                              cusPhone: _cusPhoneTEController.text.trim(),
                              cusFax: _cusFaxTEController.text.trim(),
                              shipName: _shipNameTEController.text.trim(),
                              shipAdd: _shipAddTEController.text.trim(),
                              shipCity: _shipCityTEController.text.trim(),
                              shipState: _shipStateTEController.text.trim(),
                              shipPostcode:
                                  _shipPostCodeTEController.text.trim(),
                              shipCountry: _shipCountryTEController.text.trim(),
                              shipPhone: _shipPhoneTEController.text.trim(),
                            );
                            final bool result = await completeProfileController
                                .createProfileData(
                                    Get.find<VerifyOTPController>().token,
                                    createProfileParams);
                            if (result) {
                              Get.offAll(const MainBottomNavScreen());
                            } else {
                              Get.snackbar(
                                "Complete Profile Failed!",
                                completeProfileController.errorMessage,
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
                          "Complete",
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
    _cusNameTEController.dispose();
    _cusAddTEController.dispose();
    _cusCityTEController.dispose();
    _cusStateTEController.dispose();
    _cusPostCodeTEController.dispose();
    _cusCountryTEController.dispose();
    _cusPhoneTEController.dispose();
    _cusFaxTEController.dispose();
    _shipNameTEController.dispose();
    _shipAddTEController.dispose();
    _shipCityTEController.dispose();
    _shipStateTEController.dispose();
    _shipPostCodeTEController.dispose();
    _shipCountryTEController.dispose();
    _shipPhoneTEController.dispose();
  }
}
