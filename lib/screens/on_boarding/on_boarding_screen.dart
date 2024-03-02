import 'package:ekyc/screens/on_boarding/widgets/custom_on_boarding_body.dart';
import 'package:ekyc/screens/on_boarding/widgets/get_button.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              CustomOnBoardingBody(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              GetButton(controller: controller, currentIndex: currentIndex),
            ],
          ),
        ),
      ),
    );
  }
}
