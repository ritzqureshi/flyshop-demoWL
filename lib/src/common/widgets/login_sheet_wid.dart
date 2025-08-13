import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ikotech/src/data/bloc/loginState/login_state.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../utils/colours.dart';
import 'my_button.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  LoginBottomSheetState createState() => LoginBottomSheetState();
}

class LoginBottomSheetState extends State<LoginBottomSheet> {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  TextEditingController mobileController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? numberCountryCode = '91';
  String? countryCodeISO = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 41),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage("assets/images/loginImage.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Login in to app",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            loginFormField(number, mobileController),

            SizedBox(height: 20),
            MyButton(
              onClick: () async {
                String userName = _usernameController.text;
                // String password = _passwordController.text;
                String mobileNo = mobileController.text;
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() => isLoading = true);
                  await loginState.loginSendOtp(context, {
                    "email": userName,
                    "mobile": mobileNo,
                    "country_code": numberCountryCode?.replaceAll("+", " "),
                  });
                  // if (result['status']) {
                  //   setState(() => isLoading = false);
                  //   Navigator.pop(context, result);
                  // } else {
                  //   FunctionsUtils.toast(result['message']);
                  // }
                }
              },
              borderRadiusValue: 13,
              btnTxt: ("Login"),
              btnTextStyle: TextStyle(
                fontSize: 27,
                color: MyColors.white,
                fontWeight: FontWeight.bold,
              ),
              width: 310,
              elevation: 0,
              backgroundColor: MyColors.primaryColorOfApp,
            ),
            SizedBox(height: 10),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  const TextSpan(text: 'By proceeding, you agree to our '),
                  TextSpan(
                    text: 'T&C',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to T&C page
                      },
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to Privacy Policy page
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginFormField(
    PhoneNumber number,
    TextEditingController mobileController,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country Code Picker
                    Container(
                      width: 130,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.grey, width: 2),
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(top: 13),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: InternationalPhoneNumberInput(
                          initialValue: number,
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          onInputChanged: (PhoneNumber updatedNumber) {
                            setState(() {});
                            numberCountryCode = updatedNumber.dialCode ?? '';
                            countryCodeISO = updatedNumber.isoCode ?? '';
                          },
                          inputDecoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                          ),
                          formatInput: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          keyboardType: TextInputType.none,
                          ignoreBlank: true,
                          inputBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Mobile Number Field
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 13),
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grey, width: 2),
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: mobileController,
                            validator: _validatePassword,
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.phone_android),
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(fontWeight: FontWeight.w400),
                              counterText: '',
                            ),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //------validate old passowrd-----//
  // String? _validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your registered email';
  //   } else if (!RegExp(
  //     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  //   ).hasMatch(value)) {
  //     return "Enter a valid email address";
  //   }

  //   return null;
  // }

  //------validate old passowrd-----//
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }
}
