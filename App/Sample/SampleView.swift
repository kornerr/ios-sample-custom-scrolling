
import UIKit

class SampleView: UIView
{

    // MARK: - SCROLLING

    @IBOutlet private var gestureView: UIView!
    private var scrolling: Scrolling!
    private var scrollingBounds: ScrollingBounds!

    var scrollingOffsetReport: SimpleCallback?
    var scrollingOffset: CGFloat
    {
        get
        {
            return self.scrollingBounds.contentOffset
        }
    }

    func setupScrolling(viewportHeight: CGFloat)
    {
        self.scrolling = Scrolling(trackedView: self.gestureView)
        self.scrollingBounds = ScrollingBounds()
        self.scrollingBounds.viewportHeight = viewportHeight
        self.scrolling.verticalReport = { [weak self] in
            guard let this = self else { return }
            this.scrollingBounds.setContentOffset(delta: this.scrolling.verticalDelta)
        }
        /*
        self.scrolling.verticalFinishReport = {
        }
        */

        // Relay scrolling report.
        self.scrollingBounds.contentOffsetReport = { [weak self] in
            guard let this = self else { return }
            if let report = this.scrollingOffsetReport
            {
                report()
            }
        }
    }

    // MARK: - ITEMS

    // NOTE Set BEFORE first display.
    var items = [MasterItem]()
    // NOTE Set BEFORE first display.
    var itemHeight: CGFloat = 0
    // NOTE Set BEFORE first display.
    var itemHeightCollapsed: CGFloat = 0

    @IBOutlet private var itemsView: UIView!
    var itemViews = [UIView]()

    private func generateItemViews(for items: [MasterItem], withSize size: CGSize)
    {
        // Remove previously generated views.
        for view in self.itemViews
        {
            view.removeFromSuperview()
        }
        self.itemViews = []

        // Generate new views.
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        for item in items
        {
            let view = UIView(frame: frame)
            view.backgroundColor = item.color
            self.itemViews.append(view)
            self.itemsView.addSubview(view)
        }
    }

    // MARK: - LAYING OUT

    var layoutReport: SimpleCallback?

    override func layoutSubviews()
    {
        super.layoutSubviews()

        self.updateScrollingRange()

        // Generate item views.
        let width = self.frame.size.width
        let size = CGSize(width: width, height: self.itemHeight)
        self.generateItemViews(for: self.items, withSize: size)

        // Invoke external layout setup.
        if let report = self.layoutReport
        {
            report()
        }
    }

    private func updateScrollingRange()
    {
        // Make sure we can scroll through each item.
        self.scrollingBounds.contentHeight =
            self.scrollingBounds.viewportHeight +
            self.itemHeightCollapsed * CGFloat(self.items.count - 1)
    }

}

