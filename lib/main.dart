// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:first_app/edit.dart';
import 'package:first_app/repository.dart';
import 'package:first_app/word.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      )),
      routes: {
        '/': (context) => const RandomWords(),
        '/edit': (context) => const EditPage(),
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final Repository _suggestions = Repository();
  final _saved = <Word>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  bool _isCardMode = false;

  @override
  void initState() {
    super.initState();
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Suggestions"),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Startup Name Generator"),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: "Saved Suggestions",
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: SwitchListTile(
                      title: const Text(
                        'Change Visualization',
                        textAlign: TextAlign.center,
                      ),
                      value: _isCardMode,
                      onChanged: (_) {
                        setState(() {
                          _isCardMode = !_isCardMode;
                        });
                      }),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit', arguments: {
                        'type': 'add',
                        'suggestions': _suggestions
                      }).then((_) => setState((() {})));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 34,
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _isCardMode
                  ? GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _suggestions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 80,
                              mainAxisSpacing: 40),
                      itemBuilder: (context, i) {
                        if (i >= _suggestions.length) return const Text('');

                        final alreadySaved =
                            _saved.contains(_suggestions.index(i));

                        return InkResponse(
                          onTap: () {
                            Navigator.pushNamed(context, '/edit', arguments: {
                              'index': i,
                              'suggestions': _suggestions
                            }).then((_) => setState((() {})));
                          },
                          child: GridTile(
                            footer: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      alreadySaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: alreadySaved ? Colors.red : null,
                                      semanticLabel: alreadySaved
                                          ? "Removed from saved"
                                          : "Save",
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (alreadySaved) {
                                          _saved.remove(_suggestions.index(i));
                                        } else {
                                          _saved.add(_suggestions.index(i));
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(CupertinoIcons.delete),
                                    onPressed: () {
                                      setState(() {
                                        if (alreadySaved) {
                                          _saved.remove(_suggestions.index(i));
                                        }
                                        _suggestions.remove(i);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            child: Text(
                              _suggestions.index(i).asPascalCase,
                              style: _biggerFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _suggestions.length * 2,
                      itemBuilder: (context, i) {
                        if (i.isOdd) return const Divider();

                        final index = i ~/ 2;

                        if (index >= _suggestions.length) return const Text('');

                        final alreadySaved =
                            _saved.contains(_suggestions.index(index));

                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/edit', arguments: {
                              'index': index,
                              'suggestions': _suggestions
                            }).then((_) => setState((() {})));
                          },
                          title: Text(
                            _suggestions.index(index).asPascalCase,
                            style: _biggerFont,
                          ),
                          trailing: Wrap(
                            spacing: 20,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  alreadySaved
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: alreadySaved ? Colors.red : null,
                                  semanticLabel: alreadySaved
                                      ? "Removed from saved"
                                      : "Save",
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (alreadySaved) {
                                      _saved.remove(_suggestions.index(index));
                                    } else {
                                      _saved.add(_suggestions.index(index));
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  setState(() {
                                    if (alreadySaved) {
                                      _saved.remove(_suggestions.index(index));
                                    }
                                    _suggestions.remove(index);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ));
  }
}
