import 'package:flutter/material.dart';
import 'pizza.dart'; // Import the Pizza class from pizza.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Pizza> pizzasInOrder = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Order App',
      home: MyHomePage(
        title: 'Pizza Order',
        pizzasInOrder: pizzasInOrder,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.pizzasInOrder})
      : super(key: key);
  final String title;
  final List<Pizza> pizzasInOrder;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addPizza(String toppings, String size) {
    setState(() {
      final pizza = Pizza(toppings: toppings, size: size);
      widget.pizzasInOrder.add(pizza);
    });
    Navigator.pop(context); // Close the dialog
  }

  Future<void> _showAddPizzaDialog() async {
    String toppings = "";
    String selectedSize = "Small"; // Initialize with a default size

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    toppings = value;
                  },
                  decoration: InputDecoration(labelText: 'Toppings'),
                ),
                DropdownButton<String>(
                  value: selectedSize,
                  items: ["Small", "Medium", "Large", "X-Large"].map((String size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSize = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _addPizza(toppings, selectedSize);
                  },
                  child: Text('Add Pizza'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: widget.pizzasInOrder.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text('Toppings: ${widget.pizzasInOrder[index].toppings}'),
              subtitle: Text('Size: ${widget.pizzasInOrder[index].size}, Price: \$${widget.pizzasInOrder[index].getPrice().toStringAsFixed(2)}'),
              // ...
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPizzaDialog,
        tooltip: 'Add Pizza',
        child: Icon(Icons.add),
      ),
    );
  }
}
