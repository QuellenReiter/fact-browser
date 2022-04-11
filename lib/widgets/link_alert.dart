import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkAlert extends StatelessWidget {
  const LinkAlert({
    Key? key,
    required this.link,
    required this.msg,
    this.label = "",
    this.color,
  }) : super(key: key);
  final String link;
  final String msg;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: 100,
              minHeight: DeviceType.height(context) / 2,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      msg,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(DesignColors.red),
                      ),
                      onPressed: () async {
                        if (!await launch(link)) {
                          throw 'could not launch';
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Trotzdem fortfahren.",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Text(link),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: color ?? DesignColors.lightGrey),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.link_rounded,
          size: Theme.of(context).textTheme.subtitle2!.fontSize! + 5,
          color: color ?? DesignColors.lightGrey,
        ),
      ),
    );
  }
}
