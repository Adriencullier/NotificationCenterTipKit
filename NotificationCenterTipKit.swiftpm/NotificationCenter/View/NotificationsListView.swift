import SwiftUI

struct NotificationsListView: View {
    private let viewModel = NotificationsListViewModel()
    
    var body: some View {
        List {
            TKTipViewWithGroup(
                tipGroup: [
                    NotificationCenterTip.notificationsSettings,
                    NotificationCenterTip.swipeOnNotification
                ]
            ) { action in
                if action.id == "notif_settings_redirect_action" {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }
            }
            ForEach(self.viewModel.notifications) { notif in
                notificationCard(notif)
                    .swipeActions {
                        actionButton(notif)
                            .onAppear {
                                NotificationCenterTip.swipeOnNotification.invalidate(reason: .actionPerformed)
                            }
                    }
                    .onTapGesture {
                        self.viewModel.mark(notification: notif, asRead: true)
                        NotificationCenterEvent.donate(for: .markOneAsRead)
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Notifications")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                markAllAsReadButton
                    .popoverTip(NotificationCenterTip.markAllAsReadTip)
            }
        }
    }
    
    private var markAllAsReadButton: some View {
        Button {
            self.viewModel.markAllAsRead()
            NotificationCenterTip.markAllAsReadTip.invalidate(reason: .actionPerformed)
        } label: {
            Image(systemName: "checkmark.rectangle.stack")
        }
    }
    
    private func notificationCard(_ notification: NotificationEntity) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(
                    notification.isRead ? .gray.opacity(0.4) : .blue.opacity(0.4)
                )
            Text(notification.title)
                .padding()
        }
    }
    
    private func actionButton(_ notification: NotificationEntity) -> some View {
        Button {
            self.viewModel.mark(
                notification: notification,
                asRead: !notification.isRead
            )
        } label: {
            Label(
                "Mark as " + (notification.isRead ? "unread" : "read"),
                systemImage: notification.isRead ? "checkmark.circle.badge.xmark" : "checkmark.circle"
            )
            
        }
        .tint(notification.isRead ? .blue.opacity(0.4) : .gray.opacity(0.4))
    }
}
