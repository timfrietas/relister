import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var editingTitle = false
    @State private var newTitle = ""
    @State private var draggedTask: Task?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    EditableTaskRow(viewModel: viewModel, task: task)
                        .onLongPressGesture(minimumDuration: 1) {
                            draggedTask = task
                        }
                }
                .onMove(perform: viewModel.moveTask)
            }
            .listStyle(PlainListStyle())
            .navigationTitle(viewModel.routineTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editingTitle = true
                        newTitle = viewModel.routineTitle
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            }
            .alert("Edit Routine Title", isPresented: $editingTitle) {
                TextField("New Title", text: $newTitle)
                Button("Save") {
                    viewModel.updateRoutineTitle(newTitle)
                    editingTitle = false
                }
                Button("Cancel", role: .cancel) {
                    editingTitle = false
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.height > 50 {
                            viewModel.addNewTask()
                        }
                    }
            )
        }
        .onChange(of: draggedTask) { task in
            if let task = task {
                withAnimation {
                    // Add drop shadow effect
                    // This is a placeholder, as SwiftUI doesn't have a built-in drop shadow for list rows
                    // You may need to implement a custom solution for this visual effect
                }
            } else {
                withAnimation {
                    // Remove drop shadow effect
                }
            }
        }
    }
}
