import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';

class ErrorBack extends StatelessWidget {
  const ErrorBack(
      {super.key, required this.errorTitle, required this.backTitle});

  final String errorTitle;
  final String backTitle;

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
              defaultTargetPlatform == TargetPlatform.iOS
                  ? CupertinoButton(
                      onPressed: () => Navigator.pop(context),
                      color: secondaryColor,
                      child: Text(
                        backTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(secondaryColor),
                      ),
                      child: Text(
                        backTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
