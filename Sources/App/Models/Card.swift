import Fluent
import Vapor
import Foundation

final class Card: Model, Content, @unchecked Sendable{
    static let schema = "cards"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "card_content")
    var cardContent: String

    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID? = nil, title: String, cardContent: String, userID: User.IDValue) {
        self.id = id
        self.title = title
        self.cardContent = cardContent
        self.$user.id = userID
    }
}