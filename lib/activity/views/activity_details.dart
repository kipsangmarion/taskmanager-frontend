import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';

class ActivityDetailsPage extends StatelessWidget {
  const ActivityDetailsPage({super.key, required this.activityModel});
  final ActivityModel? activityModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity details')),
      body: Column(children: [
        ListTile(
          title: Text(activityModel?.title ?? ""),
          subtitle: Text(activityModel?.desc ?? ''),
        ),
        Text('Content'),
        Text(activityModel?.content ?? ""),
        ListTile(
          title: Text(activityModel?.hours.toString() ?? ''),
          subtitle: Text('Hours'),
        ),
      ]),
    );
  }
}
