import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:league_tracker/views/main_view.dart';
import 'package:league_tracker/models/model.dart';
import 'package:league_tracker/animated_shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData lightBase = ThemeData.light();
    final ThemeData darkBase = ThemeData.dark();

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: 'League Tracker',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            //primarySwatch: Colors.green,
            colorScheme: lightDynamic ?? lightBase.colorScheme,
            //colorSchemeSeed: lightDynamic?.primary ?? Colors.green,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            //primarySwatch: Colors.green,
            //colorSchemeSeed: darkDynamic?.primary ?? Colors.green,
            colorScheme: darkDynamic ?? darkBase.colorScheme,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.system,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Model _model = Model();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  String _title = "League Tracker";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _model.isLoading = isLoading;

    return Shimmer(
      linearGradient:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? shimmerGradientDark
              : shimmerGradientLight,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            TextButton(
              onPressed: () {
                _model.showSearchBar.value = !_model.showSearchBar.value;
              },
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => MainView(
            model: _model,
            constraints: constraints,
          ),
        ),
      ),
    );
  }
}
