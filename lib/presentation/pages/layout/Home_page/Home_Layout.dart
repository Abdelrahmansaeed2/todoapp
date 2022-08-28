// ignore: file_names

// ignore_for_file: file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/presentation/pages/layout/add_task/add%20task.dart';
import 'package:todofinal/presentation/pages/layout/all_task/All_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/fav_task/fav_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/Done_task/Done_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/schedule_page/scheduletask.dart';
import 'package:todofinal/presentation/pages/layout/uncomplete_task/Uncompletted_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/schedule_page/scheduletask.dart';

import 'package:todofinal/core/utils/services/local_notification_service.dart';
import 'package:todofinal/presentation/widgets/componants.dart';
import 'package:todofinal/data/data_sources/cubit.dart';
import 'package:todofinal/core/shared/states.dart';


class HomeLayout extends StatefulWidget  {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>  {
  Icon search  = const Icon(Icons.search,color: Colors.grey,);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();
  Widget searchbar = Text("Board",style: TextStyle(color: Colors.black));
  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var tasks = AppCubit.get(context).allTasks;
    return DefaultTabController(
      initialIndex: 0,
      length: 4 ,
      child: Scaffold(

        key: scaffoldKey,
        body:
        TabBarView(
          children: [
            AllTasksscreen(),
            DoneTasksScreen(),
            NewTasks(),
            ArchiveTasksScreen(),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:searchbar,
          actions: <Widget>[
            IconButton(icon: search, onPressed: () { setState(() {
              if(search.icon==Icons.search){
                search = const Icon(Icons.cancel,color: Colors.grey);
                searchbar =const TextField();
              }else{}
            }); },),

            IconButton( icon: const Icon(Icons.notifications_outlined),color: Colors.grey,  onPressed: () async {
              await service.showNotification(id: 1, title: "fgfg", body: "ffggfg");

            },),
            IconButton( icon: const Icon(Icons.menu),color: Colors.grey, onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => scheduletask()),
              );

            },),
          ],



          bottom: TabBar(isScrollable: true,
            labelColor: Colors.black,


            onTap: (index) {


            },
            tabs: [


              Tab(text: 'all tasks',),
              Tab(text: 'completed',),
              Tab(text: 'uncompleted',),
              Tab(text: 'favorites',)
            ],
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
