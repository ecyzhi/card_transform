import 'dart:math' as math;

import 'package:card_transform/models/card_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);
  late List<CardAnimation> bigCardAnimations = [
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: -20,
        x: -150,
        y: 30),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: -10,
        x: -50,
        y: 10),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: 10,
        x: 50,
        y: 10),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: 20,
        x: 150,
        y: 30),
  ];

  late List<CardAnimation> smallCardAnimations = [
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: -45,
        x: -200,
        y: -220),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: -70,
        x: -280,
        y: 150),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: 80,
        x: 200,
        y: -240),
    CardAnimation.fromDefault(
        AnimationController(duration: duration, vsync: this),
        deg: 10,
        x: 290,
        y: 110),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ...smallCardAnimations
              .map((e) => AnimatedCard(
                    card: e,
                    cardList: [
                      ...bigCardAnimations,
                      ...smallCardAnimations,
                    ],
                    isBig: false,
                  ))
              .toList(),
          ...bigCardAnimations
              .map((e) => AnimatedCard(
                    card: e,
                    cardList: [
                      ...bigCardAnimations,
                      ...smallCardAnimations,
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    super.key,
    required this.card,
    required this.cardList,
    this.isBig = true,
  });
  final CardAnimation card;
  final List<CardAnimation> cardList;
  final bool isBig;
  final double height = 350;
  final double width = 250;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: card.controller,
        builder: (context, child) => Transform.translate(
          offset: card.translation.value,
          child: Transform.rotate(
            angle: card.rotation.value,
            child: InkWell(
              radius: 20,
              borderRadius: BorderRadius.circular(20),
              hoverColor: Colors.green,
              onTap: () {},
              onHover: (value) {
                if (value) {
                  cardList.forEach(CardAnimation.forward);
                } else {
                  cardList.forEach(CardAnimation.reverse);
                }
              },
              child: Container(
                height: isBig ? height : height / 2,
                width: isBig ? width : width / 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.6), width: 5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
