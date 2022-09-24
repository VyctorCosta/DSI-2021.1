import 'package:first_app/word.dart';
import "package:english_words/english_words.dart";

class Repository {
  final List<Word> _list = [];

  Repository() {
    for (int i = 0; i < 20; i++) {
      final word = generateWordPairs().take(1).first;
      _list.add(Word(
          text: word.toString(), textPascal: word.asPascalCase.toString()));
    }
  }

  List<Word> get list {
    return _list;
  }

  int get length {
    return _list.length;
  }

  index(int index) {
    return _list[index];
  }

  remove(int index) {
    _list.removeAt(index);
  }

  changeWordByIndex(String newString, int index) {
    _list[index].changeWord(newString);
  }
}
