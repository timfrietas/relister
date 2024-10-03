import SwiftUI

struct TaskRow: View {
    let task: Task
    let toggleCompletion: (Task) -> Void
    @State private var showSettings = false
    
    var body: some View {
        HStack {
            Text(task.title)
                .strikethrough(task.isDone)
                .foregroundColor(task.isDone ? .gray : .white)
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: task.isDone ? [.gray] : [.red, .orange, .yellow]),
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .cornerRadius(8)
        .swipeActions(edge: .trailing) {
            Button(action: {
                showSettings = true
            }) {
                Label("Settings", systemImage: "gear")
            }
            .tint(.blue)
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                toggleCompletion(task)
            }) {
                Label(task.isDone ? "Mark Undone" : "Mark Done", systemImage: task.isDone ? "arrow.uturn.backward" : "checkmark")
            }
            .tint(task.isDone ? .blue : .green)
        }
        .fullScreenCover(isPresented: $showSettings) {
            TaskSettingsView(task: task)
        }
    }
}
