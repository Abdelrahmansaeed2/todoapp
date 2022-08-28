
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todofinal/presentation/pages/layout/schedule_page/schedulelayout.dart';
import 'package:todofinal/core/utils/services/local_notification_service.dart';

class scheduletask extends StatefulWidget{
  @override
  State<scheduletask> createState() => _scheduletaskState();
}

class _scheduletaskState extends State<scheduletask> {
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
  Icon search  = const Icon(Icons.search,color: Colors.grey,);


  Widget searchbar = Text("Schedule",style: TextStyle(color: Colors.black));
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

      key: scaffoldKey,
      body:
      schedulelayout(),
      appBar: AppBar(
        leading: IconButton( icon: const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.grey,  onPressed: () {
          Navigator.pop(context);
        },),

        backgroundColor: Colors.white,
        title:searchbar,






      ),

    );
  }


}
