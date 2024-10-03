import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var routineTitle: String = "Routine"
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadTasks()
        setupDailyReset()
    }
    
    func loadTasks() {
        // Load tasks from UserDefaults or a local database
        // For now, we'll use some sample data
        tasks = [
            Task(title: "5 min meditation", originalIndex: 0),
            Task(title: "3 item daily to-do list", originalIndex: 1),
            Task(title: "Ten minute brainstorm", originalIndex: 2),
            Task(title: "Music practice", originalIndex: 3),
            Task(title: "Writing practice", originalIndex: 4),
            Task(title: "Jess focus", originalIndex: 5),
            Task(title: "Contact friends", originalIndex: 6),
            Task(title: "Reading", originalIndex: 7),
            Task(title: "Medicine", originalIndex: 8)
        ]
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
            sortTasks()
        }
    }
    
    func sortTasks() {
        tasks.sort { (task1, task2) -> Bool in
            if task1.isDone == task2.isDone {
                return task1.originalIndex < task2.originalIndex
            }
            return !task1.isDone && task2.isDone
        }
    }
    
    func updateRoutineTitle(_ newTitle: String) {
        routineTitle = newTitle
        // Save the new title to UserDefaults or a local database
    }
    
    private func setupDailyReset() {
        // This is a simplified version. In a real app, you'd want to use
        // a more robust solution like BackgroundTasks framework
        Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                let calendar = Calendar.current
                let now = Date()
                if calendar.component(.hour, from: now) == 0 && calendar.component(.minute, from: now) == 0 {
                    self?.resetTasks()
                }
            }
            .store(in: &cancellables)
    }
    
    private func resetTasks() {
        for index in tasks.indices {
            tasks[index].isDone = false
        }
        sortTasks()
    }
    
    func addNewTask() {
        let newTask = Task(title: "", originalIndex: 0)
        tasks.insert(newTask, at: 0)
        for (index, task) in tasks.enumerated() {
            tasks[index].originalIndex = index
        }
    }
    
    func updateTask(_ task: Task, newTitle: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = newTitle
        }
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        for (index, task) in tasks.enumerated() {
            tasks[index].originalIndex = index
        }
    }
}
