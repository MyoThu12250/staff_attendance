import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicalLeave extends StatefulWidget {
  const MedicalLeave({super.key});

  @override
  State<MedicalLeave> createState() => _MedicalLeaveState();
}

class _MedicalLeaveState extends State<MedicalLeave> {
  final List<String> items = ['Medical Leave', 'Annual Leave'];
  String selectedValue = 'Medical Leave'; // Default selected value
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text('Medical Leave'),
        ),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            // color: Colors.indigoAccent.withOpacity(0.4),
            width: screenWidth,
            height: screenHeight * 0.7,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 100,
                              height: 25,
                              child: Center(child: Text('User id'))),
                          // SizedBox(
                          //   height: 11,
                          // ),
                          SizedBox(
                              width: 100,
                              height: 70,
                              child: Center(child: Text('Leave type'))),
                          // SizedBox(
                          //   height: 11,
                          // ),
                          SizedBox(
                              width: 100,
                              height: 50,
                              child: Center(child: Text('Duration'))),
                          // SizedBox(
                          //   height: 11,
                          // ),
                          SizedBox(
                              width: 100,
                              height: 53,
                              child: Center(child: Text('Reason'))),
                          // SizedBox(
                          //   height: 11,
                          // ),
                          SizedBox(
                              width: 100,
                              height: 47,
                              child: Center(child: Text('Attachment'))),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('112454'),
                        ),
                        // SizedBox(
                        //   height: 11,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                // Update selected value when an item is selected
                                selectedValue = newValue;
                              }
                              setState(() {});
                            },
                            items: items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // child: Icon(Icons.arrow_drop_down),
                        ),
                        // SizedBox(
                        //   height: 11,
                        // ),
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'From'), // read only textfield label text from
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        _selectedDate();
                                      },
                                      icon: Icon(Icons.date_range)),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'to'), // read only textfield label text from
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        _selectedDate();
                                      },
                                      icon: Icon(Icons.date_range)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 11,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: Text('Enter reason'),
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: TextField(
                              maxLines: null,
                              expands: true,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 11,
                        // ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Choose File',
                                suffixIcon: Icon(Icons.link)),
                            readOnly: true,
                            onTap: () async {
                              final file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (file == null) return;
                            },
                            //
                            // decoration: InputDecoration(
                            //     suffixIcon: TextButton.icon(
                            //         onPressed: () async {
                            //           final file = await ImagePicker()
                            //               .pickImage(
                            //                   source: ImageSource.gallery);
                            //           if (file == null) return;
                            //         },
                            //         icon: Icon(Icons.link),
                            //         label: Text('Choose File'))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectedDate() async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
  }
}
