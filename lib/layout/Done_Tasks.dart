// ignore_for_file: file_names
// ignore: file_names

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofinal/shared/componants.dart';
import 'package:todofinal/shared/cubit.dart';
import 'package:todofinal/shared/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
