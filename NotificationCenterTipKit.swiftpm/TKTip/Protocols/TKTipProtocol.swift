import TipKit

/// Aims to define a TKTip
protocol TKTip: RawRepresentable<String>, Tip {}

extension TKTip {
    /// Tip id
    var id: String {
        return self.rawValue
    }
}
