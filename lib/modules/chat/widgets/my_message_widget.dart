import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room/models/message.dart';

class MyMessageWidget extends StatelessWidget {
  final Message message;

  const MyMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('EEE HH:mm');
    if (message?.image != null) {
      return GestureDetector(
        onTap: () => _onImageTap(context, message.image),
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.4),
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
                            ? format
                                .format(DateTime.parse(message.createdAt))
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
