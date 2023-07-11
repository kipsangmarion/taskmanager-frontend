import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMaster'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'TaskMaster',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('User Profile'),
              onTap: () {
                // Handle User Profile option
              },
            ),
            ListTile(
              title: const Text('Urgent and Important'),
              onTap: () {
                // Display Urgent and Important tasks
              },
            ),
            ListTile(
              title: const Text('Not Urgent and Important'),
              onTap: () {
                // Display Not Urgent and Important tasks
              },
            ),
            ListTile(
              title: const Text('Urgent and Not Important'),
              onTap: () {
                // Display Urgent and Not Important tasks
              },
            ),
            ListTile(
              title: const Text('Not Urgent and Not Important'),
              onTap: () {
                // Display Not Urgent and Not Important tasks
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual number of tasks
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Task $index'),
              subtitle: Text('Task Tag $index'),
              onTap: () {
                // Handle task tap
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle New Task button tap
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
