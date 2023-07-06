import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Circular progress bar
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("$message , Please Wait......")
        ],
      ),
    );
  }
}
