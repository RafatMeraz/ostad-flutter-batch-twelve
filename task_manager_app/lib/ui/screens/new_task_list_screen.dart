import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/providers/new_task_list_provider.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../widgets/centered_circular_progress.dart';
import '../widgets/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountInProgress = false;

  List<TaskCountModel> _taskCountList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountList();
    // Provider.of<NewTaskListProvider>(context).getNewTaskList();
    // dependOnInheritedWidgetOfExactType<_InheritedProviderScope<NewTaskListProvider?>>() or dependOnInheritedElement() was called before _NewTaskListScreenState.initState() completed.
    context.read<NewTaskListProvider>().getNewTaskList();

    // TODO: Solve these issues
    // setState() or markNeedsBuild() called during build.
    //
    // This _InheritedProviderScope<NewTaskListProvider?> widget cannot be marked as needing to build because the framework is already in the process of building widgets. A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(),
            _buildTaskSummaryListView(),
            Consumer<NewTaskListProvider>(
              builder: (context, newTaskListProvider, _) {
                return Visibility(
                  visible: newTaskListProvider.getNewTaskListInProgress == false,
                  replacement: SizedBox(
                    height: 200,
                    child: CenteredCircularProgress(),
                  ),
                  child: ListView.separated(
                    itemCount: newTaskListProvider.newTaskList.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: newTaskListProvider.newTaskList[index],
                        refreshList: () {
                          newTaskListProvider.getNewTaskList();
                          _getTaskCountList();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }

  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: Visibility(
        visible: _getTaskCountInProgress == false,
        replacement: CenteredCircularProgress(),
        child: ListView.builder(
          itemCount: _taskCountList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Colors.white,
              margin: EdgeInsets.only(left: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      _taskCountList[index].sum.toString(),
                      style: TextTheme.of(context).titleMedium,
                    ),
                    Text(
                      _taskCountList[index].id,
                      style: TextTheme.of(context).labelSmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Future<void> _getTaskCountList() async {
    _getTaskCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskCountUrl,
    );

    if (response.isSuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _taskCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }

    _getTaskCountInProgress = false;
    setState(() {});
  }
}
