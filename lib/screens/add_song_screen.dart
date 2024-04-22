// add_song_screen.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddSongScreen extends StatefulWidget {
  const AddSongScreen({super.key});

  @override
  State<AddSongScreen> createState() => _AddSongScreenState();
  }

  class _AddSongScreenState extends State<AddSongScreen> {

    TextEditingController title = TextEditingController();
    TextEditingController type = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController artist_id = TextEditingController();

    List list = [];

    //-----------GET DATA------

    Future GetData() async {
      var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/getData2.php";
      var res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        var red = jsonDecode(res.body);

        setState(() {
          list.addAll(red);
          _streamController.add(red);
        }
        );

        print(list);
      }
    }

//----------ADD DATA----------

    Future AddData() async {
      var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/addData2.php";
      var res = await http.post(Uri.parse(url), body: {
        'title': title.text,
        'type': type.text,
        'price': price.text,
        'artist_id': artist_id.text
      });

      if (res.statusCode == 200) {
        var red = jsonDecode(res.body);

        print(red);
      }
    }

//---------EDIT DATA----------

    Future EditData(id) async {
      var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/editData2.php";
      var res = await http.post(Uri.parse(url), body: {
        'id': id,
        'title': title.text,
        'type': type.text,
        'price': price.text,
        'artist_id': artist_id.text
      });

      if (res.statusCode == 200) {
        var red = jsonDecode(res.body);

        print(red);
      }
    }

//-----------DELETE DATA---------

    Future DeleteData(id) async {
      var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/deleteData2.php";
      var res = await http.post(Uri.parse(url), body: {
        'id': id,
      });

      if (res.statusCode == 200) {
        var red = jsonDecode(res.body);

        print(red);
      }
    }

    late StreamController <List<dynamic>> _streamController;
    late Stream <List<dynamic>>_stream;


    @override
    void initState() {
      super.initState();

      setState(() {
        _streamController = StreamController();
        _stream = _streamController.stream;
      });

      GetData();
    }


    AddArtist() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 350,
                child: Column(
                  children: [
                    TextFormField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Song Title',
                        )),

                    TextFormField(
                        controller: type,
                        decoration: const InputDecoration(
                          labelText: 'Song Type',
                        )),

                    TextFormField(
                        controller: price,
                        decoration: const InputDecoration(
                          labelText: 'Song Price',
                        )),

                    TextFormField(
                        controller: artist_id,
                        decoration: const InputDecoration(
                          labelText: 'Artist id',
                        )),

                    ElevatedButton(
                        onPressed: () {
                          print(title.text);
                          print(type.text);
                          print(price.text);
                          print(artist_id.text);
                          AddData();
                          GetData();
                          Navigator.pop(context);
                        },
                        child: Text("Send"))
                  ],

                ),
              ),
            );
          });
    }


    EditArtist(id) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 350,
                child: Column(
                  children: [
                    TextFormField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Song Title',
                        )),

                    TextFormField(
                        controller: type,
                        decoration: const InputDecoration(
                          labelText: 'Song Type',
                        )),

                    TextFormField(
                        controller: price,
                        decoration: const InputDecoration(
                          labelText: 'Song Price',
                        )),

                    TextFormField(
                        controller: artist_id,
                        decoration: const InputDecoration(
                          labelText: 'Artist id',
                        )),

                    ElevatedButton(
                        onPressed: () {
                          print(id);
                          print(title.text);
                          print(type.text);
                          print(price.text);
                          print(artist_id.text);
                          EditData(id);
                          GetData();
                          Navigator.pop(context);
                        },
                        child: Text("Send"))
                  ],

                ),
              ),
            );
          });
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('All Songs'),
          actions: [
            IconButton(
              onPressed: () {
                AddArtist();
              },
              icon: Icon(Icons.add, size: 35,),
            )
          ],
        ),
        body: StreamBuilder<List<dynamic>>(
          stream: _stream,
          builder: (stx, snp) {
            if (!snp.hasData) {
              return Container(
                child: Text("no data"),
              );
            } else if (snp.hasError) {
                return CircularProgressIndicator();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snp.data!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ListTile(
                              visualDensity: VisualDensity(vertical: 4),
                              title: Text("${snp.data![i]['title']} "),
                              // Display song title in the title
                              tileColor: Colors.grey.shade300,
                              subtitle: Column(
                                // Use a Column widget to display multiple lines in the subtitle
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Type: ${snp.data![i]['type']}"),
                                  // Display type in the first line of the subtitle
                                  Text("Price: ${snp.data![i]['price']} \$ "),
                                  // Display price in the second line of the subtitle
                                ],
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                child: Text(
                                  "${snp.data![i]["title"]
                                      .toString()
                                      .substring(0, 2)
                                      .toUpperCase()}",
                                ),
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        EditArtist(snp.data![i]["id"]);
                                      },
                                      icon: Icon(Icons.edit, color: Colors.teal),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        DeleteData(snp.data![i]["id"]);
                                        GetData();
                                      },
                                      icon: Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
    }
}
