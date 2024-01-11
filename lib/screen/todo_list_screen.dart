import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../provider/todo_provider.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoProvider todoProvider = TodoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              showSortDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoProvider.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                var todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todoProvider.toggleComplete(todo.id, value!);
                      setState(() {});
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      todoProvider.removeTodo(todo.id);
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    showEditDialog(context, todo);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
  /////
  void showEditDialog(BuildContext context, Todo todo) {
    TextEditingController titleController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                todo.title = titleController.text;
                await todoProvider.editTodo(todo);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
/////
  void showAddDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Provider.of<TodoProvider>(context, listen: false).addTodo(titleController.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(BuildContext context, int index, String currentTitle) {
    TextEditingController titleController = TextEditingController(text: currentTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Provider.of<TodoProvider>(context, listen: false).editTodo(index, titleController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort Todos'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Provider.of<TodoProvider>(context, listen: false).sortTodos(true);
                  Navigator.pop(context);
                },
                child: Text('Completed First'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }