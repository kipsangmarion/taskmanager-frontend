import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActivityTitle'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Status',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
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
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Comments button tap
                },
                child: const Text('Comments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
