
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    // MARK: - SETUP

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        // Create window.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Create coordinator.
        self.setupFourDirectionsCoordinator()
        // Display window.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    // MARK: - SAMPLE COORDINATOR

    private var fourDirectionsCoordinator: SampleCoordinator!
    
    private func setupFourDirectionsCoordinator()
    {
        self.fourDirectionsCoordinator = SampleCoordinator()
        self.window!.rootViewController = self.fourDirectionsCoordinator.rootVC

        // If root VC changes, re-assign it to the window.
        self.fourDirectionsCoordinator.rootVCChanged = { [weak self] in
            guard let this = self else { return }
            this.window!.rootViewController = this.fourDirectionsCoordinator.rootVC
        }
    }

}

