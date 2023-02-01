import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skincare_ui/screens/processing.dart';
import 'package:skincare_ui/screens/steps/step1.dart';
import 'package:skincare_ui/screens/steps/step2.dart';
import 'package:skincare_ui/screens/steps/step3.dart';

class StepView extends StatefulWidget {
  const StepView({Key? key}) : super(key: key);

  @override
  State<StepView> createState() => _StepViewState();
}

class _StepViewState extends State<StepView> with TickerProviderStateMixin {
  late AnimationController _animationController, animationController;
  late Animation _opacityAnimation;
  final PageController _pageController = PageController(initialPage: 0);

  List subTitle = [
    'Do you have uneven skin pigmentation and dark spots on your facial skin today?',
    'How does your skin feel after you wash your face?',
    'How does your skin look and feel at the end of the day?'
  ];

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    //_opacityAnimation =Tween<double>(begin: 0, end: 1).animate(animationController);

    //_animationController.forward();
    animationController.forward(from: 0.3);
  }

  @override
  void dispose() {
    animationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List pages = const [Step1(), Step2(), Step3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffA5A738),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1500),
                    child: UnconstrainedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child!);
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 40),
            child: Stack(
              children: [
                Text(
                  'STEP ${pageIndex + 1}',
                  style: const TextStyle(fontFamily: 'helvetica', fontSize: 70),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(-8 / 360),
                      child: SizedBox(
                          height: 100,
                          width: 235,
                          child: Lottie.asset('assets/json/oval.json',
                              controller: _animationController,
                              onLoaded: (composition) {
                            // Configure the AnimationController with the duration of the
                            // Lottie file and start the animation.
                            _animationController
                              ..duration = composition.duration
                              ..forward();

                            _animationController.addListener(() {
                              if (_animationController.value > 0.55) {
                                _animationController.stop();
                              }
                            });
                          }, fit: BoxFit.fill)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: AnimatedBuilder(
                animation: animationController,
                builder: (_, __) {
                  return AnimatedOpacity(
                    opacity: animationController.value,
                    duration: const Duration(milliseconds: 500),
                    child: Transform.scale(
                      scale: animationController.value,
                      child: Text(
                        subTitle[pageIndex],
                        style: const TextStyle(
                            fontFamily: 'helvetica',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) => pages[index]))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 70,
                      width: 140,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {
                            if (pageIndex != 0) {
                              setState(() {
                                pageIndex -= 1;
                              });

                              _pageController.animateToPage(pageIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear);

                              _animationController.reverse(from: 0.55).then(
                                  (value) =>
                                      _animationController.forward(from: 0.0));

                              animationController.forward(from: 0.3);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                    fontFamily: 'helvetica',
                                    color: Colors.black),
                              )
                            ],
                          ))),
                  SizedBox(
                      height: 70,
                      width: 140,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {
                            if (pageIndex != 2) {
                              setState(() {
                                pageIndex += 1;
                              });

                              _pageController.animateToPage(pageIndex,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear);

                              _animationController.reverse(from: 0.55).then(
                                  (value) =>
                                      _animationController.forward(from: 0.0));

                              animationController.forward(from: 0.3);
                            } else {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const ProcessingScreen(),
                                      type: PageTransitionType.fade));
                            }

                            // _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(animationController);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(
                                    fontFamily: 'helvetica',
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
