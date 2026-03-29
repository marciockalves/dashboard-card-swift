import Vapor

struct CreateCardDTO: Content {
    var title: String
    var content: String
}