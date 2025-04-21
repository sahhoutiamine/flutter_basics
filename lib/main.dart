import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Page d\'accueil Flutter'),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _genre = 'Homme';
  bool _codage = false;
  bool _design = false;
  bool _gaming = false;
  DateTime _selectedDate = DateTime.now();
  double _competenceLevel = 1.0;
  String _formation = 'Informatique';
  bool _notifications = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(height: 10),
                Text('Menu de Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
                Text('Application Flutter', style: TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Aide'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrez votre nom :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Votre nom'),
            ),
            SizedBox(height: 16),
            Text('Entrez votre âge :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Votre âge'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text('Genre :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(children: [
              Radio<String>(
                value: 'Homme',
                groupValue: _genre,
                onChanged: (value) => setState(() => _genre = value!),
              ),
              Text('Homme'),
              SizedBox(width: 20),
              Radio<String>(
                value: 'Femme',
                groupValue: _genre,
                onChanged: (value) => setState(() => _genre = value!),
              ),
              Text('Femme'),
            ]),
            SizedBox(height: 16),
            Text('Centres d\'intérêt :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text('Codage'),
              value: _codage,
              onChanged: (value) => setState(() => _codage = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Design'),
              value: _design,
              onChanged: (value) => setState(() => _design = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Jeux vidéo'),
              value: _gaming,
              onChanged: (value) => setState(() => _gaming = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 16),
            Text('Date de naissance :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(children: [
              Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
              Spacer(),
              ElevatedButton(onPressed: () => _selectDate(context), child: Text('Sélectionner')),
            ]),
            SizedBox(height: 16),
            Text('Niveau en programmation (1-5) :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(children: [
              Text('Débutant'),
              Expanded(
                child: Slider(
                  value: _competenceLevel,
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  label: _competenceLevel.round().toString(),
                  onChanged: (value) => setState(() => _competenceLevel = value),
                ),
              ),
              Text('Expert'),
            ]),
            SizedBox(height: 16),
            Text('Formation :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _formation,
              onChanged: (newValue) => setState(() => _formation = newValue!),
              items: <String>['Informatique', 'Design', 'Marketing', 'Gestion'].map((value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recevoir des notifications :', style: TextStyle(fontSize: 16)),
                Switch(value: _notifications, onChanged: (value) => setState(() => _notifications = value)),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String nom = _nomController.text;
                  String age = _ageController.text;

                  String message = 'Profil : $nom, $age ans, $_genre\n';
                  message += 'Formation : $_formation\n';
                  message += 'Date de naissance : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}\n';
                  message += 'Niveau : ${_competenceLevel.round()}/5\n';
                  message += 'Intérêts : ';
                  if (_codage) message += 'Codage, ';
                  if (_design) message += 'Design, ';
                  if (_gaming) message += 'Jeux vidéo, ';
                  message += '\nNotifications : ${_notifications ? "Oui" : "Non"}';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Profil complet'),
                      content: Text(message),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Fermer'))],
                    ),
                  );
                },
                child: Text('Valider'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100),
            SizedBox(height: 20),
            Text('Page de Profil', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Paramètres')), body: Center(child: Text('Page Paramètres')));
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Aide')), body: Center(child: Text('Page d\'Aide')));
  }
}
