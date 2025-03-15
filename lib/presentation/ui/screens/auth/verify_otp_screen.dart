import 'dart:async';
import 'package:ecommerce_crafty_bay/presentation/state_holders/send_email_otp_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isError = false;
  late Timer _timer = Timer(Duration.zero, () {});
  int _secondsRemaining = 120;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

  void _resendCode() async {
    final controller = Get.find<SendEmailOtpController>();

    if (controller.lastSentEmail.isEmpty) {
      Get.snackbar(
        "Resend Failed",
        "No email found. Please go back and enter your email..",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.withValues(alpha: 0.5),
        colorText: Colors.white,
        barBlur: 10,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    bool result = await controller.sendOtpToEmail(controller.lastSentEmail);

    if (result) {
      setState(() {
        _secondsRemaining = 120;
        _isResendEnabled = false;
      });
      _startCountdown();
      Get.snackbar(
        "OTP Resent",
        "A new OTP has been sent to your email.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
        colorText: Colors.white,
        barBlur: 10,
        margin: const EdgeInsets.all(10),
      );
    } else {
      Get.snackbar(
        "Resend Failed",
        "No email found. Please go back and enter your email.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.withValues(alpha: 0.5),
        colorText: Colors.white,
        barBlur: 10,
        margin: const EdgeInsets.all(10),
      );
    }
  }

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
                  height: 160,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "A 6 digit OTP hase been sent",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  controller: _pinTEController,
                  appContext: context,
                  length: 6,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  backgroundColor: Colors.transparent,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldWidth: 40,
                    fieldHeight: 50,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    selectedFillColor: Colors.transparent,
                    activeColor: isError ? Colors.red : AppColors.primaryColor,
                    inactiveColor:
                        Get.isDarkMode ? Colors.grey : Colors.grey.shade400,
                    selectedColor:
                        isError ? Colors.red : AppColors.primaryColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  textStyle: TextStyle(
                    color: isError ? Colors.red : AppColors.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onCompleted: (v) {
                    setState(
                      () {
                        if (v == "000000") {
                          isError = false;
                        } else {
                          isError = true;
                        }
                      },
                    );
                  },
                  onChanged: (value) {
                    setState(
                      () {
                        isError = false;
                      },
                    );
                  },
                  beforeTextPaste: (text) => true,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOTPController>(
                      builder: (verifyOTPController) {
                    return Visibility(
                      visible: verifyOTPController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool response = await verifyOTPController
                                .verifyOTP(widget.email, _pinTEController.text);
                            if (response) {
                              if (verifyOTPController
                                  .shouldNavigateCompleteProfile) {
                                Get.to(() => const CompleteProfileScreen());
                              } else {
                                Get.offAll(() => const MainBottomNavScreen());
                              }
                            } else {
                              Get.snackbar(
                                "OTP Verification Failed!",
                                verifyOTPController.errorMessage,
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
                          "Next",
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: "This code will expire in ",
                      ),
                      TextSpan(
                        text: "$_secondsRemaining s",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _isResendEnabled ? _resendCode : null,
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      color: _isResendEnabled
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
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
    _timer.cancel();
    super.dispose();
  }
}
