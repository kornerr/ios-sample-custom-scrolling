
import UIKit

// Internal logging function.
private func SAMPLE_VIEW_LOG(_ message: String)
{
    NSLog("SampleView \(message)")
}

private let SCREEN_WIDTH: CGFloat = 320

private let ITEM_HEIGHT: CGFloat = 200
private let ITEM_COLLAPSED_HEIGHT: CGFloat = 50
private let VIEWPORT_HEIGHT: CGFloat = 300
private let CONTENT_HEIGHT: CGFloat = ITEM_HEIGHT * 7.5 // items' count + half to make the last item visible
private let PAGE_SCROLL_SIZE: CGFloat = ITEM_HEIGHT

class SampleView: UIView
{

    // MARK: - SETUP
    
    @IBOutlet private var gestureView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrolling()
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        //self.setupContentView()
        self.setupItemsLayout()
    }

    // MARK: - SCROLLING

    private var scrolling: Scrolling!
    private var scrollingBounds: ScrollingBounds!
    
    private func setupScrolling()
    {
        self.scrolling = Scrolling(trackedView: self.gestureView)
        self.scrollingBounds =
            ScrollingBounds(
                viewportHeight: VIEWPORT_HEIGHT,
                contentHeight: CONTENT_HEIGHT
            )
        self.scrolling.verticalReport = { [weak self] in
            guard let this = self else { return }
            this.scrollingBounds.setContentOffset(delta: this.scrolling.verticalDelta)
        }
        /*
        self.scrolling.verticalFinishReport = {
        }
        */
    }

    // MARK: - CONTENT VIEW

    private var contentView: UIView!

    private func setupContentView()
    {
        self.contentView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CONTENT_HEIGHT))
        self.contentView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        self.itemsView.addSubview(self.contentView)

        // Scroll content view.
        self.scrollingBounds.contentOffsetReport = { [weak self] in
            guard let this = self else { return }
            //SAMPLE_VIEW_LOG("Content offset: '\(this.scrollingBounds.contentOffset)'")
            var frame = this.contentView.frame
            frame.origin.y = this.scrollingBounds.contentOffset
            this.contentView.frame = frame
        }
    }
    
    // MARK: - ITEMS

    private var items = [MasterItem]()

    func setItems(_ items: [MasterItem])
    {
        self.items = items
        // TODO Provide size from actual screen size (80% height, 100% width)
        let size = CGSize(width: SCREEN_WIDTH, height: ITEM_HEIGHT)
        self.generateItemViews(for: self.items, withSize: size)
        // TODO Display items in views
    }

    @IBOutlet private var itemsView: UIView!

    // MARK: - ITEM VIEWS
    
    private var itemViews = [UIView]()

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

    // MARK: - ITEMS LAYOUT

    private func setupItemsLayout()
    {
        // Scroll items.
        self.scrollingBounds.contentOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOutFullHeight()
        }
        // Perform the first laying out manually.
        self.layItemsOutFullHeight()
    }

    private func layItemsOutFullHeight()
    {
        let offset = self.scrollingBounds.contentOffset
        let position = -offset / PAGE_SCROLL_SIZE
        SAMPLE_VIEW_LOG("Position: '\(position)'")
        let pageId = Int(round(position))
        SAMPLE_VIEW_LOG("Page id: '\(pageId)'")

        let origin = VIEWPORT_HEIGHT / 2.0 - ITEM_HEIGHT / 2.0
        let height = ITEM_HEIGHT
        var y = origin - position * height

        for id in 0..<self.itemViews.count
        {
            let view = self.itemViews[id]

            // Resize and reposition view.
            var frame = view.frame
            // Set constant height.
            frame.size.height = height
            // Set view position.
            frame.origin.y = y
            view.frame = frame

            SAMPLE_VIEW_LOG("view id: '\(id)' frame: '\(frame)'")

            // Calculate position for the next view.
            y += height
        }
    }

    private func layItemsOut()
    {
        let offset = self.scrollingBounds.contentOffset
        //SAMPLE_VIEW_LOG("Offset: '\(offset)'")
        let position = -offset / PAGE_SCROLL_SIZE
        SAMPLE_VIEW_LOG("Position: '\(position)'")
        /*
        let pageId = Int(round(position))
        SAMPLE_VIEW_LOG("Page id: '\(pageId)'")
        */

        /*

        for id in 0..<self.itemViews.count
        {
            let distance = CGFloat(id) - position
            let view = self.itemViews[id]
            let isVisible = (abs(distance) < 1.5)
            view.isHidden = !isVisible
            if (isVisible)
            {
                // Height.
                let height = (1.0 - abs(distance) / 2.0) * VIEWPORT_HEIGHT / (VIEWPORT_HEIGHT / ITEM_HEIGHT)
                SAMPLE_VIEW_LOG("id '\(id)' height: '\(height)' distance: '\(distance)'")
                var frame = view.frame
                frame.size.height = height > 0 ? height : 0
                // Position.

                let center = VIEWPORT_HEIGHT / 2.0 + distance * ITEM_HEIGHT / 2.0
                //let prevCenter = curCenter - curItem.size.height / 2.0 - prevItem.size.height / 2.0
                //let nextCenter = curCenter + curItem.size.height / 2.0 + prevItem.size.height / 2.0
                frame.origin.y = (center - frame.size.height / 2.0)
                view.frame = frame
            }
        }
        */
    }

}

