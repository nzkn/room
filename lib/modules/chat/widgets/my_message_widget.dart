import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room/models/message.dart';

class MyMessageWidget extends StatelessWidget {
  final Message message;

  const MyMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('EEE HH:mm');
    return Row(
      children: [
        const SizedBox(width: 30.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                          ? format.format(DateTime.parse(message.createdAt))
                          .toString()
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
      ],
    );
  }
}
