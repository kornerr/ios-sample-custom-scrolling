
import UIKit

class SampleCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    init()
    {
        self.setupSample()
    }

    // MARK: - SAMPLE

    private var sampleView: SampleView!
    private var sampleVC: SampleVC!

    private func setupSample()
    {
        // Create View and VC.
        self.sampleView = UIView.loadFromNib()
        self.sampleVC = SampleVC()
        self.sampleVC.mainView = self.sampleView
        let nc = UINavigationController(rootViewController: self.sampleVC)
        self.rootVC = nc

        // Display alert.
        self.sampleView.displayAlertReport = { [weak self] in
            guard let this = self else { return }
            this.displayAlert(from: this.sampleVC)
        }
    }

    private func displayAlert(from parent: UIViewController)
    {
        let title = NSLocalizedString("Sample.Alert.Title", comment: "")
        let message = NSLocalizedString("Sample.Alert.Message", comment: "")
        let alert =
            UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
        let ok = NSLocalizedString("Sample.Alert.OK", comment: "")
        alert.addAction(
            UIAlertAction(
                title: ok,
                style: .default,
                handler: nil
            )
        )
        parent.present(alert, animated: true, completion: nil)
    }

}

