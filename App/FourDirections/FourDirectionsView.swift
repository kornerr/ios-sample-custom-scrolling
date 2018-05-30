
import UIKit

class FourDirectionsView: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrollView()
        self.setupSectionPageControl()
        self.setupCategoryPageControl()
    }

    // MARK: - ITEMS

    private var items = [FourDirectionsMasterItem]()

    func setItems(_ items: [FourDirectionsMasterItem])
    {
        self.items = items
        // TODO Provide size from actual screen size (80% height, 100% width)
        let size = CGSize(width: 320, height: 320)
        self.generateBackgroundViews(for: self.items, withSize: size)
        // TODO Display items in views
    }

    // MARK: - ITEM BACKGROUNDS
    
    @IBOutlet private var backgroundView: UIView!
    private var scrollView: UIView!
    private var backgroundViews = [UIView]()

    private func setupScrollView()
    {
        self.scrollView = UIView()
        self.backgroundView.addSubview(self.scrollView)
    }

    private func generateBackgroundViews(for items: [FourDirectionsMasterItem], withSize size: CGSize)
    {
        // Remove previously generated background views from superview.
        for view in self.backgroundViews
        {
            view.removeFromSuperview()
        }
        self.backgroundViews = []
        // Generate new background views.
        var frame = CGRect(x: 50, y: 0, width: size.width, height: size.height)
        for item in items
        {
            let view = UIView(frame: frame)

            view.backgroundColor = item.color
            self.backgroundViews.append(view)

            // Add to superview.
            self.scrollView.addSubview(view)

            // Offset following views.
            let newY = frame.origin.y + frame.size.height
            frame = CGRect(x: frame.origin.x, y: newY, width: frame.size.width, height: frame.size.height)
        }
    }

    // MARK: - MOVE SCROLL VIEW
    
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

