import 'package:flutter_client/store/constants.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:flutter_client/store/variable_controller.dart';
import 'package:flutter_client/widgets/round_button.dart';
import 'package:flutter_client/util/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    () async {
      // await variableController.saveJwt(
      //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InlpbmdzaGFveG9AZ21haWwuY29tIiwicmFuZG9tX3N0cmluZyI6IjBGTzJFRSJ9.niSe3jhQdefzUJEgQgf7rqvrP2CkkCOls3YW5DkYE2c");
      // Get.offNamed(RoutesMap.roomList);
      bool valid = await jwtGrpcController.checkIfCurrentJwtIsValid();
      if (valid) {
        Get.offNamed(RoutesMap.roomList);
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.only(
          top: 120,
          left: 50,
          right: 50,
          bottom: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(),
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: buildContents(),
            ),
            Center(child: buildBottom(context)),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Text(
      '🎉 Welcome!',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget buildContents() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'We\'re working hard to get WeLoveParty ready for launch!',
            style: TextStyle(
              height: 1.8,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'If you don\'t yet have an invite, you can send your email to yingshaoxo so he can add you in. We are so grateful you\'re here and can\'t wait to have you join! 🙏',
            style: TextStyle(
              height: 1.8,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '🏠 yingshaoxo & the WeLoveParty team',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundButton(
          color: Style.AccentBlue,
          onPressed: () {
            Get.offNamed(RoutesMap.register);
          },
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Get in with email',
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
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //     Text(
        //       'Have an invite text?',
        //       style: TextStyle(
        //         color: Style.AccentBlue,
        //       ),
        //     ),
        //     SizedBox(
        //       width: 5,
        //     ),
        //     Text(
        //       'Sign in',
        //       style: TextStyle(
        //         color: Style.AccentBlue,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Icon(
        //       Icons.arrow_right_alt,
        //       color: Style.AccentBlue,
        //     ),
        // ],
        // ),
      ],
    );
  }
}
