import 'package:flutter/material.dart';

showProgressDialog(context, message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var dialog = Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 24,
                ),
                Text(message)
              ],
            ),
          ),
        );
        return dialog;
      });
}
