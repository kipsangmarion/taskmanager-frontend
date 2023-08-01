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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Center(child: Text(taskModel?.desc ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)),
              // subtitle: Center(child: Text(taskModel?.desc ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                    'Content',
                    style: TextStyle(fontSize: 21, decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(taskModel?.content ?? "")
                  ),
              ),
            ),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.actual_start_date ?? DateTime.now())),
              subtitle: const Text('Start Date'),
            ),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.actual_end_date ?? DateTime.now())),
              subtitle: const Text('End Date'),
            ),
            ListTile(
              title: Text(DateFormat.MMMMEEEEd()
                  .format(taskModel?.planned_start_date ?? DateTime.now())),
              subtitle: const Text('Planned start Date'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 8,
                ),
                FloatingActionButton.extended(
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
                    backgroundColor: Colors.blueGrey.shade200,
                    icon: const Icon(Icons.chat), label: const Text('comments'),),
                const SizedBox(
                  width: 8,
                ),
                FloatingActionButton.extended(
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
                    backgroundColor: Colors.blueGrey.shade200,
                    icon: const Icon(Icons.edit), label: const Text('edit'),),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FloatingActionButton.extended(
                onPressed: () {
                  //TODO: TaskPage edit profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskActivitiesPage(
                        taskModel: taskModel,
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.blueGrey.shade200,
                icon: const Icon(Icons.local_activity), label: const Text('activities'),),
            ),
          ],
        ),
      ),
    );
  }
}
