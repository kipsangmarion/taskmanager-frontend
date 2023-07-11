import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskTitle'),//display specific task title
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Tag',// display specific task tag
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Status',// display specific task status
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Content',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter content',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Replace with actual number of activities
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('Activity $index'),
                            subtitle: const Text('Activity Status'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Handle New Activity button tap
                        },
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Comments button tap
                        },
                        child: const Text('Comments'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
