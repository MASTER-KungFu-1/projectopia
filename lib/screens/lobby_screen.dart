import 'package:flutter/material.dart';
import 'package:projectopia/screens/settings1.dart';
import 'ai_analize.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  late TextEditingController searchController;

  List<Project> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    filteredProjects = projects;
    searchController = TextEditingController();
    searchController.addListener(filterProjects);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProjects() {
    final searchText = searchController.text.toLowerCase();
    setState(() {
      filteredProjects = projects.where((project) {
        final name = project.name.toLowerCase();
        return name.contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    void navMenuTapped(int index) {
      if (index == 1) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Aianalize()));
      } else if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Settings2()));
      }
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Проекты'),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Хотите найти проект?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Введите название проекта',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: searchController,
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(filteredProjects[index].name),
                        subtitle: Text(filteredProjects[index].description),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Project {
  final String name;
  final String description;

  Project({required this.name, required this.description});
}

List<Project> projects = [
  Project(
    name: 'Управление персоналом в компании',
    description:
        'Разработка системы для автоматизации управления персоналом и HR процессов.',
  ),
  Project(
    name: 'Мобильное приложение для онлайн-торговли',
    description:
        'Создание мобильного приложения для продажи товаров с функциями онлайн-оплаты и управления заказами.',
  ),
  Project(
    name: 'Система управления задачами',
    description:
        'Разработка платформы для эффективного управления задачами и проектами в команде.',
  ),
  Project(
    name: 'Блоговая платформа',
    description:
        'Создание платформы для публикации статей, блогов и обмена информацией.',
  ),
  Project(
    name: 'CRM-система для управления клиентами',
    description:
        'Разработка системы для хранения и управления информацией о клиентах и взаимодействии с ними.',
  ),
  Project(
    name: 'Приложение для бронирования отелей',
    description:
        'Создание приложения, позволяющего пользователям бронировать номера в отелях и проводить онлайн-оплату.',
  ),
  Project(
    name: 'Сервис для обмена файлами',
    description:
        'Разработка платформы для обмена и хранения файлов между пользователями.',
  ),
  Project(
    name: 'Платформа для онлайн-обучения',
    description:
        'Создание платформы для обучения и онлайн-курсов с возможностью прохождения тестов и получения сертификатов.',
  ),
  Project(
    name: 'Приложение для фитнес-тренировок',
    description:
        'Разработка мобильного приложения для тренировок и поддержки здорового образа жизни.',
  ),
  Project(
    name: 'Платформа для онлайн-бронирования туров',
    description:
        'Создание платформы для бронирования туров и экскурсий по разным направлениям.',
  ),
];
