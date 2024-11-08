import TipKit

/// TKTipViewWithGroup
/// Aims to embed in a simply view all the logic related to task group for an inline tip
struct TKTipViewWithGroup: View {
    // MARK: - Properties
    @State private var tipGroup: TipGroup
    
    private let arrowEdge: Edge?
    private let action: (Tips.Action) -> Void
    
    // MARK: - Init
    init(tipGroup: [any TKTip],
         priority: TipGroup.Priority = .firstAvailable,
         arrowEdge: Edge? = nil,
         action: @escaping (Tips.Action) -> Void = { _ in }) {
        self.tipGroup = TipGroup(priority) { tipGroup }
        self.arrowEdge = arrowEdge
        self.action = action
    }
    
    // MARK: - Body
    var body: some View {
        TipView(
            self.tipGroup.currentTip,
            arrowEdge: arrowEdge,
            action: action
        )
    }
}
