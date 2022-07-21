import 'package:flutter/material.dart';
import 'package:league_tracker/views/search_bar.dart';
import 'package:league_tracker/models/model.dart';
import 'package:league_tracker/animated_shimmer/shimmer.dart';
import 'package:league_tracker/views/summoner_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
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
      linearGradient: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? shimmerGradientDark
          : shimmerGradientLight,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            SearchBar(model: _model),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _model.isLoading,
              builder: (BuildContext context, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: SummonerCard(model: _model,),
                );
              },),
          ],
        ),
      ),
    );
  }
}
