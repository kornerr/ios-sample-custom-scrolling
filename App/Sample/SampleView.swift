
import UIKit

// Internal logging function.
private func SAMPLE_VIEW_LOG(_ message: String)
{
    NSLog("SampleView \(message)")
}

private let SCREEN_WIDTH: CGFloat = 320

private let ITEM_HEIGHT: CGFloat = 200
private let ITEM_MIN_SIZE_FACTOR: CGFloat = 0.25
private let ITEM_MAX_SIZE_FACTOR: CGFloat = 1.0
private let ITEM_HEIGHT_COLLAPSED: CGFloat = ITEM_HEIGHT * ITEM_MIN_SIZE_FACTOR

private let VIEWPORT_HEIGHT: CGFloat = 300
private let CONTENT_HEIGHT: CGFloat = VIEWPORT_HEIGHT + ITEM_HEIGHT_COLLAPSED * 6 // item's count - 1
private let PAGE_SCROLL_SIZE: CGFloat = ITEM_HEIGHT_COLLAPSED

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
        self.setupItemsLayoutQuarterHeightStatic()
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

    // MARK: - ITEMS LAYOUT QUARTER HEIGHT STATIC

    private func setupItemsLayoutQuarterHeightStatic()
    {
        // Scroll items.
        self.scrollingBounds.contentOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOutQuarterHeightStatic()
        }
        // Perform the first laying out manually.
        self.layItemsOutQuarterHeightStatic()
    }

    private func layItemsOutQuarterHeightStatic()
    {
        let offset = self.scrollingBounds.contentOffset
        let position = -offset / PAGE_SCROLL_SIZE
        layViewsOutQuarterHeightStatic(
            views: self.itemViews,
            position: position,
            maxViewHeight: ITEM_HEIGHT,
            minSizeFactor: ITEM_MIN_SIZE_FACTOR,
            maxSizeFactor: ITEM_MAX_SIZE_FACTOR
        )
    }

}

