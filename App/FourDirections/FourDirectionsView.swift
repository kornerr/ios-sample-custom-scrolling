
import UIKit

class FourDirectionsView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // On the left.
        self.setupSectionPageControl()
        // At the bottom.
        self.setupCategoryPageControl()
    }

    // MARK: - ITEMS

    private var items = [FourDirectionsMasterItem]()

    func setItems(_ items: [FourDirectionsMasterItem])
    {
        self.items = items
        // TODO Display items in views
    }
    
    // MARK: - SECTION PAGE CONTROL

    @IBOutlet private var sectionPageControlContainerView: UIView!
    private var sectionPageControl: UIPageControl!

    private func setupSectionPageControl()
    {
        self.sectionPageControl = UIPageControl()
        self.sectionPageControl.numberOfPages = 5
        self.sectionPageControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
        self.sectionPageControlContainerView.embeddedView = self.sectionPageControl
    }
    
    // MARK: - CATEGORY PAGE CONTROL
    
    @IBOutlet private var categoryPageControlContainerView: UIView!
    private var categoryPageControl: UIPageControl!

    private func setupCategoryPageControl()
    {
        self.categoryPageControl = UIPageControl()
        self.categoryPageControl.numberOfPages = 5
        self.categoryPageControlContainerView.embeddedView = self.categoryPageControl
    }

}

