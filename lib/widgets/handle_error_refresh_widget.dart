import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';

class ErrorRefresh extends StatelessWidget {
  const ErrorRefresh(
      {super.key,
      required this.errorTitle,
      this.refreshTitle,
      this.onPressed});

  final String errorTitle;
  final String? refreshTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (refreshTitle != null)
                Text(
                  refreshTitle!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              if (onPressed != null)
                IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      defaultTargetPlatform == TargetPlatform.iOS
                          ? CupertinoIcons.refresh
                          : Icons.refresh,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all<double>(35),
                      iconColor: MaterialStateProperty.all<Color>(primaryColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(secondaryColor),
                    )),
              ],
            ),
        ),
      ),
    );
  }
}
