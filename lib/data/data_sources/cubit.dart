import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todofinal/core/shared/states.dart';
import 'package:todofinal/presentation/pages/layout/all_task/All_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/fav_task/fav_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/Done_task/Done_Tasks.dart';
import 'package:todofinal/presentation/pages/layout/uncomplete_task/Uncompletted_Tasks.dart';



class AppCubit extends Cubit<AppStates> {

  @override




  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex =0;
  List<Widget> screen = [
    AllTasksscreen(),
    NewTasks(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  List<String> titles = [
    'All Tasks'
        'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> allTasks = [];
  List<Map> allTasks2 = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  void createDatabase() {
    openDatabase('todoo.db', version: 2, onCreate: (database, version) {
      print('db created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,starttime TEXT,endtime TEXT,remind TEXT,repeat TEXT,status TEXT  )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table ${error.toString()}');
      });
    }, onOpen: (database)
    {
      getDataFromDatabase(database);
      print('db opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
    required String endtime,
    required String remind,
    required String repeat,

  }) async {
    database.transaction(
          (txn) => txn
          .rawInsert(
          'INSERT INTO tasks(title,date,starttime,endtime,remind,repeat,status) VALUES("$title","$date","$time","$endtime","$remind","$repeat","new")')
          .then((value) {
        getDataFromDatabase(database);
        emit(AppInsertDatabaseState());
        emit(AppGetDatabaseLoadingState());


      }),
    );
  }

  void getDataFromDatabase(database)
  {
    allTasks=[];

    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then(
          (value) {

        value.forEach((element)
        {
          print('$value inserted successfully');


          if(element['status']=='new'){
            allTasks.add(element);
            newTasks.add(element);



          }


          else if(element['status']=='done'){
            allTasks.add(element);
            doneTasks.add(element);



          }

          else if(element['status']=='archive'){
            allTasks.add(element);
            archiveTasks.add(element);


          }


        });
        emit(AppGetDatabaseState());

      },
    );
  }

  void searchDataFromDatabase(date)
  {

    allTasks2=[];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks WHERE date=?',
      ['$date'],).then(
          (value) {



        value.forEach((element)
        {





          if(element['status']=='new'){
            allTasks2.add(element);


          }



        });
        emit(AppGetDatabaseState());
      },
    );
  }

  void updateData({
    required String status,
    required int id,
  }) async{
    database.rawUpdate(
      'UPDATE tasks SET status=? WHERE id=?',
      ['$status',id],
    ).then((value) {
      getDataFromDatabase(database);




      emit(AppUpdateDatabaseState ());

    });
  }
  void searchData({
    required String date,

  }) async{

    database.rawQuery(
      'SELECT * FROM tasks WHERE date=?',
      ['$date'],
    ).then((value) {

      getDataFromDatabase(database);
      print(value);


      emit(AppSearchDatabaseState ());

    });
  }

  void deleteData({
    required int id,
  }) async{
    database.rawDelete(
      'DELETE FROM tasks  WHERE id=?', [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState ());

    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon
  })
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeSheetState());
  }
}







