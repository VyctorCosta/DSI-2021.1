class Word {
  String? _text;
  String? _textPascalCase;
  String? _newText;
  String? _id;

  Word({required String text, required String textPascal, required String id }) {
    _text = text;
    _textPascalCase = textPascal;
    _id = id;
  }

  String get text {
    if (_newText == null) return _text!;
    return _newText!;
  }

  String get asPascalCase {
    if (_newText == null) return _textPascalCase!;
    return _newText!;
  }

  String get id {
    return _id!;
  }

  set text(String newText) {
    _newText = newText;
  }

  changeWord(String newString) {
    if (_newText != null) {
      _text = _newText;
      _textPascalCase = _newText;
    }
    _newText = newString;
  }
}