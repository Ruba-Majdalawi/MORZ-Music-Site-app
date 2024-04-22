
// all_songs_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:morzmusicsite/models/song.dart';
import 'package:morzmusicsite/screens/buy_song_screen.dart';


class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {

  List<Song> songs = [];

  Future GetData() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/getData2.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body) as List;
      setState(() {
        songs = (jsonDecode(res.body) as List)
            .map((json) => Song.fromJson(json))
            .toList();
      }
      );
       print(red);
    }
  }

  List Data =[];

  Future Suggestion() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/suggestion2.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      for(int i=0 ; i<data.length ; i++){
        setState(() {
          Data.add(data[i]['title']);
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
          title: const Text('All Songs'),
          actions: [
            IconButton(

                onPressed: (){
                  showSearch(context: context, delegate: SearchSong(data: Data));
                },
                icon: Icon(Icons.search)
            )
          ],
        ),
        body: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (cts, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: 4),
                      title: Text("${songs[i].title}"),
                      // Display firstName and lastName in the title
                      tileColor: Colors.grey.shade300,
                      subtitle: Column( // Use a Column widget to display multiple lines in the subtitle
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Type: ${songs[i].type}"),
                          // Display gender in the first line of the subtitle
                          Text("Price: ${songs[i].price} \$ "),
                          // Display country in the second line of the subtitle
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text("${songs[i].title.toString().substring(0, 2).toUpperCase()}",),

                      ),
                      trailing: Container(width: 100,
                         child: Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Spacer(),
                             IconButton(
                             onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BuySongScreen(songDetials: songs[i],)));
                        },
                                icon: Icon(Icons.add_shopping_cart, color: Colors.teal),
                      ),
                    ])
                ),
              )));
            }
        )
    );
  }
}

class SearchSong extends SearchDelegate{
  List data = [];
  SearchSong({required this.data});

  Future GetSongData() async{
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/search2.php";
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
        future: GetSongData(),
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
                        child: Text("${snp.data[index]["title"].toString().substring(0, 2).toUpperCase()}",),

                      ),
                      title: Text("${snp.data[index]['title']}"),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${snp.data[index]['type']}"),
                            Text("${snp.data[index]['price']}\$"),

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