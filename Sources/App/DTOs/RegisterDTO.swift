import Vapor

struct RegisterUserDTO: Content {
    var name: String     
    var email: String
    var password: String
    var confirmPassword: String
}
