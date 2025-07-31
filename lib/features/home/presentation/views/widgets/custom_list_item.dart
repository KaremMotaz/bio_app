import 'package:flutter/material.dart';

class CustomListItem extends StatefulWidget {
  const CustomListItem({super.key});

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  bool isExpanded = false;
  int? selectedIndex;
  List<Map<String, dynamic>> reciters = [
    {
      "name": "ماهر المعيقلي",
      "tracks": [
        "المصحف المجود - المصحف المجود",
        "المصحف المعلم - المصحف المعلم",
        "حفص عن عاصم - مرتل",
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              reciters[0]['name'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: const CircleAvatar(
              backgroundColor: Color(0xff2d6677),
              child: Icon(Icons.mic, color: Colors.white),
            ),
            trailing: isExpanded
                ? const Icon(Icons.expand_less, size: 30)
                : const Icon(Icons.expand_more, size: 30),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reciters[0]['tracks'].length,
              itemBuilder: (context, index) {
                final item = reciters[0]['tracks'][index];
                final isSelected = selectedIndex == index;
                return Container(
                  color: isSelected ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
