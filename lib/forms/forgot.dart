import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_page_ui/config/constants.dart' as k;
import 'package:single_page_ui/config/styles.dart';
import 'package:single_page_ui/controllers/home_controller.dart';

class ForgotPassword extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: k.KColors.kBackColor,
          ),
          onPressed: () {
            homeController.goToPage(0);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              'Forgot Password Page',
              style: kForgotPasswordStyle,
            ),
          ),
        ),
      ],
    );
  }
}