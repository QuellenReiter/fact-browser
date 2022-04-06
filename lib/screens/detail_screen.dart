import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';
import '../widgets/display/fact_display_container.dart';

//ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen(
      {Key? key,
      required this.statement,
      required this.onLogin,
      required this.title,
      required this.isLoggedIn})
      : super(key: key);
  final bool isLoggedIn;
  Statement statement;
  final String title;
  final Function onLogin;

  @override
  Widget build(BuildContext context) {
    List<Widget> factContainers = List.generate(
      statement.statementFactchecks.facts.length,
      (int i) => FactDisplayContainer(
        fact: statement.statementFactchecks.facts[i],
      ),
    );

    return Scaffold(
      appBar: MainAppBar(
        title: title,
        onLogin: onLogin,
        loggedIn: isLoggedIn,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 1000),
          height: DeviceType.height(context),
          child: ListView(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            children: [
              FractionallySizedBox(
                widthFactor: 1.1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                  child: Wrap(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                        label: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            "zurück",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  alignment: Alignment.topLeft,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[200],
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1.1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: FractionallySizedBox(
                                widthFactor:
                                    DeviceType.width(context) < 600 ? 0.8 : 0.5,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AspectRatio(
                                        aspectRatio: 4 / 3,
                                        child: Container(
                                            decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              statement.statementPictureURL !=
                                                      ""
                                                  ? statement
                                                      .statementPictureURL
                                                      .replaceAll(
                                                          "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                                          "")
                                                  : "https://quellenreiter.app/assets/logo-pink.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      color: const Color.fromARGB(61, 0, 0, 0),
                                      child: Text(
                                        statement.samplePictureCopyright.trim(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color(0xFF0999bc),
                                        ),
                                        child: Text(
                                          statement.statementText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                  color: Colors.grey[200]),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: statement
                                                      .statementCorrectness !=
                                                  CorrectnessCategory.correct
                                              ? const Color(0xFFD55C00)
                                              : const Color(0xFF009E74),
                                        ),
                                        child: Text(
                                          statement.statementCorrectness,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Flex(
                            direction: DeviceType.width(context) < 400
                                ? Axis.vertical
                                : Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Text(statement.statementAuthor),
                                    ],
                                  ),
                                  DeviceType.width(context) < 400
                                      ? const SizedBox.shrink()
                                      : const Divider(
                                          height: 20,
                                        ),
                                  Row(
                                    children: [
                                      const Icon(Icons.newspaper),
                                      Text(statement.statementMedia +
                                          ' | ' +
                                          statement.statementMediatype),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      Text(statement.dateAsString()),
                                    ],
                                  ),
                                  DeviceType.width(context) < 400
                                      ? const SizedBox.shrink()
                                      : const Divider(
                                          height: 20,
                                        ),
                                  Row(
                                    children: [
                                      const Icon(Icons.language),
                                      Text(statement.statementLanguage),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: factContainers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
