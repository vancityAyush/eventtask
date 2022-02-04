import 'package:dio/dio.dart';
import 'package:eventtask/constants.dart';
import 'package:eventtask/styles.dart';
import 'package:flutter/material.dart';

class EventType extends StatefulWidget {
  final String title, description;
  final String? filePath;

  EventType(
      {required this.title, required this.description, required this.filePath});

  @override
  State<EventType> createState() => _EventTypeState();
}

class _EventTypeState extends State<EventType> {
  DateTime? start, end;

  int selected_event = 1;
  TextEditingController price = TextEditingController();
  TextEditingController location = TextEditingController();

  List<DropdownMenuItem<int>> event_type = [
    const DropdownMenuItem(value: 1, child: Text("FREE")),
    const DropdownMenuItem(value: 2, child: Text("PAID"))
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.keyboard_arrow_left),
        ),
        title: heading(context, text: "Event type", weight: FontWeight.w800),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                button1(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      child: DropdownButton<int>(
                          value: selected_event,
                          items: event_type,
                          onChanged: (value) {
                            setState(() {
                              selected_event = value!;
                            });
                          }),
                    ),
                  ),
                  10,
                  color: hexColor("F2994A"),
                ),
                SBox(context, 0.04),
                button1(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBox(context, 0.02),
                        heading(context,
                            text: "Enter the price of event", scale: 0.9),
                        txtFieldContainer(context,
                            controller: price,
                            color: hexColor("f5f5f5"),
                            borcolor: Colors.transparent,
                            hintText: "1232",
                            keyboard: TextInputType.number)
                      ],
                    ),
                    15,
                    color: hexColor("F5F5F5")),
                SBox(context, 0.04),
                button1(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBox(context, 0.03),
                        heading(context, text: "Location"),
                        SBox(context, 0.02),
                        txtFieldContainer(
                          context,
                          controller: location,
                          color: Colors.white,
                          borcolor: Colors.transparent,
                          hintText: "Remote",
                        ),
                        SBox(context, 0.02),
                      ],
                    ),
                    15,
                    color: hexColor("F5F5F5")),
              ],
            ),
            button1(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    heading(context,
                        text: "Create New",
                        weight: FontWeight.w600,
                        color: Colors.white)
                  ],
                ),
              ),
              15,
              onTap: () async {
                await post();
                print("request sent");
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> post() async {
    var dio = Dio();
    double priceFloat;
    try {
      priceFloat = double.parse(price.text);
    } catch (e) {
      priceFloat = 0.0;
    }
    var formData = FormData.fromMap({
      'id': 1234,
      'type': selected_event,
      'currency_type': 1,
      'location': location.text,
      'title': widget.title,
      'description': widget.description,
      'start_at': start.toString(),
      'end_at': end.toString(),
      'file': widget.filePath
    });
    try {
      var response = await dio.post(
        base_url,
        data: formData,
      );
      print(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
