class Word {
  String? _text;
  String? _textPascalCase;
  String? _newText;

  Word({required String text, required String textPascal }) {
    _text = text;
    _textPascalCase = textPascal;
  }

  String get text {
    if (_newText == null) return _text!;
    return _newText!;
  }

  String get asPascalCase {
    if (_newText == null) return _textPascalCase!;
    return _newText!;
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