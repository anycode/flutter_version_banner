import 'package:flutter/material.dart';
import 'package:ac_version_banner/ac_version_banner.dart';

void main() {
  bool isDevVersion = true;
  runApp(MyApp(isDevVersion));
}

class MyApp extends StatelessWidget {
  final bool isDevVersion;

  const MyApp(this.isDevVersion, {super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Version Banner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );

    return VersionBanner(
      packageExtensions: const ["example"],
      text: 'dev',
      // uncomment if want to use contains (default)
      //extensionMatching: VersionBannerExtensionMatching.contains,
      // uncomment if want to use suffix
      //extensionMatching: VersionBannerExtensionMatching.endsWith,
      child: materialApp,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
