import Vapor
import Leaf
import FluentSQLite

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Configure the rest of your application here
    
    
    //MARK: - Configure Leaf template and Homepage with home.leaf 
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    router.get { req -> Future<View> in
        
        //this will fetch the messages in our database and return a dynamic homepage
        return Message.query(on: req).sort(\Message.date, .descending).all().flatMap(to: View.self) { messages in
            let context = ["messages" : messages]
            return try req.view().render("home", context)

        }
    }
    
    router.get("list") { req -> Future<[Message]> in
        return Message.query(on: req).sort(\Message.date, .descending).all()
    }
    
    
    //MARK:- Database set up
    try services.register(FluentSQLiteProvider())
    let sqlite = try SQLiteDatabase(storage: .memory)
    
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    //MARK:- Allows write and read Swift type to and From Database
    var migrationConfig = MigrationConfig()
    migrationConfig.add(model: Message.self, database: .sqlite)
    services.register(migrationConfig)
}
