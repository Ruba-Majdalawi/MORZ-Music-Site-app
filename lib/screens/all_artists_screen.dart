// all_artists_screen.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AllArtistsScreen extends StatefulWidget {
  const AllArtistsScreen({super.key});

  @override
  State<AllArtistsScreen> createState() => _AllArtistsScreenState();
}

class _AllArtistsScreenState extends State<AllArtistsScreen> {

  List list = [];

  Future GetData() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/getData.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        list.addAll(red);
      }
      );

      print(list);
    }
  }

  List Data =[];

  Future Suggestion() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/suggestion.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      for(int i=0 ; i<data.length ; i++){
        setState(() {
          Data.add(data[i]['firstName']);
        });
      }
    }
    print(Data);
  }



  @override
  void initState() {
    super.initState();
    Suggestion();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Artists'),
          actions: [
            IconButton(

              onPressed: (){
                  showSearch(context: context, delegate: SearchArtist(data: Data));
             },
              icon: Icon(Icons.search)
            )
          ],
        ),

        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (cts, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
            child: Container(
            child: ListTile(
              visualDensity: VisualDensity(vertical: 4),
              title: Text("${list[i]['firstName']} ${list[i]['lastName']}"),
              // Display firstName and lastName in the title
              tileColor: Colors.grey.shade300,
              subtitle: Column( // Use a Column widget to display multiple lines in the subtitle
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gender: ${list[i]['gender']}"),
                  // Display gender in the first line of the subtitle
                  Text("Country: ${list[i]['country']}"),
                  // Display country in the second line of the subtitle
                ],
              ),
              leading: CircleAvatar(
                radius: 30,
                child: Text("${list[i]["firstName"].toString().substring(0, 1).toUpperCase()}${list[i]["lastName"].toString().substring(0, 1).toUpperCase()}",),

              ),
            )
    ),
        );
    }
        )
    );
  }
}


class SearchArtist extends SearchDelegate{
  List data = [];
  SearchArtist({required this.data});

  Future GetArtistData() async{
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/search.php";
    var res = await http.post(Uri.parse(url), body:{
      "query": query
    } );

    if (res.statusCode == 200) {
      var artistdata = jsonDecode(res.body);

      return artistdata;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(onPressed: () {
        query ='';
    },
        icon: Icon(Icons.close))

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
           close(context, null);
     },
        icon: Icon(Icons.arrow_back));
   }

  @override
  Widget buildResults(BuildContext context) {
   return FutureBuilder<dynamic>(
       future: GetArtistData(),
       builder: (stx, snp){
         if(!snp.hasData){
           return Center(child: Text('no data'),);
         }
         else if (snp.hasError){
           return Center(child: CircularProgressIndicator(),);
         }
         else {
           return SingleChildScrollView(
               child: Column(
                children: [
                 ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                     itemCount: snp.data.length,
                    itemBuilder: (ctx, index){
                      return ListTile(
                         leading: CircleAvatar(
                          radius: 30,
                          child: Text("${snp.data[index]["firstName"].toString().substring(0, 1).toUpperCase()}${snp.data[index]["lastName"].toString().substring(0, 1).toUpperCase()}",),

                   ),
                        title: Text("${snp.data[index]['firstName']} ${snp.data[index]['lastName']}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("${snp.data[index]['gender']}"),
                          Text("${snp.data[index]['country']}"),

              ] )
               );
             }
             )
               ]
               )
           );
       }}
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var datasuggestion = query.isEmpty ? data : data.where((element) => element.toString().toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemCount: datasuggestion.length,
        itemBuilder: (ctn, index) {
          return ListTile(
            onTap: (){
              query = datasuggestion[index];
              showResults(context);
            },
            title: Text('${datasuggestion[index]}'),
          );
        }
    );
  }
}