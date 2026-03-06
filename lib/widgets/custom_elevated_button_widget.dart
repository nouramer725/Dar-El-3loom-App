import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CustomElevatedButtonWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color colorContainer;
  final Color sideColor;
  final double sideWidth;
  final Function() onPressed;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  const CustomElevatedButtonWidget({
    required this.text,
    this.textStyle = const TextStyle(),
    this.sideColor = AppColors.strokeBottomNavBarColor,
    this.sideWidth = 2,
    required this.colorContainer,
    required this.onPressed,
    this.padding,
    super.key,
  });

  @override
  _CustomElevatedButtonWidgetState createState() =>
      _CustomElevatedButtonWidgetState();
}

class _CustomElevatedButtonWidgetState
    extends State<CustomElevatedButtonWidget> {
  bool _isLoading = false;

  void _handleTap() async {
    if (widget.onPressed != null) {
      setState(() => _isLoading = true);
      try {
        await widget.onPressed!();
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: widget.padding,
        backgroundColor: WidgetStateProperty.all(widget.colorContainer),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: widget.sideColor, width: widget.sideWidth),
          ),
        ),
      ),
      onPressed: _isLoading ? null : _handleTap,
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.buttonColor,
                strokeWidth: 2,
              ),
            )
          : Text(widget.text, style: widget.textStyle),
    );
  }
}
