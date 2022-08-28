import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todofinal/core/utils/services/local_notification_service.dart';
import 'package:todofinal/presentation/widgets/componants.dart';
import 'package:todofinal/data/data_sources/cubit.dart';
import 'package:todofinal/core/shared/states.dart';



class addtask extends StatefulWidget{
  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();

    super.initState();
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


    return Scaffold(
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


          child:  SafeArea(


            child: SizedBox(

              width: screenSize.width/1.2,
              height: screenSize.height/0.2,


              child: SingleChildScrollView(
                child: Column(


                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  <Widget>[
                        SizedBox(
                          height: 5,
                        ),
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
                                firstDate: DateTime(2018),
                                lastDate: DateTime(2101));
                            if(date != null ){
                              print(date);  //pickedDate output format => 2021-03-10  t00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                              dateCtl.text = formattedDate.toString();
                            }else{
                              print("Date is not selected");
                            }
                          },),
                        SizedBox(height: 10,),
                        Row(

                          children: [


                            Container(
                              width: screenSize.width/2.6,


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


                                              final TimeOfDay? slectedTime = await showTimePicker(
                                                  context: context, initialTime: TimeOfDay.now());

                                              if (slectedTime == null) {
                                                return;
                                              }

                                              timeController.text =
                                              "${slectedTime.hour}:${slectedTime.minute}";



                                            },
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    ],
                                  ),



                                ],

                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),

                            Container(
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



                                              if (time == null) {
                                                return;
                                              }

                                              timeController2.text =
                                              "${time.hour}:${time.minute}";
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
                          onPressed: ()   {
                            AppCubit.get(context).insertToDatabase(title: dateinput.text, time: timeController.text, date: dateCtl.text, endtime: timeController2.text, remind: dropdownvalue.toString(), repeat: dropdownvalue2);




                            service.showScheduledNotification( id: 1,
                                title: dateinput.text,





                                body: '', seconds: int.parse(timeController.text.split(":")[0]), minute: int.parse(timeController.text.split(":")[1].split(' ')[0]), date:  dateCtl.text);







                            Navigator.pop(context);






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
              ),
            ),
          ),
        ),
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
