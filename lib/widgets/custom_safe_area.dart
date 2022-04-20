import 'package:flutter/material.dart';

class CustomSafeArea extends StatefulWidget {
  final Widget child;
  final Color? color;
  final GestureTapCallback? onTap;
  final WillPopCallback? onWillPop;

  const CustomSafeArea({
    Key? key,
    required this.child,
    this.color,
    this.onTap,
    this.onWillPop,
  }) : super(key: key);

  @override
  State<CustomSafeArea> createState() => _CustomSafeAreaState();
}

class _CustomSafeAreaState extends State<CustomSafeArea> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    bool hideKeyboard = MediaQuery.of(context).viewInsets.bottom == 0;
    if (hasFocus && hideKeyboard) {
      FocusScope.of(context).unfocus();
      hasFocus = false;
    } else if (!hideKeyboard) {
      hasFocus = true;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (widget.onTap != null) widget.onTap!();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: widget.color,
        child: widget.onWillPop == null
            ? SafeArea(child: widget.child, bottom: false)
            : WillPopScope(
                onWillPop: widget.onWillPop,
                child: SafeArea(child: widget.child),
              ),
      ),
    );
  }
}
