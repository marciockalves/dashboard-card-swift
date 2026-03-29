import Vapor
import Fluent

struct AuthController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.get("register", use: renderRegister)
        routes.get("login", use: renderLogin)

        routes.post("register", use: register)
        
        let authGroup = routes.grouped(User.authenticator())
        authGroup.post("login", use: login)
    }

    func renderRegister(req: Request) async throws -> View {
        return try await req.view.render("register")
    }

    func register(req: Request) async throws -> Response {
        let data = try req.content.decode(RegisterUserDTO.self)

        guard data.password == data.confirmPassword else {
            throw Abort(.badRequest, reason: "As senhas não conferem.")
        }

        let user = User(
            name: data.name,
            email: data.email,
            passwordHash: try Bcrypt.hash(data.password)
        )

        try await user.save(on: req.db)

        return req.redirect(to: "/login")
    }

    func renderLogin(req: Request) async throws -> View {
        return try await req.view.render("login")
    }

    @Sendable
    func login(req: Request) async throws -> Response {
        guard let user = req.auth.get(User.self) else {
        throw Abort(.unauthorized)
        }
        
        req.auth.login(user) 
        
        return req.redirect(to: "/dashboard")
    }
}