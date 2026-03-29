import Vapor
import Fluent

struct AuthService {
    let req: Request

    func register(data: CreateUserDTO) async throws -> User{
        try data.validate()

        let passwordHash = try Bcrypt.hash(data.password)

        let newUser = User(
            name: data.name,
            email: data.email,
            passwordHash: passwordHash
        )

        try await newUser.save(on: req.db)
        return newUser
    }
}

extension Request {
    var authService: AuthService{
        .init(req: self)
    }
    
}