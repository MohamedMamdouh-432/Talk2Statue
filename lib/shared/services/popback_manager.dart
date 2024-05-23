import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopBackManager extends StatelessWidget {
  final Widget pageChild;
  const PopBackManager(this.pageChild, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) async {
        await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to Exit?'),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
      },
      child: pageChild,
    );
  }
}
