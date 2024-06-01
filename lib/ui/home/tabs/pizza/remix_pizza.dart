import 'package:flutter/material.dart';
import 'package:pizzaslice/data/dummy_data.dart';
import 'dart:math';

class RemixPizza extends StatefulWidget {
  const RemixPizza({super.key});

  @override
  State<RemixPizza> createState() => _RemixPizzaState();
}

class _RemixPizzaState extends State<RemixPizza> {
  late PageController page1Controller;
  int page1CurrentIndex = 0;
  double page1PageValue = 0.0;

  late PageController page2Controller;
  int page2CurrentIndex = 0;
  double page2PageValue = 0.0;

  bool isPressed = true;

  BoxDecoration boxDecorationText() {
    return BoxDecoration(
        boxShadow: const [
          BoxShadow(offset: Offset(5, 8), color: Colors.orange)
        ],
        backgroundBlendMode: BlendMode.difference,
        color: Colors.teal.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20));
  }

  //BoxDecoration func for appbar and pizza name with same index for both pizza
  BoxDecoration boxDecorationAppBar() {
    return BoxDecoration(
        boxShadow: const [
          BoxShadow(offset: Offset(10, 15), color: Colors.orange)
        ],
        backgroundBlendMode: BlendMode.difference,
        color: Colors.teal.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page1Controller =
        PageController(initialPage: page1CurrentIndex, viewportFraction: 0.35)
          ..addListener(() {
            setState(() {
              page1PageValue = page1Controller.page ?? 0.0;
            });
          });

    page2Controller =
        PageController(initialPage: page2CurrentIndex, viewportFraction: 0.35)
          ..addListener(() {
            setState(() {
              page2PageValue = page2Controller.page ?? 0.0;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SafeArea(
        child: Stack(
          children: [
            // Container with arrow back icon and text Remix Pizza
            Positioned(
              left: 10,
              right: 10,
              child: Container(
                height: h * 0.08,
                width: w,
                decoration: boxDecorationAppBar(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                    Text(
                      'Choose Your Pizza',
                      textScaler: TextScaler.linear(1.5),
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    Text('    '),
                  ],
                ),
              ),
            ),
            //2 page view builder with direction in vertical axis  showing images of pizza
            Positioned(
                top: h * 0.05,
                bottom: h * 0.01,
                child: SizedBox(
                  width: w,
                  child: Row(children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (value) {
                          page1CurrentIndex = value;
                        },
                        controller: page1Controller,
                        scrollDirection: Axis.vertical,
                        itemCount: allRemixAblePizzas.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 0,
                            ),
                            curve: Curves.easeInOut,
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: index == page1CurrentIndex
                                  ? 1 - (page1PageValue - index).abs()
                                  : 0.4,
                              child: Stack(children: [
                                AnimatedPositioned(
                                  right: -195,
                                  top: 0,
                                  left: 0,
                                  bottom: 0,
                                  duration: const Duration(milliseconds: 150),
                                  child: AnimatedPadding(
                                    duration: const Duration(milliseconds: 100),
                                    padding: index == page1CurrentIndex
                                        ? EdgeInsets.zero
                                        : index > page1CurrentIndex
                                            ? const EdgeInsets.only(
                                                left: 0, bottom: 70, top: 40)
                                            : const EdgeInsets.only(
                                                left: 0, bottom: 40, top: 70),
                                    child: Image.asset(
                                        allRemixAblePizzas[index].image),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (value) {
                          page2CurrentIndex = value;
                        },
                        controller: page2Controller,
                        scrollDirection: Axis.vertical,
                        itemCount: allRemixAblePizzas.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 0,
                            ),
                            curve: Curves.easeInOut,
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: index == page2CurrentIndex
                                  ? 1 - (page2PageValue - index).abs()
                                  : 0.4,
                              child: Stack(children: [
                                AnimatedPositioned(
                                  right: 0,
                                  top: 0,
                                  left: -195,
                                  bottom: 0,
                                  duration: const Duration(milliseconds: 150),
                                  child: AnimatedPadding(
                                    duration: const Duration(milliseconds: 100),
                                    padding: index == page2CurrentIndex
                                        ? EdgeInsets.zero
                                        : index > page2CurrentIndex
                                            ? const EdgeInsets.only(
                                                left: 0, bottom: 70, top: 40)
                                            : const EdgeInsets.only(
                                                left: 0, bottom: 40, top: 70),
                                    child: Image.asset(
                                        allRemixAblePizzas[index].image),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                )),
            // Text {Name} Pizza and price for types of pizza
            Positioned(
                height: h * 0.24,
                top: 140,
                width: w,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 0),
                  switchInCurve: Curves.bounceIn,
                  child: page1CurrentIndex == page2CurrentIndex
                      ? Container(
                          width: w * 0.5,
                          height: h * 0.05,
                          decoration: boxDecorationAppBar(),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${allRemixAblePizzas[page1CurrentIndex].name} Pizza',
                            textScaler: const TextScaler.linear(1.5),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        )
                      : Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: boxDecorationText(),
                                      child: Text(
                                        allRemixAblePizzas[page1CurrentIndex]
                                            .name,
                                        textScaler:
                                            const TextScaler.linear(1.5),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${allRemixAblePizzas[page1CurrentIndex].halfPrice} \$",
                                      textScaler: const TextScaler.linear(1.5),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9)),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: boxDecorationText(),
                                      child: Text(
                                        allRemixAblePizzas[page2CurrentIndex]
                                            .name,
                                        textScaler:
                                            const TextScaler.linear(1.5),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${allRemixAblePizzas[page2CurrentIndex].halfPrice} \$",
                                      textScaler: const TextScaler.linear(1.5),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9)),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                )),
            Positioned(
                bottom: 10,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Let\'s Gamble!',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                          final randomNumber1 =
                              Random().nextInt(allRemixAblePizzas.length);
                          final randomNumber2 =
                              Random().nextInt(allRemixAblePizzas.length);
                          page1Controller.animateToPage(randomNumber1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linearToEaseOut);
                          page2Controller.animateToPage(randomNumber2,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linearToEaseOut);
                        });
                      },
                      child: ClipOval(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.bounceInOut,
                          width: isPressed ? 70 : 90,
                          height: isPressed ? 70 : 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: isPressed
                                ? const AssetImage(
                                    'assets/other_icons/dice.png')
                                : AssetImage(
                                    'assets/images/pizzas/${Random().nextInt(allRemixAblePizzas.length) + 1}.png'),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: boxDecorationText(),
                          child: Text(
                            page1CurrentIndex == page2CurrentIndex
                                ? '${allRemixAblePizzas[page1CurrentIndex].fullPrice} \$'
                                : '${allRemixAblePizzas[page1CurrentIndex].halfPrice + allRemixAblePizzas[page2CurrentIndex].halfPrice} \$',
                            textScaler: const TextScaler.linear(1.5),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: w * 0.7,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.shopping_basket,
                                  color: Colors.teal, fill: 0),
                              label: const Text(
                                'Add To Cart',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
