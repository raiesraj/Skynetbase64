import 'package:catex/catex.dart';
import 'package:flutter/material.dart';

/// Example equations to test and showcase the renderer and parser.

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    final exception = details.exception;
    if (exception is CaTeXException) {
      return ErrorWidget(exception);
    }


  };
  runApp( App(key: null,));
}

/// Example app widget that uses [MaterialApp] to display CaTeX output.
class App extends StatelessWidget {
  /// Constructs the example [App].
  const App({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaTeX example',
      home:  Home(key: key)
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
    );
  }
}

/// Example home page that includes an infinite list of CaTeX example widgets
/// and a text field to test out CaTeX.
