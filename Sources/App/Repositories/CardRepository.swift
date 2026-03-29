import Vapor
import Fluent
import Foundation // Necessário para o UUID

protocol CardRepositoryProtocol {
    func list(for userID: UUID) async throws -> [Card]
    func create(_ card: Card) async throws
}

struct DatabaseCardRepository: CardRepositoryProtocol {
    let database: any Database // Lembre-se do 'any' para o Swift 6

    func list(for userID: UUID) async throws -> [Card] {
        try await Card.query(on: database)
            .filter(\.$user.$id == userID)
            .sort(\.$createdAt, .descending)
            .all()
    }

    func create(_ card: Card) async throws {
        try await card.create(on: database)
    }
}