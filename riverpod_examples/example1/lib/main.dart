import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}

final Provider<DateTime> currentDate = Provider(
  (ref) => DateTime.now(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('yeet'),
      ),
      body: Center(
        child: Text(
          date.toIso8601String(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
