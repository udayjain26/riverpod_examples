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

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Edith',
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final namesProvider = FutureProvider((ref) async {
  final a = await ref.watch(tickerProvider.future);
  return names.getRange(0, a);
});

// final namesProvider = StreamProvider((ref) {
//   final a = ref.watch(tickerProvider);
//   return a.map((event) => names.getRange(0, event));
// });

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: names.when(
        data: (names) => ListView(
          children: [
            for (final name in names) Text(name),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => const Center(
          child: Text('Reached End'),
        ),
      ),
    );
  }
}
