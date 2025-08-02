import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colours.dart';

class MyTextField extends StatelessWidget {
  final EdgeInsetsGeometry? marginContainer;
  final bool? isObscured;
  final String? Function(String?)? validator;
  final Decoration? decorationContainer;
  final Function? onSubmitTextField;
  final int? maxLength;
  final int? maxLines;
  final bool? autofocus;
  final FocusNode? focusNode;
  final FocusNode? focusNodeToRequest;
  final TextEditingController? textEditingController;
  final TextStyle? styleTextField;
  final TextInputAction? focusAction;
  final TextInputType? keyboardType;
  final String? labelTextTextField;
  final TextStyle? labelTextStyle;

  final InputDecoration? decorationTextField;
  final String? topLabelText;
  final TextStyle? topLabelTextStyle;
  final String? topTitle;
  final Widget? prefixIcon;

  const MyTextField(
      {super.key,
      this.marginContainer,
      this.isObscured,
      this.validator,
      this.decorationContainer,
      this.onSubmitTextField,
      this.maxLength,
      this.maxLines,
      this.autofocus,
      this.focusNode,
      this.focusAction,
      this.focusNodeToRequest,
      required this.textEditingController,
      this.styleTextField,
      this.decorationTextField,
      this.keyboardType,
      this.labelTextStyle,
      required this.labelTextTextField,
      this.topLabelText,
      this.topLabelTextStyle,
      this.topTitle = '',
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (topLabelText != null)
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(
                topLabelText!,
                // style: topLabelTextStyle != null
                //     ? topLabelTextStyle
                //     : MyStyles.STYLE_col_primary_size_14_bold,
              ),
            ),
          Container(
            margin: marginContainer ??
                EdgeInsets.only(
                  top: topLabelText == null ? 15 : 0,
                ),
            decoration: decorationContainer ??
                BoxDecoration(
                  border: Border.all(
                    color: MyColors.grey,
                    width: 2.0,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
            child: TextFormField(
              obscureText: isObscured != null ? isObscured! : false,
              validator: validator,
              textInputAction: focusAction ?? TextInputAction.done,
              focusNode: focusNode,
              autofocus: autofocus != null ? autofocus! : false,
              maxLength: maxLength,
              
              maxLines: maxLines ?? 1,
              style: styleTextField ??
                  const TextStyle(
                    color: Colors.black,
                  ),
              controller: textEditingController,              
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: decorationTextField ??
                  InputDecoration(
                    // errorText: errorText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelText: labelTextTextField,
                    prefixIcon:
                        prefixIcon ?? const Icon(CupertinoIcons.envelope),
                    labelStyle: labelTextStyle ??
                        const TextStyle(
                          color: Colors.grey,
                        ),
                    // border: InputBorder.none,
                  ),
            ),
          ),
        ]);
  }
}