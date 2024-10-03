import SwiftUI

struct EditableTaskRow: View {
    @ObservedObject var viewModel: TaskListViewModel
    let task: Task
    @State private var isEditing = false
    @State private var editedTitle: String
    
    init(viewModel: TaskListViewModel, task: Task) {
        self.viewModel = viewModel
        self.task = task
        self._editedTitle = State(initialValue: task.title)
    }
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("Task name", text: $editedTitle, onCommit: {
                    viewModel.updateTask(task, newTitle: editedTitle)
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(task.title)
                    .strikethrough(task.isDone)
                    .foregroundColor(task.isDone ? .gray : .white)
            }
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: task.isDone ? [.gray] : [.red, .orange, .yellow]),
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .cornerRadius(8)
        .onTapGesture {
            isEditing = true
        }
        .swipeActions(edge: .trailing) {
            Button(action: {
                // Show settings view
            }) {
                Label("Settings", systemImage: "gear")
            }
            .tint(.blue)
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                viewModel.toggleTaskCompletion(task)
            }) {
                Label(task.isDone ? "Mark Undone" : "Mark Done", systemImage: task.isDone ? "arrow.uturn.backward" : "checkmark")
            }
            .tint(task.isDone ? .blue : .green)
        }
    }
}
