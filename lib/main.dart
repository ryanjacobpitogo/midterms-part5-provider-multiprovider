import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Container(
      height: 100,
      color: Colors.yellow,
      child: Text(seconds.value),
    );
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Container(
      height: 100,
      color: Colors.blue,
      child: Text(minutes.value),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider.value(
            value: Stream<Seconds>.periodic(
              const Duration(seconds: 1),
              (_) => Seconds(),
            ),
            initialData: Seconds(),
          ),
          StreamProvider.value(
            value: Stream<Minutes>.periodic(
              const Duration(minutes: 1),
              (_) => Minutes(),
            ),
            initialData: Minutes(),
          ),
        ],
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: SecondsWidget(),
                ),
                Expanded(
                  child: MinutesWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
