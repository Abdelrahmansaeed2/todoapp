// ignore: file_names

// ignore_for_file: file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/layout/add%20task.dart';
import 'package:todofinal/layout/All_Tasks.dart';
import 'package:todofinal/layout/fav_Tasks.dart';
import 'package:todofinal/layout/Done_Tasks.dart';
import 'package:todofinal/layout/Uncompletted_Tasks.dart';
import 'package:todofinal/shared/componants.dart';
import 'package:todofinal/shared/cubit.dart';
import 'package:todofinal/shared/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, state) {
            AppCubit cubit = AppCubit.get(context);

            return DefaultTabController(
              initialIndex: 0,
              length: 4 ,
              child: Scaffold(

                key: scaffoldKey,
                body:
                TabBarView(
                  children: [
                    Container(
                      child: Center(
                        child: AllTasksscreen(),

                      ),
                    ),
                    Container(
                      child: Center(
                        child: DoneTasksScreen(),

                      ),
                    ),

                    Container(
                      child: Center(
                        child: NewTasks(),

                      ),
                    ),

                    Container(
                      child: Center(
                        child: ArchiveTasksScreen(),

                      ),
                    ),
                  ],
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(icon: const Icon(Icons.search),color: Colors.grey, onPressed: () {  },),
                    IconButton( icon: const Icon(Icons.notifications_outlined),color: Colors.grey, onPressed: () {  },),
                    IconButton( icon: const Icon(Icons.menu),color: Colors.grey, onPressed: () {  },),
                  ],



                  bottom: TabBar(
                    labelColor: Colors.black,


                    onTap: (index) {
                      cubit.changeIndex(index);

                    },
                    tabs: [
                      Tab(text: 'all tasks',),
                      Tab(text: 'completed',),
                      Tab(text: 'uncompleted',),
                      Tab(text: 'favorites',)
                    ],
                  ),
                  title: Text('Board',style: TextStyle(color: Colors.black),
                  ),
                ),
                  floatingActionButton: Container(

                    width: screenSize.width/1.1,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addtask()),
                        );


                        },


                      label: const Text('Add a task'),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

              ),
            );

          },
        ));
  }
}

String? onValidateText(String? text) {
  if (text == null || text.isEmpty) {
    return 'Title can\'t be empty';
  }
  return null;
}

String? onValidateTime(String? text) {
  if (text == null || text.isEmpty) {
    return 'Time can\'t be empty';
  }
  return null;
}

String? onValidateDate(String? text) {
  if (text == null || text.isEmpty) {
    return 'Date can\'t be empty';
  }
  return null;
}
