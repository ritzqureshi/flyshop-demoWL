import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colours.dart';

class MyPasswordTextField extends StatefulWidget {
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
  final String? topTitle;

  const MyPasswordTextField(
      {super.key,
      this.marginContainer,
      this.validator,
      this.isObscured,
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
      required this.labelTextTextField,
      this.labelTextStyle,
      this.topTitle = ''});

  @override
  MyPasswordTextFieldState createState() => MyPasswordTextFieldState();
}

class MyPasswordTextFieldState extends State<MyPasswordTextField> {
  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Called Rebuild ' + _obscureText.toString());
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 7),
            alignment: Alignment.centerLeft,
            child: Text(widget.topTitle!)),
        Container(
          margin: widget.marginContainer ??
              EdgeInsets.only(
                top: widget.topTitle == null ? 20 : 0,
              ),
          decoration: widget.decorationContainer ??
              BoxDecoration(
                border: Border.all(
                  color: MyColors.grey,
                  width: 2.0,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
          child: TextFormField(
            obscureText: _obscureText,
            validator: widget.validator,
            textInputAction: widget.focusAction ?? TextInputAction.done,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus != null ? widget.autofocus! : false,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines ?? 1,
            style: widget.styleTextField ??
                const TextStyle(
                  color: Colors.black,
                ),
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            decoration: widget.decorationTextField ??
                InputDecoration(
                    // errorText: widget.errorText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelText: widget.labelTextTextField,
                    prefixIcon: const Icon(CupertinoIcons.lock),
                    labelStyle: widget.labelTextStyle ??
                        const TextStyle(
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordStatus,
                      color: Colors.blue,
                    )),
          ),
        ),
      ],
    );
  }
}