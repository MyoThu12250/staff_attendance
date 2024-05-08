import 'package:flutter/material.dart';

class AnnualLeave extends StatefulWidget {
  const AnnualLeave({super.key});

  @override
  State<AnnualLeave> createState() => _AnnualLeaveState();
}

class _AnnualLeaveState extends State<AnnualLeave> {
  Future<void> _selectedDate() async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Annual Leave'),
        ),
        body: MediaQuery(
            data: MediaQuery.of(context),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.5,
              // color: Colors.indigoAccent.withOpacity(0.4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('User id'),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Duration'),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Reason'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text('123456'),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('From'),
                              SizedBox(
                                width: 5,
                              ),
                              // Icon(Icons.date_range),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedDate();
                                    });
                                  },
                                  icon: Icon(Icons.date_range)),
                              SizedBox(
                                width: 15,
                              ),
                              Text('to'),
                              SizedBox(
                                width: 5,
                              ),
                              // Icon(Icons.date_range),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedDate();
                                    });
                                  },
                                  icon: Icon(Icons.date_range))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Enter Reason'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent),
                  )
                ],
              ),
            )));
  }
}
