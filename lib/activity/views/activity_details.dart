import 'package:flutter/material.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';

class ActivityDetailsPage extends StatelessWidget {
  const ActivityDetailsPage({super.key, required this.activityModel});
  final ActivityModel? activityModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(activityModel?.title ?? "")),
      body: Column(children: [
        ListTile(
          title: Center(child: Text(activityModel?.desc ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)),
          // subtitle: Text(activityModel?.desc ?? ''),
        ),
        Container(
            padding: const EdgeInsets.all(20),
            child: const Center(child: Text('Content', style: TextStyle(fontSize: 21, decoration: TextDecoration.underline),)
            )),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Card(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(activityModel?.content ?? "")),
          ),
        ),
        ListTile(
          title: const Text('Hours'),
          subtitle: Text(activityModel?.hours.toString() ?? ''),
        ),
      ]),
    );
  }
}
