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
  List<Map<String, String>> flashcards = [
    {'question': 'Question 1', 'answer': 'Answer 1'},
    {'question': 'Question 2', 'answer': 'Answer 2'},
    {'question': 'Question 3', 'answer': 'Answer 3'},
    {'question': 'Question 4', 'answer': 'Answer 4'},
    {'question': 'Question 5', 'answer': 'Answer 5'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _deleteCard(int index) {
    setState(() {
      flashcards.removeAt(index);
    });
  }

  void _addCard(String question, String answer) {
    setState(() {
      flashcards.add({'question': question, 'answer': answer});
    });
  }

  void _showAddCardDialog() {
    String question = '';
    String answer = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => question = value,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              onChanged: (value) => answer = value,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (question.isNotEmpty && answer.isNotEmpty) {
                _addCard(question, answer);
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
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
      body: _selectedIndex == 0
          ? FlashcardPractice(flashcards: flashcards)
          : FlashcardGrid(flashcards: flashcards, onDelete: _deleteCard, onAdd: _showAddCardDialog),
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
  final List<Map<String, String>> flashcards;
  final Function(int) onDelete;
  final VoidCallback onAdd;

  FlashcardGrid({required this.flashcards, required this.onDelete, required this.onAdd});

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
                    child: GestureDetector(
                      onTap: () => onDelete(index),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
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
            onPressed: onAdd,
            backgroundColor: Colors.purple,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class FlashcardPractice extends StatefulWidget {
  final List<Map<String, String>> flashcards;

  FlashcardPractice({required this.flashcards});

  @override
  _FlashcardPracticeState createState() => _FlashcardPracticeState();
}

class _FlashcardPracticeState extends State<FlashcardPractice> {
  bool showAnswer = false;
  int currentIndex = 0;

  void _toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void _nextCard() {
    setState(() {
      if (currentIndex < widget.flashcards.length - 1) {
        currentIndex++;
        showAnswer = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return Center(
        child: Text(
          'No flashcards available',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }

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
    'Card #${currentIndex + 1}',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    ),
    ),
    Center(
    child: Text(
    showAnswer ? widget.flashcards[currentIndex]['answer']! : widget.flashcards[currentIndex]['question']!,
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
    onPressed: _toggleAnswer,
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape
        : RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    ),
      child: Text(showAnswer ? 'Hide Answer' : 'Show Answer'),
    ),
      SizedBox(width: 20),
      FloatingActionButton(
        onPressed: _nextCard,
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
