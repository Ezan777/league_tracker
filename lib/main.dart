import 'package:flutter/material.dart';
import 'package:league_tracker/views/search_bar.dart';
import 'package:league_tracker/models/model.dart';
import 'package:league_tracker/animated_shimmer/shimmer.dart';
import 'package:league_tracker/animated_shimmer/shimmer_loading.dart';
import 'package:league_tracker/views/summoner_info_view.dart';

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

  final _shimmerGradientLight = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  final _shimmerGradientDark = const LinearGradient(
    colors: [
      Color(0xFF6C6C72),
      Color(0xFF8F8C8C),
      Color(0xFF949498),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

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
              ? widget._shimmerGradientDark
              : widget._shimmerGradientLight,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            SearchBar(model: _model),
            const SizedBox(height: 22),
            Container(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              width: MediaQuery.of(context).size.width,
              height: 1,
            ),
            AnimatedBuilder(
                animation: _model.isLoading,
                builder: (BuildContext context, Widget? child) {
                  return ShimmerLoading(
                    isLoading: _model.isLoading,
                    child: SummonerInfo(
                      isLoading: _model.isLoading,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
