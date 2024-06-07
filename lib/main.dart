//NOOR WAJIHAH BINTI SHAMSUL AZMI
//212888
//SSE3401 - 2
//LAB 5

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waji.Co Dashboard',
      theme: ThemeData(
        primaryColor: Color(0xFF34395a),
        scaffoldBackgroundColor: Color(0xFF202b34),
        appBarTheme: AppBarTheme(
          color: Color(0xFF34395a),
          toolbarTextStyle: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20),
          ).headline6,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF34395a),
          selectedItemColor: Color(0xFF94b0cb),
          unselectedItemColor: Color(0xFF657ab5),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70),
          headline6: TextStyle(color: Colors.white),
        ),
        cardColor: Color(0xFF202b34),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF7a9cb6),
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF202b34),
          labelStyle: TextStyle(color: Colors.white70),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7a9cb6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF657ab5)),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF7a9cb6),
        ),
      ),
      home: ActivationPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final int selectedFactory;

  HomePage({this.selectedFactory = 1});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  int _selectedFactory = 1;

  static List<Widget> _pages = <Widget>[
    EngineerListPage(),
    DashboardPage(),
    NotificationSettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedFactory = widget.selectedFactory;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        _selectedFactory = 1; // Set Factory 1 when navigating to the Dashboard
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waji.Co Dashboard')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Engineers'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedFactory = 1;

  final Map<int, double> factoryPower = {
    1: 0.0,
    2: 1620.4,
    3: 1487.9,
    4: 1593.2,
  };

  final Map<int, List<double>> sensorReadings = {
    1: [0.0, 0.0, 0.0, 0.0],
    2: [15.5, 25.5, 35.5, 45.5],
    3: [12.2, 22.2, 32.2, 42.2],
    4: [18.8, 28.8, 38.8, 48.8],
  };

  String _getCurrentTimestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.factory, size: 30, color: Colors.white), // Factory icon
              SizedBox(width: 10), // Space between icon and text
              Text(
                'Factory $_selectedFactory',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            children: List.generate(4, (index) {
              return Card(
                child: Center(
                  child: Text('Sensor ${index + 1}: ${sensorReadings[_selectedFactory]![index]}',
                      style: TextStyle(fontSize: 18, color: Color(0xFF34395a))),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(7.5),
          child: Text('Total Power: ${factoryPower[_selectedFactory]} kW',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(7.5),
          child: Text('Timestamp: ${_getCurrentTimestamp()}', style: TextStyle(fontSize: 20, color: Colors.white70)),
        ),
        Container(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFactory = index + 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.factory, size: 30, color: _selectedFactory == index + 1 ? Theme.of(context).colorScheme.secondary : Colors.white),
                      SizedBox(width: 10), // Space between icon and text
                      Text(
                        'Factory ${index + 1}',
                        style: TextStyle(
                          fontSize: 20,
                          color: _selectedFactory == index + 1
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class EngineerListPage extends StatefulWidget {
  @override
  _EngineerListPageState createState() => _EngineerListPageState();
}

class _EngineerListPageState extends State<EngineerListPage> {
  int _selectedFactory = 1;

  final Map<int, List<Map<String, String>>> _factoryEngineers = {
    1: [
      {'name': 'Hyoyeon', 'phone': '6012-345-6789'},
    ],
    2: [
      {'name': 'Michael', 'phone': '6019-876-5432'},
    ],
    3: [],
    4: [],
  };

  void _addEngineer(int factoryId, String name, String phone) {
    setState(() {
      _factoryEngineers[factoryId]!.add({'name': name, 'phone': phone});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engineer List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage(selectedFactory: 1)),
                  (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvitationPage(onSubmit: (name, phone) {
                  _addEngineer(_selectedFactory, name, phone);
                })),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _factoryEngineers[_selectedFactory]!.length,
              itemBuilder: (context, index) {
                final engineer = _factoryEngineers[_selectedFactory]![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Color(0xFF34395a),
                  child: ListTile(
                    title: Text(engineer['name']!, style: TextStyle(color: Colors.white, fontSize: 18)),
                    subtitle: Text(engineer['phone']!, style: TextStyle(color: Colors.white70)),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFactory = index + 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.factory, size: 30, color: _selectedFactory == index + 1 ? Theme.of(context).colorScheme.secondary : Colors.white),
                        SizedBox(width: 10), // Space between icon and text
                        Text(
                          'Factory ${index + 1}',
                          style: TextStyle(
                            fontSize: 20,
                            color: _selectedFactory == index + 1
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class InvitationPage extends StatefulWidget {
  final Function(String, String) onSubmit;

  InvitationPage({required this.onSubmit});

  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invite Engineer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Engineer Name', border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSubmit(_nameController.text, _phoneController.text);
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  int _selectedFactory = 1;

  final Map<int, List<String>> factoryData = {
    1: ['Steam Pressure: 29 bar', 'Steam Flow: 22 T/H', 'Water Level: 53%', 'Power Frequency: 48 Hz'],
    2: ['Steam Pressure: 30 bar', 'Steam Flow: 24 T/H', 'Water Level: 55%', 'Power Frequency: 49 Hz'],
    3: ['Steam Pressure: 28 bar', 'Steam Flow: 20 T/H', 'Water Level: 50%', 'Power Frequency: 47 Hz'],
    4: ['Steam Pressure: 31 bar', 'Steam Flow: 26 T/H', 'Water Level: 57%', 'Power Frequency: 50 Hz'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.factory, size: 30, color: Colors.white), // Factory icon
                SizedBox(width: 10), // Space between icon and text
                Text(
                  'Factory $_selectedFactory',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Minimum Threshold',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              children: List.generate(4, (index) {
                return Card(
                  child: Center(
                    child: Text(factoryData[_selectedFactory]![index],
                        style: TextStyle(fontSize: 18, color: Color(0xFF34395a))),
                  ),
                );
              }),
            ),
          ),
          Container(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFactory = index + 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.factory, size: 30, color: _selectedFactory == index + 1 ? Theme.of(context).colorScheme.secondary : Colors.white),
                        SizedBox(width: 10), // Space between icon and text
                        Text(
                          'Factory ${index + 1}',
                          style: TextStyle(
                            fontSize: 20,
                            color: _selectedFactory == index + 1
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}


class ActivationPage extends StatefulWidget {
  @override
  _ActivationPageState createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  bool _termsAccepted = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPPage(phoneNumber: _phoneNumber),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              CheckboxListTile(
                title: DefaultTextStyle(
                  style: TextStyle(color: Color(0xFF94b0cb)), // Set the color for the text
                  child: Text('I agree to terms and conditions'),
                ),
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value!;
                  });
                },
                activeColor: Color(0xFF94b0cb), // Set the color for the checkbox
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Get Activation Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPPage extends StatefulWidget {
  final String phoneNumber;

  OTPPage({required this.phoneNumber});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  String _otp = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('An activation code was sent to ${widget.phoneNumber}'),
              TextFormField(
                decoration: InputDecoration(labelText: 'OTP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
                onSaved: (value) {
                  _otp = value!;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Activate'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Didn\'t receive yet, tap here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}