import Vapor
import Fluent

protocol UserRepositoryProtocol {
    func find(id: UUID) async throws -> User?
    func create(_ user: User) async throws
    func delete(id: UUID) async throws
}

struct DatabaseUserRepository: UserRepositoryProtocol {
    let database: any Database

    func find(id: UUID) async throws -> User?{
        try await User.find(id, on: database)
    }

    func create(_ user: User) async throws{
        try await user.create(on: database)
    }

    func delete(id: UUID) async throws{
        try await User.query(on: database).filter(\.$id == id).delete()
    }
}