import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter AppBar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> universities = [
    {
      'name': 'Астана медицина университеті',
      'city': 'Нұр-Сұлтан',
      'phone': '8(7172)53 94 24',
      'imagePath': 'assets/images/Астана.jpg',
      'programs': 'Medical programs, Nursing programs, etc.',
    },
    {
      'name': 'С.Сейфуллин атындағы Қазақ агротехникалық университеті',
      'city': 'Нұр-Сұлтан',
      'phone': '8(7172)53 94 24',
      'imagePath': 'assets/images/С.Суйфуллин.jpg',
      'programs': 'Agricultural Engineering, Agribusiness, etc.',
    },
    {
      'name':
          'Ш.Есенов атындағы Каспий мемлекеттік технологиялар және инжиниринг университеті',
      'city': 'Нұр-Сұлтан',
      'phone': '8(7172)53 94 24',
      'imagePath': 'assets/images/Ш.Есенов.jpg',
      'programs': 'Engineering, Information Technology, etc.',
    },
    {
      'name':
          'М.Оспанов атындағы батыс қазақстан мемлекеттік медицина университеті',
      'city': 'Нұр-Сұлтан',
      'phone': '8(7172)53 94 24',
      'imagePath': 'assets/images/М.Оспанов.jpg',
      'programs': 'Medical programs, Health Sciences, etc.',
    },
  ];
  List<Map<String, String>> filteredUniversities = [];

  @override
  void initState() {
    super.initState();
    filteredUniversities = universities;
    _searchController.addListener(_filterUniversities);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUniversities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredUniversities = universities.where((university) {
        final name = university['name']!.toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void _navigateToDetailScreen(String name, String city, String phone,
      String imagePath, String programs) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversityDetailScreen(
          name: name,
          city: city,
          phone: phone,
          imagePath: imagePath,
          programs: programs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'УНИВЕРСИТЕТТЕР ТІЗІМІ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16), // Added padding to adjust size
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            30), // Adjust border radius to make it round
                        color:
                            Colors.grey[200], // Change background color to grey
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search', // Change hint text
                          hintStyle: TextStyle(
                              color: Colors.grey), // Change hint text color
                          border: InputBorder.none, // Remove border
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey, // Change icon color
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list,
                        color: Colors.grey), // Add filter icon
                    onPressed: () {
                      // Handle filter icon press
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: filteredUniversities.map((university) {
                return _buildUniversityCard(
                  university['name']!,
                  university['city']!,
                  university['phone']!,
                  university['imagePath']!,
                  university['programs']!,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversityCard(String name, String city, String phone,
      String imagePath, String programs) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _navigateToDetailScreen(name, city, phone, imagePath, programs);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage(imagePath),
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Container(
                            constraints: BoxConstraints(maxWidth: 210),
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            city,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            phone,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UniversityDetailScreen extends StatelessWidget {
  final String name;
  final String city;
  final String phone;
  final String imagePath;
  final String programs;

  UniversityDetailScreen({
    required this.name,
    required this.city,
    required this.phone,
    required this.imagePath,
    required this.programs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        city,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Programs:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    programs,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
