import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/api/api_manager.dart';
class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({super.key, required this.errorMsg, required this.onTryAgain});
final String errorMsg;
final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Center(
          child: Text(errorMsg,style: Theme.of(context).textTheme.bodyMedium,),
        ),
        ElevatedButton(onPressed: onTryAgain,
            child: Text("Try Again",style: Theme.of(context).textTheme.labelMedium)
        )
      ],
    );
  }
}
