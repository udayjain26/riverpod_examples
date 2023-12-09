import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
}

StateNotifierProvider<Counter, int?> counterProvider =
    StateNotifierProvider((ref) => Counter());

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

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final counter = ref.watch(counterProvider);
            final text =
                counter == null ? 'Press the button' : counter.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: ref.read(counterProvider.notifier).increment,
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
