import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/data/data_sources/cubit.dart';

Widget defaultFormField(
    {
      required TextEditingController controller,
      required TextInputType type,
      Function? onSubmit,
      Function? onChanged,
      VoidCallback? onTap,
      required FormFieldValidator<String>? onValidate,
      VoidCallback? suffixPressed,
      required String label,
      required IconData prefix,
      bool isPassword = false,
      IconData? suffix,
    }) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (s) {
        onSubmit;
      },
      onChanged: (s) {
        onChanged;
      },
      onTap: onTap,
      validator: onValidate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
Widget addDateBar(context) {
  DateTime date = DateTime.now();

  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 5, left: 20),
        child: DatePicker(
          DateTime.now(),
          width: 70,
          height: 90,
          initialSelectedDate: date,
          selectedTextColor: Colors.white,
          selectionColor: Colors.cyan,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          onDateChange: (newDate) {

            var myTime = DateFormat('yyyy-MM-dd').format(newDate);
            AppCubit.get(context).searchDataFromDatabase(myTime);

          },


        ),


      ),






    ],
  );
}
Widget buildTaskItem(Map model, context) {
  return Column(
    children: [

      SizedBox(
        child:   Padding(
          padding: const EdgeInsets.all(8.0),
          child:   Dismissible(
            key: Key(model['id'].toString()),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [

                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model['title']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model['date']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      if(model['status']=='new'){
                        AppCubit.get(context)
                            .updateData(status: 'done', id: model['id']);
                      }else if(model['status']=='done'){
                        AppCubit.get(context)
                            .updateData(status: 'new', id: model['id']);
                      }
                    },
                    icon: Icon(
                      Icons.check_box_rounded,
                      color: Colors.primaries[model['id']],
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                      AppCubit.get(context)
                          .updateData(status: 'archive', id: model['id']);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[800],
                    ),
                  ),
                ],
              ),
            ),
            onDismissed: (direction) {
              AppCubit.get(context).deleteData(id: model['id']);
            },
          ),
        ),
      ),
    ],
  );
}
Widget buildscheduleTaskItem(Map model, context) {

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child:   Dismissible(
          key: Key(model['id'].toString()),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.primaries[model['id']],
                borderRadius: BorderRadius.circular(20)),



            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [

                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model['starttime']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${model['title']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      AppCubit.get(context).deleteData(id: model['id']);
                    },
                    icon: Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),
          ),

        ),
      ),
    ],
  );
}


Widget tasksBuilder({required tasks}) =>
    ConditionalBuilder(
        condition: tasks.length > 0,
        fallback: (BuildContext context) => Column(
          children: [

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text(
                    ' No Tasks Yet, Please Add Some Tasks ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        builder: (BuildContext context) {return Column(
          children: [

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                  width: 25,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: tasks.length,
              ),
            ),
          ],
        );}
    );
Widget scheduletasksBuilder({required tasks}) =>
    ConditionalBuilder(
        condition: tasks.length > 0,
        fallback: (BuildContext context) => Column(
          children: [
            Divider(),

            addDateBar(context),
            Divider(),



            Column(
              children: [

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 100.0,
                        color: Colors.grey,
                      ),
                      Text(
                        ' No Tasks Yet, Please Add Some Tasks ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        builder: (BuildContext context) {return Column(
          children: [
            Divider(),

            addDateBar(context),


            Divider(),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildscheduleTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                  width: 25,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: tasks.length,
              ),
            ),
          ],
        );}
    );
