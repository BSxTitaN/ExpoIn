import 'package:flutter/material.dart';

class StdFormat extends StatelessWidget {
  final Widget widget;
  final Widget stackWidget;
  const StdFormat({super.key, required this.widget, required this.stackWidget,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            stackWidget,
            SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16),
              child: widget,
            )),
          ],
        ),
      ),
    );
  }
}
