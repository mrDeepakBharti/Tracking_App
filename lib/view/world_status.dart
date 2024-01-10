import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tracking_app/Modal/Worldstatesmodal.dart';
import 'package:tracking_app/Services/states_services.dart';
import 'package:http/http.dart'as http;
import 'package:tracking_app/view/countries_list.dart';

class World_status extends StatefulWidget {
  const World_status({super.key});

  @override
  State<World_status> createState() => _World_statusState();
}

class _World_statusState extends State<World_status> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  final colorList=[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.01,),
            FutureBuilder(future: statesServices.worldstatesapi(), builder: (BuildContext context,AsyncSnapshot<Worldstatesmodal>snapshot){
              //final data=snapshot.data!;

              if(snapshot.hasData){
                return
                        Column(
                  children: [
                    PieChart(dataMap: {
                      "Total":double.parse(snapshot.data!.cases.toString()),
                      "Recovered":double.parse(snapshot.data!.active.toString()),
                      "Death":double.parse(snapshot.data!.deaths.toString()),
                    },chartRadius: MediaQuery.of(context).size.width/3.2,
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                      ),
                      animationDuration: Duration(milliseconds: 1200),
                      legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left
                      ),
                      chartType: ChartType.ring,
                      colorList: colorList,

                    ),

                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 50.0),
                      child: Card(

                        child:Container(
                          color:Colors.white70,
                          child: Column(
                            children: [
                              ResuableRow(title: 'cases',value: snapshot.data!.cases.toString(),),
                              ResuableRow(title: 'deaths',value: snapshot.data!.deaths.toString(),),
                              ResuableRow(title: 'active',value: snapshot.data!.active.toString(),),
                              ResuableRow(title: 'affectedCountries',value: snapshot.data!.affectedCountries.toString(),),
                              ResuableRow(title: 'casesPerOneMillion',value: snapshot.data!.casesPerOneMillion.toString(),),
                              ResuableRow(title: 'critical',value: snapshot.data!.critical.toString(),),
                              ResuableRow(title: 'recovered',value: snapshot.data!.recovered.toString(),)

                            ],
                          ),
                        ),

                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
              },
                      child: Container(
                        height: 50.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        child: Center(child: Text('Track',style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),)),
                      ),
                    )
                  ],
                );
              }else{
                return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ));
              }
            }),

          ],),
      )),
    );
  }
}

class ResuableRow extends StatelessWidget {
   ResuableRow({super.key,required this.title,required this.value});
 String title,value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 10.0,left: 10.0,bottom: 10.0),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text(title),
              Text(value),

            ],
          ),
          SizedBox(height: 5),
        Divider(
          thickness: 2,
        )
        ],
      ),
    );
  }
}
