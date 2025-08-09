import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles.dart';
import '../sudoku_game_screen.dart';

class AlertExit extends StatelessWidget {
  const AlertExit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.secondaryBackgroundColor,
      title: Text(
        'Exit Game',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      content: Text(
        'Are you sure you want to exit the game ?',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            if (SudokuGameState.isDesktop) {
              exit(0);
            } else if (SudokuGameState.platform == 'android') {
              SystemNavigator.pop();
            }
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
