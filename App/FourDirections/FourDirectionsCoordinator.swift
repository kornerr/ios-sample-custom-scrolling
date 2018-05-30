
import UIKit

class FourDirectionsCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    //private var fourDirectionsView: FourDirectionsView!
    private var scroll2View: Scroll2View!

    init()
    {
        // Create View and VC.
        //self.fourDirectionsView = UIView.loadFromNib()
        //let vc = UIViewControllerTemplate<FourDirectionsView>(mainView: self.fourDirectionsView)
        self.scroll2View = UIView.loadFromNib()
        let vc = UIViewControllerTemplate<Scroll2View>(mainView: self.scroll2View)
        let nc = UINavigationController(rootViewController: vc)
        self.rootVC = nc

        self.setupItems()
    }

    private func setupItems()
    {
        typealias MItem = FourDirectionsMasterItem
        let items = [
            MItem("Clothing", color: .red),
            MItem("Swim", color: .green),
            MItem("Shoes", color: .blue),
            MItem("Handbags", color: .yellow),
            MItem("Accessories", color: .gray),
        ]
        // TODO setup detail items.
        //self.fourDirectionsView.setItems(items)
        self.scroll2View.setItems(items)

    }




}

