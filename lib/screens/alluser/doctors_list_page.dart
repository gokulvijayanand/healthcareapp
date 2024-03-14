import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/env.dart';
import '../../models/doctor.dart'; // Update the import path for the Doctor model
import 'doctor_detail_page.dart'; // Ensure this import path is correct

class DoctorsListPage extends StatefulWidget {
  final String? specialization;

  DoctorsListPage({this.specialization});

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDoctorsData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadDoctorsData() async {
    final response = await http.get(Uri.parse('${Env.BASE_URL}doctors/?format=json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Doctor> loadedDoctors =
      data.map((data) => Doctor.fromJson(data)).toList();

      if (widget.specialization != null) {
        loadedDoctors = loadedDoctors
            .where((doctor) => doctor.specialization == widget.specialization)
            .toList();
      }

      setState(() {
        _doctors = loadedDoctors;
        _filteredDoctors = loadedDoctors;
      });
    } else {
      throw Exception('Failed to load doctors data');
    }
  }

  void _onSearchChanged() {
    _filterDoctors(_searchController.text);
  }

  void _filterDoctors(String query) {
    final filteredDoctors = _doctors.where((doctor) {
      final doctorNameLower = doctor.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return doctorNameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredDoctors = filteredDoctors;
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
          hintText: 'Search by doctor name',
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Implement your filter logic or show a filter dialog
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _filteredDoctors[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 25,
                      // Assuming doctor.image is a network URL
                      backgroundImage: NetworkImage(doctor.image),
                    ),
                    title: Text(doctor.name),
                    subtitle: Text(
                        '${doctor.specialization}, ${doctor.qualifications}'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailPage(doctor: doctor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
