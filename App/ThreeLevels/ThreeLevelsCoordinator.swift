
import UIKit

class ThreeLevelsCoordinator 
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    init()
    {
        self.setupThreeLevels()
    }

    // MARK: - THREE LEVELS
    
    private func setupThreeLevels()
    {
        self.setupMenuVC(title: "Level #1: Menu")
        self.menuVCGoToProductsReport = { [weak self] in
            guard let this = self else { return }
            this.goToProducts()
        }

        self.setupProductsVC(title: "Level #2: Products")
        self.productsVCGoToProductReport = { [weak self] in
            guard let this = self else { return }
            this.goToProduct()
        }

        self.setupProductVC(title: "Level #3: Product")

        let nc = UINavigationController(rootViewController: self.menuVC)
        self.rootVC = nc

    }

    // MARK: - MENU VC

    private var menuVC: UIViewController!
    private var menuVCGoToProductsReport: SimpleCallback?

    private func setupMenuVC(title: String)
    {
        let menuView = UIView()
        menuView.backgroundColor = .red
        self.menuVC = UIViewControllerTemplate<UIView>(mainView: menuView)
        self.menuVC.title = title

        // Button to navigate to Products.
        let menuButton = UIButton()
        menuButton.setTitle("Go to Products", for: .normal)
        menuButton.addTarget(self, action: #selector(goToProducts(_:)), for: .touchUpInside)
        // Embed the button.
        menuView.embeddedView = menuButton
    }

    @objc func goToProducts(_ button: UIButton)
    {
        if let report = self.menuVCGoToProductsReport
        {
            report()
        }
    }

    func goToProducts()
    {
        self.menuVC.show(self.productsVC, sender: nil)
    }

    // MARK: - PRODUCTS VC

    private var productsVC: UIViewController!
    private var productsVCGoToProductReport: SimpleCallback?

    private func setupProductsVC(title: String)
    {
        let view = UIView()
        view.backgroundColor = .green
        self.productsVC = UIViewControllerTemplate<UIView>(mainView: view)
        self.productsVC.title = title

        // Button to navigate to Product.
        let button = UIButton()
        button.setTitle("Go to Product", for: .normal)
        button.addTarget(self, action: #selector(goToProduct(_:)), for: .touchUpInside)
        // Embed the button.
        view.embeddedView = button
    }

    @objc func goToProduct(_ button: UIButton)
    {
        if let report = self.productsVCGoToProductReport
        {
            report()
        }
    }

    func goToProduct()
    {
        self.productsVC.show(self.productVC, sender: nil)
    }

    // MARK: - PRODUCT VC

    private var productVC: UIViewController!

    private func setupProductVC(title: String)
    {
        let view = UIView()
        view.backgroundColor = .gray
        self.productVC = UIViewControllerTemplate<UIView>(mainView: view)
        self.productVC.title = title
    }

}

