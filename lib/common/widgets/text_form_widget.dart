import 'package:attendance_app/common/constants/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    Key? key,
    this.controller,
    required this.label,
    this.valueText = '',
    this.errorMessage,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.bottom,
    this.value,
    this.hint,
    this.error = false,
    this.obscure = false,
    this.disable = true,
    this.onChange,
    this.maxLines = 1,
    this.readonly = false,
    this.filledColor = false,
    this.onTap,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? bottom;
  final String? value;
  final String? hint;
  final String valueText;
  final bool? obscure;
  final bool error;
  final bool? disable;
  final bool readonly;
  final bool filledColor;
  final ValueChanged<String>? onChange;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  double vSpaceHeight = 6.h;
  double paddingHorizontal = 16.w;
  double contentVertical = 12.h;
  bool onFocus = false;
  final FocusNode focusNode = FocusNode();
  late TextEditingController textController;
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.value);
    isObscure = widget.obscure ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: widget.value,
          readOnly: widget.readonly,
          maxLines: widget.maxLines,
          enabled: widget.disable,
          focusNode: focusNode,
          maxLength: widget.maxLength,
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          onTap: widget.onTap ?? () => widget.onChange?.call(widget.valueText),
          onChanged: widget.onChange,
          obscureText: isObscure,
          decoration: InputDecoration(
            errorText: widget.errorMessage,
            counterText: "",
            prefixIcon: widget.prefix != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                    ),
                    child: Transform.translate(
                      offset: const Offset(0, 1),
                      child: widget.prefix,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: contentVertical,
            ),
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.errorMessage != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                widget.obscure == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: (isObscure)
                            ? SvgPicture.asset(AssetsConstant.eyeIcon)
                            : SvgPicture.asset(
                                AssetsConstant.eyeSlashIcon,
                              ),
                      )
                    : widget.suffix ?? const SizedBox.shrink(),
              ],
            ),
            hintText: widget.hint,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(vSpaceHeight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(vSpaceHeight),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(vSpaceHeight),
            ),
            filled: !widget.disable! || widget.filledColor,
          ),
        ),
      ],
    );
  }
}
