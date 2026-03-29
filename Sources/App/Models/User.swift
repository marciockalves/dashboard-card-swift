import Fluent
import Vapor
import Foundation

final class User: Model, Content, @unchecked Sendable{
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @Field(key: "password_hash")
    var passwordHash: String

    @Field(key: "status")
    var status: Bool

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init(){}

    init(id: UUID? = nil, name:String, email:String, passwordHash:String, status: Bool = true){
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.status = status
    }
    
}

extension User: ModelAuthenticatable {
    static var usernameKey: KeyPath<User, FieldProperty<User, String>> {
        return \User.$email
    }

    static var passwordHashKey: KeyPath<User, FieldProperty<User, String>> {
        return \User.$passwordHash
    }

    func verify(password: String) throws -> Bool {
        return try Bcrypt.verify(password, created: self.passwordHash)
    }
}

extension User: SessionAuthenticatable {
    typealias SessionID = UUID
    
    var sessionID: UUID {
        guard let id = self.id else {
            fatalError("User ID is nil during session authentication")
        }
        return id
    }
}