import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings.dart';

class Tile extends StatefulWidget {
  final int _value;

  int get value {
    return _value;
  }

  const Tile(
    this._value, {
    super.key,
  });

  @override
  State<Tile> createState() => _TileState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return _value.toString();
  }
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    int baseNum = Provider.of<GameSetting>(context).baseNum;

    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: double.infinity,
      decoration: getTileDecoration(context, widget._value, baseNum: baseNum),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            widget._value == 0 ? " " : "${widget._value}",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}

BoxDecoration getTileDecoration(context, int value, {int baseNum = 2}) {
  const double raduis = 15;

  if (value == 0) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: Theme.of(context).colorScheme.background,
    );
  } else if (value == baseNum) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: Theme.of(context).colorScheme.background,
      image: const DecorationImage(
          image: AssetImage("assets/image2048/2.png"), fit: BoxFit.contain),
    );
  } else if (value == baseNum * (pow(2, 1))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 121, 121, 121),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/4.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 2))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 167, 137, 137),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/8.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 3))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 207, 212, 182),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/16.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 4))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 190, 190, 154),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/32.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 5))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 175, 211, 212),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/64.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 6))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 182, 231, 233),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/128.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 7))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 236, 191, 191),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/256.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 8))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: const Color.fromARGB(255, 255, 159, 159),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/512.png"), fit: BoxFit.contain));
  } else if (value == baseNum * (pow(2, 9))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(220, 220, 220, 1),
          Color.fromRGBO(240, 240, 240, 1),
          Color.fromRGBO(192, 192, 192, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(220, 220, 220, 0.7),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 10))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        image: const DecorationImage(
            image: AssetImage("assets/image2048/1024.png"), fit: BoxFit.contain),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 11))) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(220, 220, 220, 0.7),
            spreadRadius: 3)
      ],
    );
  } else if (value == baseNum * (pow(2, 12))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else if (value == baseNum * (pow(2, 13))) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
        Color.fromRGBO(220, 220, 220, 1),
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(192, 192, 192, 1),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(220, 220, 220, 0.7),
            spreadRadius: 3)
      ],
    );
  } else if (value == baseNum * (pow(2, 14))) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1),
          Color.fromRGBO(255, 230, 150, 1),
          Color.fromRGBO(255, 230, 200, 1),
          Color.fromRGBO(255, 215, 0, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(255, 215, 0, 1),
              spreadRadius: 3)
        ]);
  } else {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        boxShadow: const [
          BoxShadow(blurRadius: 7, color: Colors.white, spreadRadius: 7)
        ]);
  }
}
