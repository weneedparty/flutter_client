import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/utils.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter_client/util/style.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 50), child: buildTitle()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(child: buildForm()),
              ],
            ),
            const Spacer(),
            Center(child: buildBottom()),
          ],
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
          'By entering your code, you\'re agreeing to out\nTerms or Services and Privacy Policy. Thanks!',
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
              String? jwt = await jwtGrpcController.registerConfirm(
                  email: variableController.userEmail,
                  code: _codeController.text);
              if (jwt != null) {
                variableController.jwt = jwt;
                print(jwt);
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
