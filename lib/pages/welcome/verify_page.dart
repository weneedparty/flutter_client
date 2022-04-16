import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/store/variable_controller.dart';
import 'package:flutter_client/utils/style.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double getScreenWidth() => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          width: 330,
          padding: const EdgeInsets.only(
            top: 180,
            bottom: 60,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: buildTitle(),
              ),
              const SizedBox(
                height: 60,
              ),
              buildForm(),
              const Spacer(),
              Center(child: buildBottom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      'Please enter the code \nwe sent to you #',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget buildForm() {
    return Container(
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
                key: const Key("verify_input"),
                onChanged: (value) {
                  // _formKey.currentState?.validate();
                },
                validator: (value) {
                  // get called by
                  // _formKey.currentState?.validate();
                  return null;
                },
                controller: _codeController,
                autocorrect: false,
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: 'Code',
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
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
        RoundButton(
          color: Style.AccentBlue,
          minimumWidth: 230,
          disabledColor: Style.AccentBlue.withOpacity(0.3),
          // onPressed: onSignUpButtonClick,
          onPressed: () async {
            if (_codeController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please enter a valid code!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
            } else {
              String emailAddress = variableController.preferences
                      ?.getString(LocalStorageKeys.userEmail) ??
                  "";
              String? jwt = await jwtGrpcController.registerConfirm(
                  email: emailAddress.trim(),
                  code: _codeController.text.trim());
              if (jwt != null) {
                await variableController.saveJwt(jwt);
                print("jwt: " + jwt);
                Get.offNamed(RoutesMap.roomList);
              } else {
                Fluttertoast.showToast(
                    msg: "Invalid code!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0);
                Get.offNamed(RoutesMap.register);
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
