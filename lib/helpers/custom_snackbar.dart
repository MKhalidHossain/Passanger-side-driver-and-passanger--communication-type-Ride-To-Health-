
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customPrint(String message) {
  if (kDebugMode) {
    print(message);
  }
}

void showCustomSnackBar(
  String message, {
  bool isError = true,
  int seconds = 2,
  String? subMessage,
}) {
  Get.closeCurrentSnackbar();
  Get.showSnackbar(
    GetSnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(10).copyWith(right: 10),
      duration: Duration(seconds: seconds),
      backgroundColor: Colors.black12,

      borderRadius: 10,
      messageText: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subMessage != null
                      ? Text(
                        subMessage,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
