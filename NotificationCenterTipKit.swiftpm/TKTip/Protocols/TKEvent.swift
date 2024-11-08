import TipKit

/// Aims to define a TKEvent
protocol TKEvent: RawRepresentable<String>, Sendable {}

extension TKEvent {
    /// Event id
    var id: String {
        self.rawValue
    }
    
    /// Tips.Event associated to the TKEvent
    var event: Tips.Event<Int> {
        Tips.Event(id: self.id)
    }
    
    /// Aims to increment by one the Tips.Event donation count associated to the TKevent
    /// - Parameter tipEvent: TKEvent
    static func donate(for tipEvent: Self) {
        Task { @MainActor in
            await tipEvent.event.donate(1)
        }
    }
}
