import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoos/model/todo_model.dart';
import 'package:todoos/services/database_services.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseServices _databaseServices = DatabaseServices();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,  
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _updateSearchQuery,
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: Icon(Icons.search),
              filled: true, 
              fillColor: Color.fromARGB(255, 240, 170, 194)
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose, 
          child: StreamBuilder<List<Todo>>(
            stream: _databaseServices.completedtodos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No completed tasks found.'));
              }

              List<Todo> todos = snapshot.data!;
              if (searchQuery.isNotEmpty) {
                todos = todos.where((todo) =>
                  todo.title.toLowerCase().contains(searchQuery.toLowerCase())
                ).toList();
              }

              return ListView.builder(
                shrinkWrap: true,  
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  Todo todo = todos[index];
                  final DateTime dt = todo.timeStamp.toDate();
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: const Color.fromARGB(255, 227, 39, 83),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: "Delete",
                            onPressed: (context) async {
                              await _databaseServices.deleteTodoTask(todo.id);
                            },
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        subtitle: Text(todo.description),
                        trailing: Text(
                          '${dt.day}/${dt.month}/${dt.year}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
