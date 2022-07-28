import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/layout/Home_Layout.dart';
import 'package:todofinal/shared/componants.dart';
import 'package:todofinal/shared/cubit.dart';
import 'package:todofinal/shared/states.dart';


class addtask extends StatefulWidget{
  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  _getRequests()async{
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();

  TextEditingController dateCtl = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController timeController2 = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _startTimeController = TextEditingController();

  final TextEditingController _endTimeController = TextEditingController();

  final TextEditingController _reminderController = TextEditingController();

  final TextEditingController _repeatController = TextEditingController();

  TextEditingController intialdateval = TextEditingController();

  String dropdownvalue = '10 min before';

  // List of items in our dropdown menu
  var items = [
    '10 min before', '30 min before', '1 hour before', '1 day before'
  ];

  String dropdownvalue2 = 'Weekly';

  // List of items in our dropdown menu
  var items2 = [
    'Weekly', 'Monthly', 'yearly','5years'
  ];

  int _selectedReminder = 5;

  List<int> reminderList = [5, 10, 15, 20];

  String _repeat = 'None';

  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();



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
                appBar: AppBar(
                  backgroundColor: Colors.white,

                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: const Text("Add Task",style: TextStyle(color: Colors.black),),
                  leading: IconButton( icon: const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.grey,  onPressed: () {
                    Navigator.pop(context);
                  },),


                ),
                body: Container(
                  color: Colors.white,
                  child: Center(

                    // Center is a layout widget. It takes a single child and positions it
                    // inC the middle of the parent.
                    child: Column(

                      children: [

                        Padding(
                          padding: EdgeInsets.only(top: 5),

                          child: SizedBox(

                            width: screenSize.width/1.2,


                            child: Column(


                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  <Widget>[
                                        Text(
                                          "Title",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:Colors.black87
                                          ),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          controller:dateinput ,

                                          decoration: InputDecoration(
                                              hintText: "Design Team Meeting",

                                              contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                  horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                ),

                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey)
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          "Date",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:Colors.black87
                                          ),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: dateCtl,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                  horizontal: 10),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                ),

                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey)
                                              )),
                                          onTap: () async{
                                            DateTime? date = DateTime(1900);
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            date = await showDatePicker(
                                                context: context,
                                                initialDate:DateTime.now(),
                                                firstDate:DateTime(1900),
                                                lastDate: DateTime(2100));
                                            dateCtl.text = date!.toIso8601String();},),
                                        SizedBox(height: 10,),
                                        Row(

                                          children: [


                                            Container(
                                              width: screenSize.width/2.5,


                                              child: Column(

                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Start time",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                                color:Colors.black87
                                                            ),

                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextField(
                                                            readOnly: true,
                                                            controller: timeController,
                                                            decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.access_time_rounded) ,//icon at tail of input

                                                                contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                                    horizontal: 10),
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Colors.grey
                                                                  ),

                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.grey)
                                                                )

                                                            ),
                                                            onTap: () async {
                                                              var time =  await showTimePicker(
                                                                initialTime: TimeOfDay.now(),
                                                                context: context,);
                                                              timeController.text = time!.format(context);
                                                            },
                                                          ),
                                                          SizedBox(height: 10,)
                                                        ],
                                                      ),
                                                    ],
                                                  ),



                                                ],

                                              ),
                                            ),   Container(
                                              width: screenSize.width/2.5,


                                              child: Column(

                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            "End time",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w400,
                                                                color:Colors.black87
                                                            ),

                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextField(
                                                            readOnly: true,
                                                            controller: timeController2,
                                                            decoration: InputDecoration(
                                                                suffixIcon: Icon(Icons.access_time_rounded) ,//icon at tail of input

                                                                contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                                    horizontal: 10),
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Colors.grey
                                                                  ),

                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.grey)
                                                                )

                                                            ),
                                                            onTap: () async {
                                                              var time =  await showTimePicker(
                                                                initialTime: TimeOfDay.now(),
                                                                context: context,);
                                                              timeController2.text = time!.format(context);
                                                            },
                                                          ),
                                                          SizedBox(height: 10,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),



                                                ],

                                              ),
                                            ),


                                          ],
                                        )  ,
                                        Text(
                                          "Remind",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:Colors.black87
                                          ),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: screenSize.width/1.2,
                                          child:
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                hintText: "Design Team Meeting",

                                                contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                    horizontal: 10),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey
                                                  ),

                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey)
                                                )
                                            ),


                                            // Initial Value
                                            value: dropdownvalue,

                                            // Down Arrow Icon
                                            icon: const Icon(Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: items.map((String items) {
                                              return DropdownMenuItem(



                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10,),

                                        Text(
                                          "Repeat",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:Colors.black87
                                          ),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: screenSize.width/1.2,
                                          child:
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                hintText: "Design Team Meeting",

                                                contentPadding: EdgeInsets.symmetric(vertical: 0,
                                                    horizontal: 10),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey
                                                  ),

                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey)
                                                )
                                            ),


                                            // Initial Value
                                            value: dropdownvalue2,

                                            // Down Arrow Icon
                                            icon: const Icon(Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: items2.map((String items) {
                                              return DropdownMenuItem(



                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue2 = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10,),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 285),
                                      child: Container(
                                        width: screenSize.width/1.2,
                                        height: 50,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: MaterialButton(

                                          color: Colors.green,
                                          onPressed: () {
                                            cubit.insertToDatabase(
                                              title: dateinput.text,
                                              time: dateCtl.text,
                                              date: timeController.text,
                                            );












                                          },
                                          child: Text(
                                            "Create a Task",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )


                                  ],
                                ),




                              ],

                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),



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
