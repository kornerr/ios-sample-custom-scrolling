
import UIKit

class FourDirectionsView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupAlert()
    }

    // MARK: - ALERT

    var displayAlertReport: SimpleCallback?
    @IBOutlet private var alertButton: UIButton!
    
    private func setupAlert()
    {
        let title = NSLocalizedString("Sample.Alert.Title", comment: "")
        self.alertButton.setTitle(title, for: .normal)
    }

    @IBAction private func displayAlert(_ sender: Any)
    {
        if let report = self.displayAlertReport
        {
            report()
        }
    }
}

