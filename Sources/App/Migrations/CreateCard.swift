import Fluent

struct CreateCard: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("cards")
            .id()
            .field("title", .string, .required)
            .field("card_content", .string, .required)
            .field("status", .bool, .required, .custom("DEFAULT TRUE"))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("cards").delete()
    }
}