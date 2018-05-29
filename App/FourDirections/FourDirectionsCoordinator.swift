
import UIKit

class FourDirectionsCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    private var fourDirectionsView: FourDirectionsView!

    init()
    {
        // Create View and VC.
        self.fourDirectionsView = UIView.loadFromNib()
        let vc = UIViewControllerTemplate<FourDirectionsView>(mainView: self.fourDirectionsView)
        let nc = UINavigationController(rootViewController: vc)
        self.rootVC = nc

        // TODO Display products?
    }

}

