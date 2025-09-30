import 'package:flutter/widgets.dart';

class DismissKeyboardLayout extends StatelessWidget {
  // Widgets
  final Widget child;

  // Constructor
  const DismissKeyboardLayout({
    super.key,
    required this.child,
  });

  // Tree
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
