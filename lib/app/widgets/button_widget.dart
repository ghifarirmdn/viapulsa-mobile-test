import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    super.key,
    this.onTap,
    this.color,
    this.text,
    this.paddingContent,
    this.borderRadius,
  });
  final Function()? onTap;
  final Color? color;
  final String? text;
  final EdgeInsetsGeometry? paddingContent;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await widget.onTap?.call();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          color: widget.color,
        ),
        child: Center(
          child: Padding(
            padding: widget.paddingContent ??
                const EdgeInsets.symmetric(vertical: 15),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    widget.text!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
