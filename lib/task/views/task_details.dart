import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_frontend/comment/views/comment_page.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/task/views/task_activities.dart';
import 'package:taskmanager_frontend/task/views/task_page.dart';

class TaskDetailspage extends StatelessWidget {
  const TaskDetailspage({super.key, this.taskModel});
  final TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(taskModel?.title ?? "")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(taskModel?.title ?? ""),
              subtitle: Text(taskModel?.desc ?? ''),
            ),
            Text('Content'),
            Text(taskModel?.content ?? ""),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.actual_start_date ?? DateTime.now())),
              subtitle: Text('Start Date'),
            ),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.actual_end_date ?? DateTime.now())),
              subtitle: Text('End Date'),
            ),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.planned_start_date ?? DateTime.now())),
              subtitle: Text('Planned start Date'),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(
                            activityModel: ActivityModel(task: taskModel?.id),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.chat)),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      //TODO: TaskPage edit profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(
                            taskModel: taskModel,
                            isEditMode: true,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit)),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      //TODO: TaskPage edit profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskActivitesPage(
                            taskModel: taskModel,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.local_activity)),
                const SizedBox(
                  width: 8,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
