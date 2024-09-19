

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, 
                    UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let coordinator: TaskCoordinatorProtocol = TaskCoordinator(navigationController: navigationController)
        coordinator.initial()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    lazy var persistentContainer: NSPersistentContainer = {
       let conteiner = NSPersistentContainer(name: "Model")
        conteiner.loadPersistentStores { (description,
                                          error) in
            if let error {
                print(error.localizedDescription)
            }
        }
        return conteiner
    }()
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolver error \(error), \(nsError.userInfo)")
            }
        }
    }
}
