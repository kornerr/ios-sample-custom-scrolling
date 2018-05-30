
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
    @IBOutlet private var foregroundView: UIView!
    private var scrollView: UIView!
    private var backgroundViews = [UIView]()

    private func setupScrollView()
    {
        self.scrollView = UIView()
        self.backgroundView.addSubview(self.scrollView)
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.foregroundView.addGestureRecognizer(panGR)
        self.vertScrollReport = { [weak self] in
            guard let this = self else { return }
            NSLog("Vertical scroll velocity: '\(this.vertScrollVelocity)'")
            var frame = this.scrollView.frame
            frame.origin.y += this.vertScrollDelta
            this.scrollView.frame = frame
        }
        /*
        self.vertScrollFinishReport = { [weak self] in
            guard let this = self else { return }
            NSLog("Finished scrolling")
        }
        */
    }

    private var vertScrollReport: SimpleCallback?
    private var vertScrollFinishReport: SimpleCallback?
    private var vertScrollDelta: CGFloat = 0
    private var vertScrollVelocity: CGFloat = 0
    private var lastTranslation = CGPoint(x: 0, y: 0)

    @objc func pan(_ recognizer: UIPanGestureRecognizer)
    {
        guard
            let piece = recognizer.view 
        else
        {
            NSLog("Gesture recognizer has no view. Cannot proceed")
            return
        }
        let translation = recognizer.translation(in: piece.superview)
        if recognizer.state == .began
        {
            NSLog("began")
            self.vertScrollDelta = 0
            self.lastTranslation = CGPoint(x: 0, y: 0)
        }
        if recognizer.state != .cancelled
        {
            //NSLog("translation by '\(translation.x)'/'\(translation.y)'")
            // Delta.
            let delta = translation.y - self.lastTranslation.y
            self.vertScrollDelta = delta
            // Velocity.
            let velocity = recognizer.velocity(in: piece.superview)
            self.vertScrollVelocity = velocity.y
            // Report.
            if let report = self.vertScrollReport
            {
                report()
            }
            self.lastTranslation = translation
        }
        else
        {
            NSLog("cancelled")
        }
        if recognizer.state == .ended
        {
            // Report.
            if let report = self.vertScrollFinishReport
            {
                report()
            }
            NSLog("ended")
        }
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
            // NOTE Please note that scrollView's frame does not contain the frames
            // NOTE of all its children. We just use it to move all children
            // NOTE at once.

            // Offset following views.
            let newY = frame.origin.y + frame.size.height
            frame = CGRect(x: frame.origin.x, y: newY, width: frame.size.width, height: frame.size.height)
        }
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

