// ignore: file_names

// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todofinal/presentation/widgets/componants.dart';
import 'package:todofinal/data/data_sources/cubit.dart';
import 'package:todofinal/core/shared/states.dart';


class AllTasksscreen extends StatefulWidget {
  @override
  State<AllTasksscreen> createState() => _AllTasksscreenState();
}

class _AllTasksscreenState extends State<AllTasksscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).allTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
