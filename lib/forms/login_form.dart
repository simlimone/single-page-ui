import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:single_page_ui/config/constants.dart' as k;
import 'package:single_page_ui/config/styles.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RxBool isHidden = true.obs;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: k.Strings.kEmailHintText,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return k.Strings.kFieldEmpty;
                  }

                  if (!(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value))) {
                    return k.Strings.kEmailNotValid;
                  }

                  return null;
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _passwordController,
                obscureText: isHidden.value,
                decoration: InputDecoration(
                    hintText: k.Strings.kPasswordHintText,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(isHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        isHidden.toggle();
                      },
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return k.Strings.kFieldEmpty;
                  }

                  if (value.length < k.Int.minimumPasswordLength) {
                    return k.Strings.kPasswordTooShort;
                  }

                  return null;
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  highlightColor: k.KColors.kLoginHighlightColor,
                  child: Text(
                    k.Strings.kLoginButtonText,
                    style: kLoginButtonStyle,
                  ),
                  color: k.KColors.kLoginButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 2),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You logged in with the email ${_emailController.text} and the password ${_passwordController.text}',
                            style: kSnackBarStyle,
                          ),
                          behavior: k.SnackBar.kSnackBarBehavior,
                        ),
                      );

                      _emailController.clear();
                      _passwordController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}