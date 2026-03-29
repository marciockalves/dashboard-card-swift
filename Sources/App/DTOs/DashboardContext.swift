import Vapor

struct DashboardContext: Encodable {
    var title: String
    var username: String
    var cards: [Card]
}