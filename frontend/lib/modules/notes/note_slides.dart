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
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: screenSize.height * 0.95,
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: screenSize.height * 0.03,
                controller: controller,
                child: ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.noteIdList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: screenSize.width * 0.8,
                        color: index.isEven ? Colors.amberAccent : Colors.blueAccent,
                        // child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: FittedBox(
                        //     fit: BoxFit.cover,
                        //     child: Image.memory(element!, width: 110, height: 200),
                        //   ),
                        // )
                      );
                    }),
              )),
        ));
  }
}
