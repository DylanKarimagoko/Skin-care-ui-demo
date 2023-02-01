import 'package:flutter/material.dart';

class Step1 extends StatefulWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> with AutomaticKeepAliveClientMixin {
  List items = [
    'My skin pigment is even AND I have no dark spots or darker areas',
    'My skin pigment is uneven AND I want to lighten darker areas',
    'I have freckles or dark spots AND I do not want to remove',
    'I have freckles or dark spots AND I want to remove it',
  ];

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 2000 + (index * 100)),
                tween: Tween(begin: 1, end: 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 90,
                            child: Row(children: [
                              Text(
                                '${index + 1}',
                                style: const TextStyle(
                                    fontFamily: 'helvetica', fontSize: 55),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                  width: 280,
                                  child: Text(
                                    items[index],
                                    style: const TextStyle(
                                        fontFamily: 'helvetica', fontSize: 17),
                                  ))
                            ]),
                          ),
                          AnimatedContainer(
                            color: const Color(0xffA5A738).withOpacity(.3),
                            duration: const Duration(milliseconds: 500),
                            height: 90,
                            width: index == selectedIndex
                                ? MediaQuery.of(context).size.width
                                : 0,
                          )
                        ],
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  ),
                ),
                builder: (context, value, child) {
                  return Transform.translate(
                      offset: Offset((value * 1000 * index), 0), child: child!);
                })),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
