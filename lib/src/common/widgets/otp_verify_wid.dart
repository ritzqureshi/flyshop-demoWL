import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/bloc/loginState/login_state.dart';
import '../utils/functions.dart';

class OtpVerifyWid extends StatefulWidget {
  final dynamic request;
  final String title;
  final String number;
  OtpVerifyWid({
    super.key,
    required this.title,
    required this.number,
    this.request,
  });

  @override
  State<OtpVerifyWid> createState() => _OtpVerifyWidState();
}

class _OtpVerifyWidState extends State<OtpVerifyWid> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          // bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/otpverify.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter OTP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              const SizedBox(height: 16),
              _buildOTPFields(context, loginState),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(right: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        for (final controller in _controllers) {
                          controller.clear();
                        }
                        for (final node in _focusNodes) {
                          node.unfocus();
                        }
                        FunctionsUtils.loadingDialog(context);
                        // trigger resend logic here
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(color: Colors.blue, fontSize: 21),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "An OTP will be sent on your\n registered Number ${FunctionsUtils.maskPhoneNumber(widget.number)}",
                style: const TextStyle(fontSize: 12, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  //-------OTP BOX-------//
  Widget _buildOTPFields(BuildContext context, LoginState authLogin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: EdgeInsets.all(4),
          width: 60,
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: FunctionsUtils.phoneInputFormatters(),
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            autofocus: true,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) async {
              String otp = _controllers
                  .map((controller) => controller.text)
                  .join();
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              } else if (index == 3 && value.isNotEmpty) {
                widget.request['otp'] = otp;
                await authLogin.loginAndVerify(context, widget.request);
                getLog(otp, "otpotp");
                // _verifyOTP();
              }
            },
          ),
        ),
      ),
    );
  }
}
