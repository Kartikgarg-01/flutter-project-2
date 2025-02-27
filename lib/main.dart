import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}
class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashcardHome(),
    );
  }
}

class FlashcardHome extends StatefulWidget {
  @override
  _FlashcardHomeState createState() => _FlashcardHomeState();
}

class _FlashcardHomeState extends State<FlashcardHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'FLASHCARD',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'GloriaHallelujah',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: _selectedIndex == 0 ? FlashcardPractice() : FlashcardGrid(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'CARDS',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'PRACTICE',
          ),
        ],
      ),
    );
  }
}

class FlashcardGrid extends StatelessWidget {
  final List<Map<String, String>> flashcards = [
    {'question': 'Question', 'answer': 'Answer'},
    {'question': 'Question', 'answer': 'Answer'},
    {'question': 'Question', 'answer': 'Answer'},
    {'question': 'Question', 'answer': 'Answer'},
    {'question': 'Question', 'answer': 'Answer'},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: flashcards.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.purple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(flashcards[index]['question']!,
                            style: TextStyle(fontSize: 20, color: Colors.black)),
                        Text(flashcards[index]['answer']!,
                            style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.purple,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class FlashcardPractice extends StatefulWidget {
  @override
  _FlashcardPracticeState createState() => _FlashcardPracticeState();
}

class _FlashcardPracticeState extends State<FlashcardPractice> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Card #1',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      showAnswer ? 'Answer' : 'Title',
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Show Answer'),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.navigate_next, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
