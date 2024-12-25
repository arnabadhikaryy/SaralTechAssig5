import 'package:flutter/material.dart';
import 'edit_todo_screen.dart'; // Import the EditToDoScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo App',
      theme: ThemeData(
        // General App-wide custom theme
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Updated TextTheme (replaced bodyText1 and bodyText2 with the new names)
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
        ),

        // Updated ElevatedButtonTheme (primary and onPrimary replaced by backgroundColor and foregroundColor)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Custom button color
            foregroundColor: Colors.white, // Button text color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding for buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
          ),
        ),
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  // List to store ToDo items
  List<String> todoItems = [];

  // Function to add a new item to the list
  void _addToDo() {
    setState(() {
      todoItems.add('New Task');
    });
  }

  // Function to delete a ToDo item
  void _deleteToDo(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SaralTech Assignment 5', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Add some space between items
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded card corners
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0), // Add padding around the tile
              title: Text(
                todoItems[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteToDo(index),
              ),
              onTap: () {
                // On tap, navigate to a detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditToDoScreen(
                      todoItem: todoItems[index],
                      index: index,
                    ),
                  ),
                ).then((editedItem) {
                  if (editedItem != null) {
                    setState(() {
                      todoItems[index] = editedItem;
                    });
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDo,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        backgroundColor: Colors.green, // Change FAB color
      ),
    );
  }
}
