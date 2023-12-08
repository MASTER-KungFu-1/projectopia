import 'package:flutter/material.dart';
import 'package:projectopia/screens/lobby_screen.dart';
import 'settings1.dart';

class Aianalize extends StatefulWidget {
  const Aianalize({Key? key}) : super(key: key);

  @override
  _AianalizeState createState() => _AianalizeState();
}

class _AianalizeState extends State<Aianalize> {
  List<String> levels = ['Инди', 'AA', 'AAA'];
  List<String> graphics = ['Мультяшная', 'Реалистичная'];
  List<String> gameModes = ['Одиночный', 'Мультиплеер', 'Кооператив'];
  List<String> genres = [
    'Экшн',
    'Приключения',
    'Стратегия',
    'Головоломка',
    'Ролевая'
  ];
  List<String> platforms = [
    'PC',
    'PlayStation',
    'Xbox',
    'Nintendo Switch',
    'Mobile'
  ];

  String _selectedLevel = '';
  String _selectedGraphics = '';
  String _selectedGameMode = '';
  String _selectedGenre = '';
  String _selectedPlatform = '';

  @override
  Widget build(BuildContext context) {
    void navMenuTapped(int index) {
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Lobby()));
      } else if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Settings2()));
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Анализ проекта'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: navMenuTapped,
          selectedItemColor: const Color.fromARGB(255, 93, 176, 239),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: "Проекты",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "AI Анализ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Настройки",
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildDropdown(
                'Уровень игры',
                levels,
                _selectedLevel,
                (newValue) {
                  setState(() {
                    _selectedLevel = newValue.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              buildDropdown(
                'Графика',
                graphics,
                _selectedGraphics,
                (newValue) {
                  setState(() {
                    _selectedGraphics = newValue.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              buildDropdown(
                'Режим игры',
                gameModes,
                _selectedGameMode,
                (newValue) {
                  setState(() {
                    _selectedGameMode = newValue.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              buildDropdown(
                'Жанр',
                genres,
                _selectedGenre,
                (newValue) {
                  setState(() {
                    _selectedGenre = newValue.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              buildDropdown(
                'Платформа',
                platforms,
                _selectedPlatform,
                (newValue) {
                  setState(() {
                    _selectedPlatform = newValue.toString();
                  });
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 166, 202, 230))),
                onPressed: () {},
                child: const Text('Провести анализ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Функция для создания выпадающего списка
  Widget buildDropdown(String label, List<String> items, String selectedValue,
      Function(dynamic) onChanged) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: selectedValue.isNotEmpty ? selectedValue : null,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
