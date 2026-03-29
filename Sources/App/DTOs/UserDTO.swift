import Vapor

struct CreateUserDTO: Content {
    var name: String
    var email: String
    var password: String
    var confirmPassword: String


    func validate() throws{
        guard password == confirmPassword else {
            throw Abort(.badRequest, reason: "As senhas não coincidem.")
        }

        guard password.count >= 6 else{
            throw Abort(.badRequest, reason:"A senha deve ter pelo menos 6 caracteres.")
        }
    }

    
}