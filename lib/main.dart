import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int capacity = 1;
  int price = 100;
  List<String> people = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Destination: SAMPLE', style: _headerTextStyle()),
                    Text('DATE: 01/01/20XX', style: _headerTextStyle()),
                    Text('Time: 15:00 P.M', style: _headerTextStyle()),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconButton(Icons.add, () => setState(() => capacity++)),
                    Text('$capacity (capacity)', style: _headerTextStyle()),
                    _iconButton(Icons.remove, () => setState(() {
                      if (capacity > 1) capacity--;
                    })),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconButton(Icons.add, () => setState(() => price += 50)),
                    Text('₹$price (price)', style: _headerTextStyle()),
                    _iconButton(Icons.remove, () => setState(() {
                      if (price > 50) price -= 50;
                    })),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  children: people.map((person) => _buildPersonRow(person)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen,
        child: SizedBox(height: 40),
      ),
    );
  }

  Widget _buildPersonRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(child: Icon(Icons.person), backgroundColor: Colors.grey[700]),
              SizedBox(width: 10),
              Text(name, style: _textStyle()),
            ],
          ),
          IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () => setState(() => people.remove(name)),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle() => TextStyle(color: Colors.white, fontSize: 16);

  TextStyle _headerTextStyle() => TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
