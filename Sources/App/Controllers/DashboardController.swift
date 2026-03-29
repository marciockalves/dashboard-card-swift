import Vapor
import Leaf

struct DashboardController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws{
        let dashboard = routes.grouped("dashboard")
        dashboard.get(use: index)
    }

    func index(req: Request) async throws -> View{
        let mockUser = User(name: "Desenvolvedor", email: "dev@teste.com", passwordHash: "")

        let context: [String: String] = [
            "name": mockUser.name,
            "title": "Meu Dashboard de Cards"
        ]

        return try await req.view.render("dashboard", context)
    }
    
}