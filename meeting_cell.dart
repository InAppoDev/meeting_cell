import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:never_eat_alone/api/entities/meeting.dart';
import 'package:never_eat_alone/constants/constants.dart';

class MeetingCell extends StatelessWidget {
  Meeting meeting;
  final VoidCallback onPressed;

  MeetingCell(this.meeting, this.onPressed);

  @override
  Widget build(BuildContext context) {
    var location = (meeting?.address ?? "");
    MeetingStatus meetingStatus = MeetingStatus.values
        .firstWhere((e) => e.toString() == 'MeetingStatus.' + meeting.myStatus);
    IconData icon = Icons.done_outline;
    ;
    Color color;
    String title;
    switch (meetingStatus) {
      case MeetingStatus.invited:
        icon = Icons.access_time;
        color = Colors.amber;
        title = StringConstants.waiting;
        break;
      case MeetingStatus.declined:
        icon = Icons.cancel;
        color = Colors.black26;
        title = StringConstants.waiting;
        break;
      case MeetingStatus.deleted:
        icon = Icons.remove_circle;
        color = Colors.red;
        title = StringConstants.waiting;
        break;
      case MeetingStatus.accepted:
        icon = Icons.done_outline;
        color = Colors.green;
        title = StringConstants.waiting;
        break;
    }
    meeting.meetingStatus = meetingStatus;
    meeting.textForShow = title;
    var date =
        new DateTime.fromMillisecondsSinceEpoch(meeting.date * 1000);
    return Container(
      height: 150,
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (meeting?.photo != null &&
                                    meeting.photo.isNotEmpty)
                                ? NetworkImage(meeting.photo)
                                : AssetImage(
                                    "resourses/images/default_profile_icon.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(meeting?.name ?? '', style: TextStyle(fontSize: 20, color: ColorConstants.titleColor, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(meeting?.description ?? ''),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(icon, color: color, size: 40.0),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child:
                              Image.asset("resourses/images/location_icon.png"),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Container(
                        child: Text(
                          location,
                        ),
                        width: MediaQuery.of(context).size.width - 100,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.asset("resourses/images/time_icon.png"),
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    child: Text(
                      FormatConstants.defaultFormat.format(date) +
                          " " +
                          DateFormat.Hm().format(date),
                      maxLines: 1,
                    ),
                    width: MediaQuery.of(context).size.width - 100,
                    height: 20,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: ColorConstants.separatorColor,
            )
          ],
        ),
      ),
    );
  }
}
