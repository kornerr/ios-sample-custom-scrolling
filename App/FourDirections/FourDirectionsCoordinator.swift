
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

        self.setupItems()
    }

    private func setupItems()
    {
        let masterItems = [
            Item("Clothing", color: .red),
            Item("Swim", color: .green),
            Item("Shoes", color: .blue),
            Item("Handbags", color: .yellow),
            Item("Accessories", color: .gray),
        ]
        // TODO setup details for each master item.
        self.fourDirectionsView.setItems(masterItems)

    }




}

