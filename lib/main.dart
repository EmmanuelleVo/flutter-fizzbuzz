import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RangeValues _currentRangeValues = const RangeValues(1, 100);
  late int min;
  late int max;
  // quand on va changer les propriétés d'une classe (min, max) -> slider -> setState()

  @override //Cmd N : override method
  void initState() { // va être appelée quand on va dessiner le widget
    super.initState(); // appel du constructeur parent
    min = _currentRangeValues.start.round();
    max = _currentRangeValues.end.round();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fizzbuzz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_rounded),
            tooltip: 'Open shopping cart',
            onPressed: () {
              print('Hello');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          // objet qui prend tout l'espace restant (vertical) | SizedBox(width/height)
          Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.all(15),
            elevation: 10,
            // comme box-shadow par défaut
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    'Choisissez un interval',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 1,
                    max: 100,
                    divisions: 100,
                    // par défaut max
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        min =_currentRangeValues.start.round();
                        max = _currentRangeValues.end.round();
                      });
                    },
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(min.toString()),
                      const Spacer(
                        flex: 5,
                      ),
                      Text(max.toString()),
                      const Spacer(),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Voici le FizzBuzz de 1 à 100'),
                          content: Text(fizzBuzz(min, max)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Réessayer'),
                              child: const Text('Réessayer'),
                            ),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.format_list_numbered),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Afficher les résultats',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  String fizzBuzz(int min, int max) {
    String fizzbuzz = '';

    for(int i = min; i <= max; i++){

      if(i%5==0 && i%3==0) {
        fizzbuzz += 'FizzBuzz, ';
      } else if(i%3==0) {
        fizzbuzz += 'Fizz, ';
      } else if(i%5==0) {
        fizzbuzz += 'Buzz, ';
      } else {
        fizzbuzz += i.toString() + ', ';
      }
    }

    return fizzbuzz;
  }

}
