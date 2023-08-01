import 'dart:io';

void main() {
  TaskManager taskManager = TaskManager();
  taskManager.addTask();
  taskManager.addTask();
  taskManager.addTask();
  taskManager.addTask();
  taskManager.addTask();

  taskManager.viewCompletedTasks();
  taskManager.viewpendingTasks();
  taskManager.viewAllTasks();

  taskManager.editTask(2);
  taskManager.viewAllTasks();
}

class Task {
  String? title;
  String? description;
  String? dueDate;
  String? status;

  Task(String? title, description, dueDate, status) {
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.status = status;
  }
}

class TaskManager {
  var tasks = <Task>[];

  void addTask() {
    print("Enter Task title: ");
    var title = stdin.readLineSync();
    print("Enter Task desctiption: ");
    var desc = stdin.readLineSync();
    print("Enter due date of the task: ");
    var date = stdin.readLineSync();
    print("""Enter the status: 
              if 'completed' enter 'c' 
              if 'pending' enter 'p'
          """);
    var status = stdin.readLineSync();

    if (status == "c") {
      status = "completed";
    } else {
      status = "pending";
    }
    Task newTask = Task(title, desc, date, status);
    tasks.add(newTask);
  }

  void viewAllTasks() {
    print("ALL TASKS");
    for (var task in tasks) {
      print("${task.title} ${task.description} ${task.dueDate} ${task.status}");
    }
    print("*****boundary******");
  }

  void viewCompletedTasks() {
    print("COMPLETED TASKS");
    for (var task in tasks) {
      if (task.status == "completed") {
        print(
            "${task.title} ${task.description} ${task.dueDate} ${task.status}");
      }
    }
  }

  void viewpendingTasks() {
    print("PENDING TASKS");
    for (var task in tasks) {
      if (task.status == "pending") {
        print(
            "${task.title} ${task.description} ${task.dueDate} ${task.status}");
      }
    }
  }

  void deleteTask(int index) {
    if (0 <= index && index < tasks.length) {
      tasks.removeAt(index);
    }
  }

  void editTask(int index) {
    if (0 <= index && index < tasks.length) {
      var editedTask = tasks[index];

      editedTask.title = "new Title";
      editedTask.description = "new Desctription";
      editedTask.dueDate = "July 20, 2023";
      editedTask.status = "pending";
    }
  }
}
