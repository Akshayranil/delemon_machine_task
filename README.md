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
- **State Management:** BLoC (`flutter_bloc`) with `equatable`
- **Navigation:** `go_router` (Navigator 2.0)
- **Repository Pattern:** domain/repositories + data/repositories_impl
- **Data Layer:** In-memory + fake JSON seed data
- **Theme:** Light & Dark with primary color `#0EA5E9`

##  Packages Used

- `flutter_bloc` → BLoC state management
- `equatable` → Value equality for entities & states
- `go_router` → Declarative routing
- `intl` → Date formatting (optional if used)

##  Screenshots

- **Light Mode:** ![light](screenshots/light.png)  
- **Dark Mode:** ![dark](screenshots/dark.png)

##  How to Run

1. Clone the repository
   https://github.com/Akshayranil/delemon_machine_task.git

2. Navigate to the project folder
   cd delemon_machine_task
   
3. Install dependencies
   flutter pub get

4. Run the application
   flutter run
