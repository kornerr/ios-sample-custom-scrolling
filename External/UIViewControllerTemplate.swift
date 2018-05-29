
import UIKit

class UIViewControllerTemplate<MainView>: UIViewController
{

    var mainView: MainView!

    init(mainView: MainView)
    {
        super.init(nibName: nil, bundle: nil)
        // Keep main view.
        self.mainView = mainView
        // Embed it if MainView is castable to UIView.
        if let child = self.mainView as? UIView
        {
            self.view.embeddedView = child
        }
        // Provide red color to signify error.
        else
        {
            self.view.backgroundColor = .red
        }
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("UIViewControllerTemplate. ERROR: init(coder:) has not been implemented")
    }

}

