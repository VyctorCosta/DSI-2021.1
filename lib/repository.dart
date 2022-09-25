import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/word.dart';
import "package:english_words/english_words.dart";

class Repository {
  final List<Word> _list = [];

  Repository(List<Map<String, dynamic>> list) {
    for (var data in list) {
      _list.add(Word(text: data['text'], textPascal: data['textPascalCase'], id: data['id']));
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

  addWord(String word, String id) {
    _list.add(Word(text: word, textPascal: word, id: id));
  }
}
