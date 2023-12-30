import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/ui/home_page.dart';

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
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamed(context, HomePage.routeName);
                        }
                      },
                      color: secondaryColor,
                      child: Text(
                        backTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushNamed(context, HomePage.routeName);
                        }
                      },
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
