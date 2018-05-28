
import UIKit

class SampleVC: UIViewController
{

    // MARK: - SETUP

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTitle()
    }

    // MARK: - TITLE

    private func setupTitle()
    {
        self.navigationItem.title = NSLocalizedString("Sample.Title", comment: "")
    }

    // MARK: - MAIN VIEW

    var mainView: UIView?
    {
        get
        {
            return self.view.embeddedView
        }

        set
        {
            self.view.embeddedView = newValue
        }
    }

}

