import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tracking_app/Services/states_services.dart';
import 'package:tracking_app/view/Details.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key});

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();
  final searchbar = TextEditingController();
@override
void dispose(){
  _controller.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Countries List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            child: TextFormField(
              controller: searchbar,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      controller: _controller,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String N = snapshot.data![index]['country'];
                      if (searchbar.text.isEmpty ||
                          N.toLowerCase().contains(searchbar.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountyDetails(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  active: int.tryParse(snapshot.data![index]['active'].toString()) ?? 0,
                                  todayDeaths: int.tryParse(snapshot.data![index]['todayDeaths'].toString()) ?? 0,
                                  tests: int.tryParse(snapshot.data![index]['tests'].toString()) ?? 0,
                                  todayCases: int.tryParse(snapshot.data![index]['todayCases'].toString()) ?? 0,
                                  todayRecovered: int.tryParse(snapshot.data![index]['todayRecovered'].toString()) ?? 0,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                            leading: Image(
                              height: 50.0,
                              width: 50.0,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                            ),
                          ),
                        );
                      } else {
                        return Container(); // This item doesn't match the search, so don't display it.
                      }
                    },
                  );
                }
              },
              future: statesServices.countryapi(),
            ),
          ),
        ],
      ),
    );
  }
}
