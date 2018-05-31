
import UIKit

private let ITEM_HEIGHT: CGFloat = 200

class Scroll2View: UIView
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrolling()
    }

    // MARK: - ITEMS

    private var items = [MasterItem]()

    func setItems(_ items: [MasterItem])
    {
        self.items = items
        // TODO Provide size from actual screen size (80% height, 100% width)
        let size = CGSize(width: 320, height: ITEM_HEIGHT)
        self.generateBackgroundViews(for: self.items, withSize: size)
        // TODO Display items in views
    }

    // MARK: - ITEM VIEWS
    
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var foregroundView: UIView!
    
    private var scrollView: UIScrollView!
    private var itemViews = [UIView]()

    private func setupScrolling()
    {
        self.scrollView = UIScrollView()
        self.backgroundView.addSubview(self.scrollView)
        // Use smaller scroll view size to have paging based on item size lesser than scroll view bounds.
        self.scrollView.isPagingEnabled = true
        let frame = CGRect(x: 0, y: 0, width: 320, height: ITEM_HEIGHT)
        self.scrollView.frame = frame
        // Make sure we don't clip subviews.
        self.scrollView.clipsToBounds = false
        // Add scroll view's pan guesture recognizer to its parent.
        self.backgroundView.addGestureRecognizer(self.scrollView.panGestureRecognizer)
        // Hide scroll bar.
        self.scrollView.showsVerticalScrollIndicator = false

        /*
        // Setup manual scrolling.
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.foregroundView.addGestureRecognizer(panGR)

        self.vertScrollReport = { [weak self] in
            guard let this = self else { return }
            NSLog("Vertical scroll delta: '\(this.vertScrollDelta)'")
            var offset = this.scrollView.contentOffset
            NSLog("Offset before: '\(offset)'")
            offset.y -= this.vertScrollDelta
            NSLog("Offset after: '\(offset)'")
            this.scrollView.setContentOffset(offset, animated: false)
        }
        */
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

    private var backgroundViews = [UIView]()

    private func generateBackgroundViews(for items: [MasterItem], withSize size: CGSize)
    {
        // Remove previously generated background views from superview.
        for view in self.backgroundViews
        {
            view.removeFromSuperview()
        }
        self.backgroundViews = []
        // Generate new background views.
        let startY = ITEM_HEIGHT / 2.0
        var frame = CGRect(x: 0, y: startY, width: size.width, height: size.height)
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
        let height = CGFloat(items.count) * size.height
        self.scrollView.contentSize = CGSize(width: size.width, height: height)
    }

}

