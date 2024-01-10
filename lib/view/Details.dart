import 'package:flutter/material.dart';
import 'package:tracking_app/view/world_status.dart';

class CountyDetails extends StatefulWidget {
  final String image;
  final String name;
  final int todayCases, todayDeaths, todayRecovered, active, tests;

  CountyDetails({
    Key? key,
    required this.image,
    required this.name,
    required this.active,
    required this.todayDeaths,
    required this.tests,
    required this.todayCases,
    required this.todayRecovered,
  }) : super(key: key);

  @override
  State<CountyDetails> createState() => _CountyDetailsState();
}

class _CountyDetailsState extends State<CountyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Card(
                        child: Column(
                          children: [
                            ResuableRow(title: 'Cases', value: widget.todayCases.toString()),
                            ResuableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                            ResuableRow(title: 'Tests', value: widget.tests.toString()),
                            ResuableRow(title: 'Today Deaths', value: widget.todayDeaths.toString()),
                            ResuableRow(title: 'Active', value: widget.active.toString()),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
