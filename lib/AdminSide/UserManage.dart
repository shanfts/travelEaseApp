import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

class UserManagement extends StatefulWidget {
  UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  var text;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFC5DDFF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: const Color(0xFFC5DDFF),
            leading: IconButton(
              icon: Image.asset(
                "images/back.png",
                height: 70,
                width: 70,
              ), // Customize your drawer icon here
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'User Management',
              style: TextStyle(
                color: Color(0xff323643),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true, // Center the title
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Management',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height: 20), // Add space between the text and the user list
                _buildUserList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final users = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              return UserTile(user: user);
            },
          );
        },
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: _isExpanded ? 120 : 60,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          title: Text(
            widget.user['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: _isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Email:  ${widget.user['email']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Number:  ${widget.user['number']}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
