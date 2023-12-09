import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

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

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      uuid: uuid,
    );
  }

  String get displayName => '$name is $age years old';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => Object.hash(name, age, uuid);

  @override
  String toString() => 'Person(name: $name, age: $age, uuid: $uuid)';
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];
  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void removePerson(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void updatePerson(Person person) {
    final index = _people.indexOf(person);
    final oldPerson = _people[index];
    if (oldPerson.name != person.name || oldPerson.age != person.age) {
      _people[index] = oldPerson.updated(person.name, person.age);
      notifyListeners();
    }
    _people[index] = person;
    notifyListeners();
  }
}

final peopleProvider = ChangeNotifierProvider(
  (_) => DataModel(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Consumer(builder: (context, ref, child) {
        final dataModel = ref.watch(peopleProvider);
        return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson =
                        await createOrUpdatePersonDialog(context, person);
                    if (updatedPerson != null) {
                      dataModel.updatePerson(updatedPerson);
                    }
                  },
                  child: Text(person.displayName),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context, null);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.addPerson(person);
          }
        },
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context,
  Person? existingPerson,
) async {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) => name = value,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                onChanged: (value) => age = int.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name != null && age != null) {
                  if (existingPerson != null) {
                    final newPerson = existingPerson.updated(name, age);
                    Navigator.of(context).pop(newPerson);
                  } else {
                    final newPerson = Person(name: name!, age: age!);
                    Navigator.of(context).pop(newPerson);
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      });
}
