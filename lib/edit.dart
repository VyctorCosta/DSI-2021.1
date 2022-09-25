import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/repository.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  String newWord = '';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Repository state = arguments['suggestions'];
    final int? index = arguments['index'];
    final String? type = arguments['type'];

    return Scaffold(
        appBar: AppBar(
          title: type == null
              ? Text('Edit the word "${state.index(index!).asPascalCase}"')
              : const Text('Add a new word'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You need to type some name';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() {
                      newWord = value;
                    }),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: type == null
                            ? 'Enter the new Word'
                            : 'Enter a word to add',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DocumentReference<Map<String, dynamic>>? res;
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore db = FirebaseFirestore.instance;
                      if (type == null) {
                        await db
                            .collection('Words')
                            .doc(state.index(index!).id)
                            .set({'text': newWord, 'textPascalCase': newWord});
                      } else {
                        res = await db
                            .collection('Words')
                            .add({'text': newWord, 'textPascalCase': newWord});
                      }

                      setState(() {
                        if (type == null) {
                          state.changeWordByIndex(newWord, index!);
                        } else {
                          state.addWord(newWord, res!.id);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: type == null
                      ? Text(
                          'Edit ${state.index(index!).asPascalCase} to $newWord')
                      : Text('Add $newWord'),
                )
              ],
            ),
          ),
        ));
  }
}
