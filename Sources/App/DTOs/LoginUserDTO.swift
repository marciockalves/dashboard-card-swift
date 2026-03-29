import Vapor

struct LoginUserDTO: Content {
    var email: String
    var password: String
}