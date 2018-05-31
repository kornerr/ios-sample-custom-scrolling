
import UIKit

// Internal logging function.
private func SAMPLE_VIEW_LOG(_ message: String)
{
    NSLog("SampleView \(message)")
}

private let VIEWPORT_HEIGHT: CGFloat = 300
private let CONTENT_HEIGHT: CGFloat = 800

private let ITEM_HEIGHT: CGFloat = 200

private let SCREEN_WIDTH: CGFloat = 320

class SampleView: UIView
{

    // MARK: - SETUP
    
    @IBOutlet private var gestureView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrolling()
        //self.setupContentView()

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

}

