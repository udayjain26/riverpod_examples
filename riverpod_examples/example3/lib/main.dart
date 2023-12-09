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

// class Counter extends StateNotifier<int?> {
//   Counter() : super(null);
//   void increment() => state = state == null ? 1 : state + 1;
// }

// StateNotifierProvider<Counter, int?> counterProvider =
//     StateNotifierProvider((ref) => Counter());

enum City {
  stockholm,
  paris,
  tokyo,
}

typedef WeatherEmoji = String;

// Sample future fuction that returns a 'WeatherEmoji
Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () =>
          {
            City.stockholm: '❄️',
            City.paris: '🥲',
            City.tokyo: '🌪️',
          }[city] ??
          '');
}

//UI will right and read to this provider
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

const unkownWeatherEmoji = '🤷';

// UI reads this
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unkownWeatherEmoji;
  }
});

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
    final currentWeather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(data, style: const TextStyle(fontSize: 40)),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) =>
                const Text('An error occurred while retreiving the data'),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: City.values.length,
            itemBuilder: (context, index) {
              final city = City.values[index];
              final isSelected = city == ref.watch(currentCityProvider);
              return ListTile(
                title: Text(city.name),
                trailing: isSelected ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(currentCityProvider.notifier).state = city;
                },
              );
            },
          )),
          Text(
            '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
