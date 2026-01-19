# TaskFlow Mini

A small task management Flutter app (Projects → Tasks → Subtasks) built as part of a take-home assignment.

##  Features

- Create, list, and archive Projects
- Create, list, update, and assign Tasks
- Task filtering: Status, Priority, Assignee
- Task search by title/description
- Update Task status and time spent
- Project report:
  - Total tasks, Done, In Progress, Blocked, Overdue, Completion %
  - Open tasks by assignee
- Light/Dark theme support
- Responsive UI with loading/empty/error states

##  Architecture

- **Flutter (stable, null-safe)**
- **State Management:** BLoC (`flutter_bloc`) with `equatable` with CLEAN Architecture
- **Navigation:** `go_router` (Navigator 2.0)
- **Repository Pattern:** domain/repositories + data/repositories_impl
- **Data Layer:** In-memory + fake JSON seed data
- **Theme:** Light & Dark with primary color `#0EA5E9`

##  Packages Used

- `flutter_bloc` → BLoC state management
- `equatable` → Value equality for entities & states
- `go_router` → Declarative routing


##  Screenshots

- **Light Mode:** ![light_mode](https://github.com/user-attachments/assets/2c879e18-fc6a-4e1f-97d0-6f54af6b12cd)
 
- **Dark Mode:** ![dark_mode](https://github.com/user-attachments/assets/264eb4d2-280f-45a7-8763-ec8d15188720)
- **Report Screen:** ![report_screen](https://github.com/user-attachments/assets/fa6dca2f-eebf-49b4-96e6-20476ced7133)



##  How to Run

1. Clone the repository
   https://github.com/Akshayranil/delemon_machine_task.git

2. Navigate to the project folder
   cd delemon_machine_task
   
3. Install dependencies
   flutter pub get

4. Run the application
   flutter run

