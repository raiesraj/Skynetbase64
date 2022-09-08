//<a href="454b25b8a0f379bf509040f4ecb22d54b40591ee"></a>
import 'package:flutter/material.dart';
import 'package:skynetsecurity/SplashScreen/splash_screen.dart';


void main() async {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget  {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SplashScreen(),
    );
  }
}

// class Home extends StatelessWidget {
//   /// Constructs a [Home] widget.
//   Home(Key? key) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tap to toggle equations'),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.only(bottom: 16),
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return  _Highlighted(
//               key: null,
//               child: _TextFieldEquation(key: null,),
//             );
//           }
//
//           return _Highlighted(
//
//             key: null,
//             child: ToggleEquation(
//               equations[(index - 1) % equations.length], key: null,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _TextFieldEquation extends StatefulWidget {
//   const _TextFieldEquation({required Key? key}) : super(key: key);
//
//   @override
//   State createState() => _TextFieldEquationState();
// }
//
// class _TextFieldEquationState extends State<_TextFieldEquation> {
//   TextEditingController? _controller;
//
//   bool? _input;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = TextEditingController();
//     _input = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_input! ) {
//       return TextField(
//         controller: _controller,
//         autocorrect: false,
//         enableSuggestions: false,
//         onSubmitted: (_) {
//           setState(() {
//             _input = false;
//           });
//         },
//       );
//     }
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _input = true;
//         });
//       },
//       child: CaTeX(_controller?.text),
//     );
//   }
// }
//
// class ToggleEquation extends StatefulWidget {
//   const ToggleEquation(this.equation, {required Key? key}) : super(key: key);
//
//   final String equation;
//
//   @override
//   State createState() => _ToggleEquationState();
// }
//
// class _ToggleEquationState extends State<ToggleEquation> {
//   bool ? _showSource;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _showSource = false;
//   }
//
//   Widget buildEquation(BuildContext context) {
//     if (_showSource!) {
//       return Text(
//         widget.equation,
//         // ignore: deprecated_member_use
//        // style: Theme.of(context).textTheme.subhead,
//         textAlign: TextAlign.center,
//       );
//     }
//
//     return CaTeX(widget.equation);
//   }
//
//   void _toggle() {
//     setState(() {
//       _showSource = !_showSource!;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: _toggle,
//       child: buildEquation(context),
//     );
//   }
// }
//
// class _Highlighted extends StatelessWidget {
//    _Highlighted({required Key ? key, required this.child}) : super(key: key);
//
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Card(
//         color: Colors.grey[800],
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: DefaultTextStyle.merge(
//             style: const TextStyle(
//               fontSize: 24,
//             ),
//             child: Center(
//               child: child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//<a href="454b25b8a0f379bf509040f4ecb22d54b40591ee"></a>