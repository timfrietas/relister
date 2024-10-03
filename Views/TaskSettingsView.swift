import SwiftUI

struct TaskSettingsView: View {
    let task: Task
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings: \(task.title)")
                    .font(.headline)
                    .padding()
                
                // Add more settings UI here later
                
                Spacer()
            }
            .navigationBarTitle("Task Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
            })
        }
    }
}
