import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isChecked = false;
  var hoursCompleted = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        // height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Learn Artificial Intelligence",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LinearPercentIndicator(
                      barRadius: Radius.circular(10),
                      width: 200.0,
                      lineHeight: 10.0,
                      percent: hoursCompleted / 10,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.greenAccent,
                    ),
                    Text(hoursCompleted.toString() + "/10"),
                  ],
                ),
              ],
            ),
            Center(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (hoursCompleted != 10) {
                      hoursCompleted = hoursCompleted + 1;
                    }
                  });
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        ));
  }
}
