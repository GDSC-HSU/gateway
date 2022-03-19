import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Uploading"),
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
}
