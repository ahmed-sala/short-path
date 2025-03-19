import 'package:flutter/material.dart';

class PersonalProfileScreen extends StatefulWidget {
  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Personal Info'),
    Tab(text: 'Experience'),
    Tab(text: 'Skills'),
    Tab(text: 'Education'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: [
          // Profile Picture
          GestureDetector(
            onTap: () {
              // Open profile image update option
            },
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
          SizedBox(width: 16.0),
          // Name and Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
              Text('Flutter Developer',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Projects', '12'),
          _buildStatItem('Experience', '5 yrs'),
          _buildStatItem('Clients', '8'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTabSection() {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: myTabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                // Replace with actual content widgets for each section
                return Center(child: Text('Content for ${tab.text}'));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          _buildStatsSection(),
          SizedBox(height: 16.0),
          _buildTabSection(),
        ],
      ),
    );
  }
}
