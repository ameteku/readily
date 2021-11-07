import 'package:flutter/material.dart';

class NoteSlideShowPage extends StatefulWidget {
  const NoteSlideShowPage({Key? key, required this.title, required this.startingId, required this.noteIdList}) : super(key: key);

  final String title;
  final int startingId;
  final List<int> noteIdList;
  @override
  _NoteSlideShowPageState createState() => _NoteSlideShowPageState();
}

class _NoteSlideShowPageState extends State<NoteSlideShowPage> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: screenSize.height * 0.95,
              // This vertical scroll view has not been provided a
              // ScrollController, so it is using the
              // PrimaryScrollController.
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: screenSize.height * 0.03,
                controller: controller,
                child: ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          color: index.isEven ? Colors.amberAccent : Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Scrollable 2 : Index $index'),
                          ));
                    }),
              )),
        ));
  }
}
