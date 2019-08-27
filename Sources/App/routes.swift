import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    
    router.post("send") { req -> Future<Message> in
        let username: String = try req.content.syncGet(at: "username")
        let content: String = try req.content.syncGet(at: "content")
        let msg = Message(id: nil, username: username, content: content, date: Date())

        return msg.save(on: req)
    }
}
