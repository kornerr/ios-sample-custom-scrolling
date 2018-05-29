
import UIKit

class MenuProductsCoordinator 
{

    // MARK: - SETUP

    var rootVC: UIViewController!

    init()
    {
        self.setupMenuVC()
        /*
        self.menuVCGoToProductsReport = { [weak self] in
            guard let this = self else { return }
            this.goToProducts()
        }
        */

        let nc = UINavigationController(rootViewController: self.menuVC)
        self.rootVC = nc
    }

    // MARK: - MENU VC

    private var menuVC: UIViewController!
    //private var menuVCGoToProductsReport: SimpleCallback?

    private func setupMenuVC()
    {
        let menu = FixedTableView<UIView>(rowHeight: 100)
        menu.backgroundColor = .gray
        self.menuVC = UIViewControllerTemplate<FixedTableView>(mainView: menu)
        self.menuVC.title = "Menu"

        // TODO get callbacks from fixed table view

    }

}

