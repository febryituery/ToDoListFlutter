import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> listTodo = new List<String>();
  final todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 4),
                      child: Icon(Icons.add, size: 20,color: Colors.blueAccent,),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 4, right: 16, top: 16, bottom: 16),
                      child: Text("Tambahkan to do"),
                    ),
                    flex: 9,
                  )
                ],
              ),
              onTap: () {
                showBottomAddEtalase(context);
              },
            ),
            Container(height: 1, color: Colors.black12,),
            listTodo.length > 0 || listTodo == null ?
            ListView.builder(
              itemCount: listTodo.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: Text("${listTodo.elementAt(index)}"),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                      Container(height: 1, color: Colors.black12,)
                    ],
                  ),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${listTodo.elementAt(
                            index)} selesai"),
                          duration: Duration(seconds: 1),));
                    setState(() {
                      listTodo.removeAt(index);
                    });
                  },
                  background: new Container(
                    color: Colors.green,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 18, top: 4),
                          child: Icon(
                            Icons.done, size: 20, color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          child: new Text("Finish",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ) : Container(
              margin: EdgeInsets.all(16), child: Text("Belum ada to do"),)
          ],
        ),
      ),
    );
  }

  showBottomAddEtalase(BuildContext context) async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery
                .of(context)
                .viewInsets,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: new Wrap(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Tambah To Do',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                todoController.clear();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: InkWell(
                                    child: Icon(Icons.close, size: 18,)),
                              ),
                            ),
                          )
                        ],)
                  ),
                  Divider(),
                  TextField(
                    controller: todoController,
                    autofocus: true,
                    maxLines: 1,
                    maxLength: 100,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 15.0),
                      hintText: "Tulis To Do",
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 50.0,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: new RaisedButton(
                      child: Text(
                        "Tambah".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0),
                      ),
                      onPressed: () {
                        setState(() {
                          listTodo.add(todoController.text);
                        });
                        Navigator.pop(context);
                        todoController.clear();
                      },
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}