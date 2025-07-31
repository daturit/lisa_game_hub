import '../piano_game/note.dart';
import 'dart:math';

class ConstantsHelper {
  ConstantsHelper._();
  static const backGround = 'assets/images/IMG_7894.jpg';
  static const int timeNote = 250;

  static List<Note> initNotes () {
    List<Note> listNotes = [];
    final Note note = Note(0, 5);
    listNotes.add(note);
    Random random = Random();
    for( int i = 1; i < 650; i ++) {
      int randomNumber = random.nextInt(4);
      while(listNotes[i-1].line == randomNumber) {
        randomNumber = random.nextInt(4);
      }
      final Note note = Note(i, randomNumber);
      listNotes.add(note);
    }
    return listNotes;
  }
}