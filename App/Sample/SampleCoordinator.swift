
import UIKit

class SampleCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    private var sampleView: SampleView!

    init()
    {
        // Create View and VC.
        self.sampleView = UIView.loadFromNib()
        let vc = UIViewControllerTemplate<SampleView>(mainView: self.sampleView)
        //let nc = UINavigationController(rootViewController: vc)
        self.rootVC = vc

        self.setupItems()
    }

    private func setupItems()
    {
        typealias MItem = MasterItem
        let items = [
            MItem("Clothing", color: .red),
            MItem("Swim", color: .green),
            MItem("Shoes", color: .blue),
            MItem("Handbags", color: .yellow),
            MItem("Accessories", color: .gray),
        ]
        self.sampleView.setItems(items)

    }

}

