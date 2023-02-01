import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skincare_ui/screens/stepview.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool show = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
    );
    super.initState();

    Future.delayed(const Duration(milliseconds: 6150), () {
      // <-- Delay here
      setState(() {
        show = true;
      }); // <-- Code run after delay
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: .6),
                duration: const Duration(seconds: 3),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage('assets/images/background_img.jpg'))),
                ),
                builder: (context, value, child) {
                  return Transform.scale(scale: .4 + value, child: child!);
                }),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1, end: 0),
                  duration: const Duration(seconds: 3),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'SKINCARE IS HEALTHCARE',
                      style: TextStyle(
                        fontFamily: 'helvetica',
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  builder: (context, value, child) {
                    return Transform.translate(
                        offset: Offset(value * 100, 0), child: child!);
                  }),
              TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1, end: 0),
                  duration: const Duration(seconds: 3),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      width: 240,
                      child: Text(
                        'Take the test and the app will select the perfect care for your skin',
                        style: TextStyle(
                            fontFamily: 'helvetica',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  builder: (context, value, child) {
                    return Transform.translate(
                        offset: Offset(0.0, value * -100),
                        child: AnimatedOpacity(
                            opacity: (value - 1) * -1,
                            duration: const Duration(seconds: 1),
                            child: child!));
                  }),
              const SizedBox(
                height: 170,
              )
            ],
          ),
          Positioned(
              top: 10,
              left: 15,
              child: SafeArea(
                child: SizedBox(
                    width: 180,
                    child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(seconds: 3),
                        child: const Text(
                          'WE POSES OURSELF AS ECOFRIENDLY BRAND WHICH HELPS PEOPLE TO FEEL THEIR SKIN',
                          style: TextStyle(
                              fontFamily: 'helvetica',
                              color: Colors.white,
                              fontSize: 15),
                        ),
                        builder: (context, value, child) {
                          return AnimatedOpacity(
                              duration: const Duration(microseconds: 500),
                              opacity: value,
                              child: child!);
                        })),
              )),
          Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: .3, end: 1),
                    duration: const Duration(seconds: 3),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: const Duration(seconds: 1),
                                    reverseDuration: const Duration(seconds: 1),
                                    child: const StepView(),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: const Text(
                            'Try now',
                            style: TextStyle(
                                fontFamily: 'helvetica',
                                color: Colors.black,
                                fontSize: 16),
                          )),
                    ),
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child!);
                    }),
              )),
          Positioned(
              bottom: 300,
              left: 15,
              child: show
                  ? RotationTransition(
                      turns: const AlwaysStoppedAnimation(8 / 360),
                      child: SizedBox(
                          height: 100,
                          width: 255,
                          child: Lottie.asset('assets/json/oval_white.json',
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
                    )
                  : const SizedBox()),
        ],
      ),
    );
  }
}
