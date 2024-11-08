import SwiftUI

@Observable
final class NotificationsListViewModel {
    private var markAsReadCount = 0
    var notifications = [
        NotificationEntity(title: "Notifcation 1"),
        NotificationEntity(title: "Notifcation 2"),
        NotificationEntity(title: "Notifcation 3"),
    ]
    
    func mark(notification: NotificationEntity, asRead: Bool) {
        guard let index = self.notifications.firstIndex(where: { $0.id == notification.id }) else {
            return
        }
        var updatedNotification = self.notifications[index]
        updatedNotification.isRead = asRead
        self.notifications[index] = updatedNotification
        if asRead {
            self.markAsReadCount += 1
        }
        if self.markAsReadCount > 1,
           notifications.first(where: { !$0.isRead }) == nil {
            NotificationCenterEvent.donate(for: .allHasBeenMarkedAsRead)            
        }
    }
    
    func markAllAsRead() {
        self.notifications = self.notifications.map({
            var updatedNotif = $0
            updatedNotif.isRead = true
            return updatedNotif
        })
    }
}
