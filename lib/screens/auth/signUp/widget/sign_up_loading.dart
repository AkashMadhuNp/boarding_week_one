import 'package:flutter/material.dart';

class SignUpLoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}