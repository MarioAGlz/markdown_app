import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markdown Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Markdown Editor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late TextEditingController _textEditingController;
  String textPreview = "";

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(controller: _controller, tabs: const [
            Tab(
              child: Text('Editing'),
            ),
            Tab(
              child: Text("Preview"),
            ),
          ]),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: "Input Text",
                ),
                onChanged: (String text) {
                  setState(() {
                    textPreview = text;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: MarkdownBody(data: textPreview),
            ),
          ],
        ));
  }
}
