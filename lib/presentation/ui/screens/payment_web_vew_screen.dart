import 'package:ecommerce_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            Get.to(const MainBottomNavScreen());
            Get.snackbar(
              "Payment Failed",
              "Something went wrong",
              isDismissible: true,
              duration: const Duration(seconds: 2),
              animationDuration: const Duration(milliseconds: 1500),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            Get.offAll(const MainBottomNavScreen());
            Get.snackbar(
              "Payment Success",
              "You have successfully purchased your item",
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
              colorText: Colors.white,
              barBlur: 10,
              margin: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            );
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
        ),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
