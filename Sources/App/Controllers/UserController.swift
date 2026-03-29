import Vapor

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder){
        routes.get("register", use: renderRegister)
        routes.post("register", use: register)
    }

    func renderRegister(req: Request) async throws -> View{
        return try await req.view.render("register")
    }

    func register(req: Request) async throws-> Response{
        let dto = try  req.content.decode(CreateUserDTO.self)

        _ = try await req.authService.register(data: dto)

        return req.redirect(to: "/login")
    }

}