import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/util/history.dart';
import 'package:flutter_client/utils.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_client/util/style.dart';
import 'package:flutter_client/pages/welcome/invitation_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_client/store/global_controller_variables.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool emailIsValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 180,
          bottom: 60,
        ),
        child: Column(
          children: [
            buildTitle(),
            const SizedBox(
              height: 50,
            ),
            buildForm(),
            const Spacer(),
            buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      'Enter your email #',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget buildForm() {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // CountryCodePicker(
          //   initialSelection: 'KR',
          //   showCountryOnly: false,
          //   alignLeft: false,
          //   padding: const EdgeInsets.all(8),
          //   textStyle: const TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {
                  _formKey.currentState?.validate();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    emailIsValid = false;
                  } else {
                    if (emailValidator(value)) {
                      emailIsValid = true;
                    } else {
                      emailIsValid = false;
                    }
                  }
                  return null;
                },
                controller: _emailController,
                autocorrect: false,
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Column(
      children: [
        const Text(
          'By entering your email, you\'re agreeing to out\nTerms or Services and Privacy Policy. Thanks!',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        RoundButton(
          color: Style.AccentBlue,
          minimumWidth: 230,
          disabledColor: Style.AccentBlue.withOpacity(0.3),
          // onPressed: onSignUpButtonClick,
          onPressed: () async {
            if (!emailIsValid) {
              Fluttertoast.showToast(
                  msg: "Please enter a valid email!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
            } else {
              bool result = await jwtGrpcController.preRegister(
                  email: _emailController.text);
              if (result) {
                variableController.userEmail = _emailController.text;
                Get.offNamed(RoutesMap.registerVerifying);
              } else {
                Fluttertoast.showToast(
                    msg: "Something went wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0);
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
