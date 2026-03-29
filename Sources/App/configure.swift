import Vapor
import Leaf
import Fluent
import FluentPostgresDriver


public func configure(_ app: Application) async throws {
    app.views.use(.leaf)

    app.sessions.use(.fluent) 
    app.middleware.use(app.sessions.middleware)
  

    app.databases.use(.postgres(
        hostname: "localhost",
        port: 5432,
        username: "vapor_username",
        password: "vapor_password",
        database: "vapor_database",
        tlsConfiguration: nil
    ), as: .psql)

    app.migrations.add(CreateUser())
    app.migrations.add(CreateCard())
    app.migrations.add(SessionRecord.migration)


    try routes(app)
}
