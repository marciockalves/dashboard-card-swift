import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UserController())
    try app.register(collection: AuthController())
    try app.register(collection: DashboardController())
    let protected = app.grouped(User.sessionAuthenticator(), User.redirectMiddleware(path: "/login"))
    
    try protected.register(collection: DashboardController())
}
