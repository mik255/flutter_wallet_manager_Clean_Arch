

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SelectString extends StatefulWidget {
  const SelectString({
    super.key,
    required this.list,
    required this.onSelect,
  });

  final List<String> list;
  final Function(String) onSelect;

  @override
  State<SelectString> createState() => _SelectStringState();
}

class _SelectStringState extends State<SelectString> {
  List<String> currentList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    currentList = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Pesquisar',
              ),
              onChanged: _search,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      widget.onSelect(currentList[index]);
                      Navigator.pop(context, currentList[index]);
                    },
                    child: ListTile(
                      title: Text(currentList[index]),
                    ).animate(
                      effects: [const SlideEffect(begin: Offset(0, -0.5), end: Offset.zero), const FadeEffect()],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _search(String value) {
    setState(() {
      currentList = widget.list.where((element) => element.contains(value)).toList();
    });
  }
}