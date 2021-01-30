import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room/models/message.dart';

class UserMessageWidget extends StatelessWidget {
  final Message message;

  const UserMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('EEE HH:mm');
    if (message.image != null) {
      return GestureDetector(
        onTap: () => _onImageTap(context, message.image),
        child: Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.4),
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              image: DecorationImage(
                image: NetworkImage(message.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
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
                  if (message?.nickname != null && (message?.nickname?.isNotEmpty ?? false))...[
                    Row(
                      children: [
                        Text(
                          message.nickname,
                          style: TextStyle(
                            color: Colors.blueAccent.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                  ],
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

  void _onImageTap(BuildContext buildContext, String imageUrl) {
    showGeneralDialog(
        context: buildContext,
        pageBuilder: (_, __, context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.pop(buildContext),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: SizedBox.expand(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}
