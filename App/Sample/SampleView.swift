
import UIKit

// Internal logging function.
private func SAMPLE_VIEW_LOG(_ message: String)
{
    NSLog("SampleView \(message)")
}

private let ITEM_HEIGHT: CGFloat = 200
private let ITEM_COLLAPSED_HEIGHT: CGFloat = 50

private let SCREEN_WIDTH: CGFloat = 320

private let VIEWPORT_HEIGHT: CGFloat = 300
private let CONTENT_HEIGHT: CGFloat = ITEM_HEIGHT + ITEM_COLLAPSED_HEIGHT * 6 // items' count - 1

private let PAGE_SCROLL_SIZE: CGFloat = ITEM_COLLAPSED_HEIGHT

class SampleView: UIView
{

    // MARK: - SETUP
    
    @IBOutlet private var gestureView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrolling()
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
        let center = VIEWPORT_HEIGHT / 2.0
        // Scroll items.
        self.scrollingBounds.contentOffsetReport = { [weak self] in
            guard let this = self else { return }
            let offset = this.scrollingBounds.contentOffset
            let pageIdFactor = -offset / PAGE_SCROLL_SIZE
            let pageId = Int(pageIdFactor) + 1
            let prevPageId = pageId - 1
            let nextPageId = pageId + 1

            // Make all item views invisible.
            for view in this.itemViews
            {
                view.isHidden = true
            }

            let proximity = CGFloat(pageId) - pageIdFactor
            SAMPLE_VIEW_LOG("Offset: '\(offset)' Proximity: '\(proximity)' PageId: '\(pageId)' PageIdFactor: '\(pageIdFactor)'")

            let pageIdView = this.itemViews[pageId]
            let nextPageIdView = this.itemViews[nextPageId]
            let prevPageIdView = this.itemViews[prevPageId]
            pageIdView.isHidden = false
            nextPageIdView.isHidden = false
            prevPageIdView.isHidden = false

            // Close to current page id?
            if (proximity > 0.5)
            {
                var frame = pageIdView.frame
                frame.size.height = ITEM_HEIGHT
                frame.origin.y = center + proximity * 10
                pageIdView.frame = frame
            }
            // Close to the next page id?
            else
            {
                var frame = nextPageIdView.frame
                frame.size.height = ITEM_HEIGHT * proximity
                frame.origin.y = center * 2 + proximity * 10
                nextPageIdView.frame = frame
            }
            // TODO Detect center proximity (selected id)
            /*
            var frame = this.contentView.frame
            frame.origin.y = this.scrollingBounds.contentOffset
            this.contentView.frame = frame
            */
        }
    }

}

