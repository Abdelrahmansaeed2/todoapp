import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/presentation/widgets/componants.dart';
import 'package:todofinal/data/data_sources/cubit.dart';
import 'package:todofinal/core/shared/states.dart';

class schedulelayout extends StatefulWidget {
  @override
  State<schedulelayout> createState() => _schedulelayoutState();
}

class _schedulelayoutState extends State<schedulelayout> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var tasks = AppCubit.get(context).allTasks2;

        String datect = "";
        return  ConditionalBuilder(
            condition: tasks.length > 0,
            fallback: (BuildContext context) => Column(
              children: [

                Divider(),

                Column(
                  children: [
                    addDateBar(),





                  ],
                ),


                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text("${DateFormat.EEEE()

                      // displaying formatted date
                          .format(date)}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160,right: 20),
                      child: Text("${DateFormat.yMMMMd()

                      // displaying formatted date
                          .format(date)}"),
                    ),
                  ],
                ),


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

                Column(
                  children: [
                    addDateBar(),





                  ],
                ),


                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text("${DateFormat.EEEE()

                      // displaying formatted date
                          .format(date)}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160,right: 20),
                      child: Text("${DateFormat.yMMMMd()

                      // displaying formatted date
                          .format(date)}"),
                    ),
                  ],
                ),

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
      },
    );
  }


  addDateBar() {
    return Container(
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
          setState(() => date = newDate);

          var myTime = DateFormat('yyyy-MM-dd').format(newDate);
          AppCubit.get(context).searchDataFromDatabase(myTime);
          print(newDate.day.toString());
        },


      ),


    );
  }

}