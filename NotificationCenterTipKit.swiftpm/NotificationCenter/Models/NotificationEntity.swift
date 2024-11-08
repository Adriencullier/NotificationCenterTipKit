import Foundation

struct NotificationEntity: Identifiable {
    let id: UUID = UUID()
    var title: String
    var isRead: Bool = false
}
