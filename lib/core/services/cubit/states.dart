abstract class TaskStates {
}
class InItState extends TaskStates {}
class NewTaskState extends TaskStates {}
class DoneState extends TaskStates {}
class ArchivedTaskState extends TaskStates {}

class AddTaskState extends TaskStates {}
class EditTaskState extends TaskStates {}

class CreateDataBaseState extends TaskStates {}
class GetDataFromDataBaseState extends TaskStates {}
class InsertDataToDataBaseState extends TaskStates {}
