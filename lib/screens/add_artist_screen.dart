// add_artist_screen.dart

  import 'dart:async';
  import 'dart:convert';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;


  class AddArtistScreen extends StatefulWidget {
  const AddArtistScreen({super.key});

  @override
  State<AddArtistScreen> createState() => _AddArtistScreenState();
  }

  class _AddArtistScreenState extends State<AddArtistScreen> {

    TextEditingController firstName= TextEditingController();
    TextEditingController lastName= TextEditingController();
    TextEditingController gender= TextEditingController();
    TextEditingController country= TextEditingController();

    List list = [];

 //-----------GET DATA------

  Future GetData() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/getData.php";
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

  Future AddData()async{
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/addData.php";
    var res = await http.post(Uri.parse(url), body: {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'gender': gender.text,
      'country': country.text
     });

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      print(red);
    }
  }

//---------EDIT DATA----------

  Future EditData(id)async{
    var url="https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/editData.php";
    var res = await http.post(Uri.parse(url), body:{
      'id':id,
      'firstName':firstName.text,
      'lastName':lastName.text,
      'gender':gender.text,
      'country':country.text
    });

    if(res.statusCode == 200){
      var red = jsonDecode(res.body);

      print(red);
    }
  }

//-----------DELETE DATA---------

  Future DeleteData(id)async{
    var url ="https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/deleteData.php";
    var res = await http.post(Uri.parse(url), body:{
      'id': id,
    });

    if(res.statusCode == 200){
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



  AddArtist(){
    showDialog(
        context: context,
        builder: (context){
      return AlertDialog(
        content: Container(
          height: 350,
          child: Column(
            children: [
              TextFormField(
                controller: firstName,
                decoration: const InputDecoration(
                  labelText: 'Artist first-name',
              )),

              TextFormField(
                controller: lastName,
                 decoration: const InputDecoration(
                 labelText: 'Artist last-name',
              )),

              TextFormField(
                controller: gender,
                decoration: const InputDecoration(
                  labelText: 'Artist gender',
                )),

              TextFormField(
                controller: country,
                decoration: const InputDecoration(
                  labelText: 'Artist country',
                )),

              ElevatedButton(
                  onPressed: (){
                    print(firstName.text);
                    print(lastName.text);
                    print(gender.text);
                    print(country.text);
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


  EditArtist(id){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Container(
                height: 350,
                child: Column(
                  children: [
                    TextFormField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          labelText: 'Artist first-name',
                        )),

                    TextFormField(
                        controller: lastName,
                        decoration: const InputDecoration(
                          labelText: 'Artist last-name',
                        )),

                    TextFormField(
                        controller: gender,
                        decoration: const InputDecoration(
                          labelText: 'Artist gender',
                        )),

                    TextFormField(
                        controller: country,
                        decoration: const InputDecoration(
                          labelText: 'Artist country',
                        )),

                    ElevatedButton(
                        onPressed: (){
                          print(id);
                          print(firstName.text);
                          print(lastName.text);
                          print(gender.text);
                          print(country.text);
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
         title: const Text('All Artists'),
         actions: [
           IconButton(
               onPressed: (){
                 AddArtist();
               },
               icon: Icon(Icons.add, size: 35,))
         ],
        ),

        body: StreamBuilder <List<dynamic>>(
             stream: _stream,
             builder: (stx, snp) {
               if (!snp.hasData) {
                 return Container(
                   child: Text("no data"),
                 );
               }
               else if (snp.hasError) {
                 return CircularProgressIndicator();
               }
               else {
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
                               title: Text("${snp.data![i]['firstName']} ${snp.data![i]['lastName']}"),
                               // Display firstName and lastName in the title
                               tileColor: Colors.grey.shade300,
                               subtitle: Column( // Use a Column widget to display multiple lines in the subtitle
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("Gender: ${snp.data![i]['gender']}"),
                                   // Display gender in the first line of the subtitle
                                   Text("Country: ${snp.data![i]['country']}"),
                                   // Display country in the second line of the subtitle
                                 ],
                               ),
                               leading: CircleAvatar(
                                 radius: 30,
                                 child: Text(
                                   "${snp.data![i]["firstName"].toString()
                                       .substring(0, 1)
                                       .toUpperCase()}${snp.data![i]["lastName"]
                                       .toString().substring(0, 1)
                                       .toUpperCase()}",),
                               ),
                               trailing: Container(
                                   width: 100,
                                   child: Row(
                                     children: [

                                       IconButton(onPressed: () {
                                         EditArtist(snp.data![i]["id"]);
                                       },
                                           icon: Icon(Icons.edit, color: Colors.teal)),

                                       IconButton(onPressed: () {
                                         DeleteData(snp.data![i]["id"]);
                                         GetData();
                                       },
                                           icon: Icon(Icons.delete, color: Colors.red)),
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