import 'package:flutter/material.dart';

void main() => runApp(const RisingIndiaApp());

class RisingIndiaApp extends StatelessWidget {
  const RisingIndiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rising India',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ['Education', Icons.school_rounded, 'Education, scholarships, study material and career guidance.'],
      ['Health', Icons.health_and_safety_rounded, 'Health information and assistance.'],
      ['Farming', Icons.agriculture_rounded, 'Farmer support and rural development.'],
      ['Self Help Group', Icons.groups_rounded, 'Livelihood and community development support.'],
      ['Assistance', Icons.volunteer_activism_rounded, 'Request assistance from Rising India.'],
      ['Gallery', Icons.photo_library_rounded, 'Photos and videos of NGO activities.'],
      ['Contact Us', Icons.call_rounded, 'Connect with Rising India.'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('RISING INDIA', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.public_rounded, color: Colors.white, size: 44),
                SizedBox(height: 14),
                Text('WELCOME TO RISING INDIA',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text('Together for education, health, livelihoods and stronger communities.',
                    style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.08,
            ),
            itemBuilder: (context, i) {
              final item = items[i];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InfoPage(
                        title: item[0] as String,
                        icon: item[1] as IconData,
                        body: item[2] as String,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item[1] as IconData, size: 38,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 10),
                      Text(item[0] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.info_outline_rounded)),
              title: Text('About Rising India', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Education • Health • Farming • Community'),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String body;

  const InfoPage({super.key, required this.title, required this.icon, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(radius: 34, child: Icon(icon, size: 36)),
          const SizedBox(height: 20),
          Text(title, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(body, style: const TextStyle(fontSize: 16, height: 1.55)),
            ),
          ),
          if (title == 'Education') ...[
            const SizedBox(height: 14),
            _Tile('Student Registration', Icons.person_add_alt_1),
            _Tile('Scholarship Assistance', Icons.workspace_premium),
            _Tile('Study Material', Icons.menu_book_rounded),
            _Tile('Career Guidance', Icons.explore_rounded),
          ],
          if (title == 'Assistance') ...[
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _dialog(context),
              icon: const Icon(Icons.edit_note_rounded),
              label: const Text('Submit Assistance Request'),
            ),
          ],
        ],
      ),
    );
  }

  void _dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Assistance Request'),
        content: const Text('Online submission will be connected to Firebase in the next release.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final IconData icon;
  const _Tile(this.title, this.icon);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    child: ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}
