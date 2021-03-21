import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apod_web/notifier/astro_notifier.dart';
import 'package:flutter_apod_web/notifier/theme_notifier.dart';
import 'package:flutter_apod_web/service/api.dart';
import 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();
  DateTime selectedDate;
  @override
  void initState() {
    /* Initialize the current date with today's date and fetch Api */

    selectedDate = DateTime(now.year, now.month, now.day);
    AstrologyNotifier astrologyNotifier =
        Provider.of<AstrologyNotifier>(context, listen: false);
    AstrologyApi.getAstrologyApi(astrologyNotifier, selectedDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AstrologyNotifier astrologyNotifier =
        Provider.of<AstrologyNotifier>(context);
    /* Main Home screen Widget */
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Flutter Astrology Image',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: astrologyNotifier != null &&
              astrologyNotifier.getAstrology() != null
          ? Center(
              child: Container(
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    astrologyNotifier.getAstrology() != null
                        ? Container(
                            child: HtmlWidget(),
                            padding: EdgeInsets.all(12.0),
                            width: MediaQuery.of(context).size.width * 0.36,
                            height: MediaQuery.of(context).size.width * 0.36,
                          )
                        : CircularProgressIndicator(
                            color: Theme.of(context).indicatorColor,
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      astrologyNotifier.getAstrology().title,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.026,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      astrologyNotifier.getAstrology().date,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.020,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ArgonButton(
                      height: 50.0,
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.24,
                      borderRadius: 6.0,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Find',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      roundLoadingShape: true,
                      loader: Container(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          )),
                      elevation: 8.0,
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          startLoading();

                          final DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              AstrologyNotifier astrologyNotifier =
                                  Provider.of<AstrologyNotifier>(context,
                                      listen: false);
                              AstrologyApi.getAstrologyApi(
                                  astrologyNotifier, selectedDate);
                            });
                          }
                          stopLoading();
                        } else {
                          stopLoading();
                        }
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        "Switch Theme",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        //backgroundColor: Theme.of(context).buttonColor,
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Theme.of(context).buttonColor;
                            return Theme.of(context)
                                .appBarTheme
                                .color; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Provider.of<ThemesNotifier>(context, listen: false)
                            .switchTheme();
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      child: Text(
                        astrologyNotifier.getAstrology().explanation,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ))
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
                color: Theme.of(context).indicatorColor,
              ),
            ),
    );
  }
}

class HtmlWidget extends StatelessWidget {
  final String url;
  HtmlWidget({this.url});

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 4),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    AstrologyNotifier astrologyNotifier =
        Provider.of<AstrologyNotifier>(context);

    /* Html Image Widget */
    ui.platformViewRegistry.registerViewFactory(
        '${astrologyNotifier.getAstrology().title}',
        (int viewId) => ImageElement()
          ..src = '${astrologyNotifier.getAstrology().url}'
          ..style.imageRendering = '10.0'
          ..style.borderRadius = '25px'
          ..style.border = '2px solid #73AD21'
          ..style.boxShadow = '5px 10px blue');

    return HtmlElementView(
      viewType: '${astrologyNotifier.getAstrology().title}',
    );
  }
}
