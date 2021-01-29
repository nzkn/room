import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room/models/message.dart';

class UserMessageWidget extends StatelessWidget {
  final Message message;

  const UserMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('EEE HH:mm');
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (message?.nickname != null && (message?.nickname?.isNotEmpty ?? false))
                  Row(
                    children: [
                      Text(
                        message.nickname,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message?.message ?? '',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message?.createdAt != null
                          ? format.format(DateTime.parse(message.createdAt)).toString()
                          : '',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 30.0),
      ],
    );
  }
}
