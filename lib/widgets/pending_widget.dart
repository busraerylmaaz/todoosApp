import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoos/model/todo_model.dart';
import 'package:todoos/services/database_services.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
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
            stream: _databaseServices.todos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No pending tasks found.'));
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Color.fromARGB(255, 175, 78, 154),
                            foregroundColor: Colors.white,
                            icon: Icons.done,
                            label: "Mark",
                            onPressed: (context) {
                              _databaseServices.updateTodoTask(todo.id, true);
                            },
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Color.fromARGB(255, 251, 153, 217),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: "Edit",
                            onPressed: (context) {
                              _showTaskDialog(context, todo: todo);
                            },
                          ),
                          SlidableAction(
                            backgroundColor: Color.fromARGB(255, 227, 39, 83),
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
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(todo.description),
                        trailing: Text(
                          '${dt.day}/${dt.month}/${dt.year}',
                          style: TextStyle(
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

  void _showTaskDialog(BuildContext context, {Todo? todo}) {
    final TextEditingController _titleController = TextEditingController(text: todo?.title);
    final TextEditingController _descriptionController = TextEditingController(text: todo?.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            todo == null ? "Add Task" : "Edit Task",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7843E6),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (todo == null) {
                  await _databaseServices.addTodoTask(
                    _titleController.text,
                    _descriptionController.text,
                  );
                } else {
                  await _databaseServices.updateTodo(
                    todo.id,
                    _titleController.text,
                    _descriptionController.text,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(todo == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }
}
