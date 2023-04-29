import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  String address = 'add adress here';
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    const color2 = Color.fromARGB(182, 0, 0, 0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Delivery to'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.green),
            ),
            Text(
              _addressController.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _showAddressDialog();
            },
            child: const Text(
              'Change',
              style: TextStyle(color: Colors.green),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: color2,
        selectedItemColor: Colors.green,
        unselectedLabelStyle: const TextStyle(
          color: color2,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: const TextStyle(
          color: Colors.green,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Mix it',
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            label: 'Your Bag',
            icon: Icon(Icons.shopping_bag_rounded),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController newAddressController =
            TextEditingController(text: address);
        const inputDecoration = InputDecoration(
              labelText: "New Address",
              hintText: "Apartment No., Building Name, Area, City, Country",
            );
        return AlertDialog(
          title: const Text("Change Address"),
          content: TextFormField(
            controller: newAddressController,
            decoration: inputDecoration,
            onSaved: (value) {
              setState(() {
                newAddressController.text = value!;
              });
            },
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  address = newAddressController.text;
                  _addressController.text = address;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
