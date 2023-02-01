import 'package:flutter/material.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({Key? key}) : super(key: key);

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353535),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
              tween: Tween(begin: .5, end: 1),
              duration: const Duration(milliseconds: 1000),
              child: const SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  color: Color(0xffA5A738),
                  strokeWidth: 5,
                ),
              ),
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child!);
              }),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              child: Text(
                'We select a product specifically for your skin',
                style: TextStyle(
                    fontFamily: 'helvetica', fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
