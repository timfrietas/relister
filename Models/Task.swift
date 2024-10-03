import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isDone: Bool
    var originalIndex: Int
    
    init(id: UUID = UUID(), title: String, isDone: Bool = false, originalIndex: Int) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.originalIndex = originalIndex
    }
}
