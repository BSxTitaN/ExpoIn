import 'package:expoin/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

import '../../../Components/r_button.dart';
import '../../../Design-System/app_font.dart';
import '../../../Design-System/colors.dart';
import '../../../Design-System/transitions.dart';
import '../../home/ui/home.dart';

class OnboardBelow extends StatefulWidget {
  const OnboardBelow({
    super.key,
  });

  @override
  State<OnboardBelow> createState() => _OnboardBelowState();
}

class _OnboardBelowState extends State<OnboardBelow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        const Text("Your Gateway to Seamless Expo Discoveries", style: TextStyle(
          color: AppTheme.mainAppColor,
          fontSize: AppFont.head3,
          fontWeight: FontWeight.w700,
          letterSpacing: -2,
          height: 1.2,
        ),),
        const SizedBox(height: 32),
        Row(
          children: [
            Bounceable(
              duration: const Duration(milliseconds: 500),
              onTap: () {
                _googleAuth(context);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffffffff),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icon/Google.png",
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8.0),

            Expanded(
              child: Hero(
                tag: 'btn',
                child: RoundedButton(
                  colour: AppTheme.btnWColor,
                  title: "Get Started",
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(createRoute(const LoginBtmBox(mode: 0,)));
                  },
                  shadow: null,
                  textColor: const Color(0xff111111),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: OnBoradBTM(),
        ),
      ],
    );
  }

  void _googleAuth(BuildContext context) {
    final ap = Provider.of<CustomAuthProvider>(context, listen: false);

    ap.signInWithGoogle(
      context: context,
      onSuccess: () {
        // if (!settingsModel.isFirstTimeUser) {
        //   settingsModel.markFirstTimeUser(); // Set isFirstTimeUser to true
        // }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
        );
      },
    );
  }
}

class OnBoradBTM extends StatelessWidget {
  const OnBoradBTM({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: AppFont.body,
            fontWeight: FontWeight.w500,
            color: AppTheme.mainAppColor,
          ),
        ),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          child: const Text(
            'Sign-In',
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: AppFont.body,
              fontWeight: FontWeight.w700,
              color: Color(0xffF3F3F3),
            ),
          ),
          onPressed: () {
            // Navigator.of(context)
            //     .push(createRoute(const LoginBtmBox(mode: 1,)));
          },
        ),
      ],
    );
  }
}