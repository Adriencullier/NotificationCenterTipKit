import TipKit
import SwiftUICore

enum NotificationCenterTip: String, TKTip {
    case notificationsSettings
    case markAllAsReadTip
    case swipeOnNotification
    
    var title: Text {
        switch self {
        case .markAllAsReadTip:
            return .init("Mark all as read")
        case .notificationsSettings:
            return .init("Notification center configuration")
        case .swipeOnNotification:
            return .init("Swipe on notification")
        }
    }
    
    var message: Text? {
        switch self {
        case .markAllAsReadTip:
            return .init("Do you know you can directly mark all as read")
        case .notificationsSettings:
            return .init("You can choose what kind of notifications you would like to see here")
        case .swipeOnNotification:
            return .init("You can access to the main actions related to notifications by performing a swipe on it")
        }
    }
    
    var image: Image? {
        switch self {
        case .markAllAsReadTip:
            return Image(systemName: "checkmark.rectangle.stack")
        case .notificationsSettings:
            return Image(systemName: "gearshape")
        case .swipeOnNotification:
            return Image(systemName: "hand.draw")
        }
    }
    
    var actions: [Tips.Action] {
        switch self {
        case .markAllAsReadTip,
                .swipeOnNotification:
            return [
                Action(title: "Close") {
                    invalidate(reason: .tipClosed)
                }
            ]
        case .notificationsSettings:
            return [
                Action(id: "notif_settings_redirect_action", title: "Notification settings") {
                    invalidate(reason: .actionPerformed)
                }
            ]
        }
    }
    
    var rules: [Rule] {
        switch self {
        case .markAllAsReadTip:
            return [
                #Rule(NotificationCenterEvent.allHasBeenMarkedAsRead.event) {
                    $0.donations.count == 1
                }
            ]
        case .swipeOnNotification:
            return [
                #Rule(NotificationCenterEvent.markOneAsRead.event) {
                    $0.donations.count >= 2
                }
            ]
        case .notificationsSettings:
            return []
        }
    }
}
