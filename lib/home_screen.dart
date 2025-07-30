import 'package:flutter/material.dart';
import 'package:lisa_game_hub/2048_game/game_2048_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tools = [
      {"icon": Icons.edit, "label": "Sign", "type": "sign"},
      {"icon": Icons.merge, "label": "Merge to PDF", "type": "merge"},
      {"icon": Icons.edit_note, "label": "Edit PDF", "type": "edit"},
      {"icon": Icons.view_compact_alt, "label": "View PDF", "type": "view"},
    ];

    final List<Map<String, dynamic>> toolsConvert = [
      {"icon": Icons.image, "label": "PDF to Image", "type": "pdftoimage"},
      {"icon": Icons.device_hub, "label": "Slip PDF", "type": "slip"},
      {"icon": Icons.image, "label": "PDF to Image", "type": "pdftoimage"},
      {"icon": Icons.device_hub, "label": "Slip PDF", "type": "slip"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Games Offline',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Puzzle Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildGrid(tools),

              const SizedBox(height: 28),
              const Text(
                'Music Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildGrid(toolsConvert),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> tools) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tools.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return _buildToolItem(
          context,
          tools[index]['label'],
          tools[index]['icon'],
          tools[index]['type'],
        );
      },
    );
  }

  Widget _buildToolItem(
    BuildContext context,
    String label,
    IconData iconData,
    String type,
  ) {
    return GestureDetector(
      onTap: () {
        if (type == 'merge') {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SelectMultipleFilesScreen(type: type),
          //   ),
          // );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Game2048Screen(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(iconData, size: 36, color: Colors.blueAccent),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'PDF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
