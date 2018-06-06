
import UIKit

private let VIEWPORT_HEIGHT: CGFloat = 300

private let ITEM_HEIGHT: CGFloat = 200
private let ITEM_MIN_SIZE_FACTOR: CGFloat = 0.25
private let ITEM_MAX_SIZE_FACTOR: CGFloat = 1.0
private let ITEM_HEIGHT_COLLAPSED: CGFloat = ITEM_HEIGHT * ITEM_MIN_SIZE_FACTOR
private let PAGE_SCROLL_SIZE = ITEM_HEIGHT_COLLAPSED

class SampleCoordinator
{

    // MARK: - SETUP

    var rootVC: UIViewController!
    var rootVCChanged: SimpleCallback?

    init()
    {
        // Create sample views with both layouts.
        self.setupLayout01SampleView()
        let layout01VC = UIViewControllerTemplate<SampleView>(mainView: self.layout01SampleView)
        layout01VC.title = "Layout01"

        self.setupLayout02SampleView()
        let layout02VC = UIViewControllerTemplate<SampleView>(mainView: self.layout02SampleView)
        layout02VC.title = "Layout02"

        // Display them.
        let tc = UITabBarController()
        tc.viewControllers = [layout01VC, layout02VC]
        self.rootVC = tc
    }

    private func createItems() -> [Item]
    {
        return [
            Item("EDGE-TOP", color: .red),
            Item("News", color: .magenta),
            Item("Articles", color: .green),
            Item("Promotions", color: .blue),
            Item("Aggregation", color: .yellow),
            Item("Sales", color: .cyan),
            Item("EDGE-BOTTOM", color: .gray),
        ]
    }

    private func createSampleView() -> SampleView
    {
        let view: SampleView! = UIView.loadFromNib()
        view.setupScrolling(viewportHeight: VIEWPORT_HEIGHT)
        view.itemHeight = ITEM_HEIGHT
        view.itemHeightCollapsed = ITEM_HEIGHT_COLLAPSED

        view.items = self.createItems()

        return view
    }

    // MARK: - LAYOUT 01

    private var layout01SampleView: SampleView!

    private func setupLayout01SampleView()
    {
        self.layout01SampleView = self.createSampleView()
        self.layout01SampleView.layoutReport = { [weak self] in
            guard let this = self else { return }
            this.setupLayout01()
        }
    }

    private func setupLayout01()
    {
        // Scroll items.
        self.layout01SampleView.scrollingOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOut01()
        }
        // Perform the first laying out manually.
        self.layItemsOut01()
    }

    private func layItemsOut01()
    {
        let offset = self.layout01SampleView.scrollingOffset
        let position = -offset / PAGE_SCROLL_SIZE
        layViewsOut01(
            views: self.layout01SampleView.itemViews,
            offset: 0,
            position: position,
            maxViewHeight: ITEM_HEIGHT,
            minSizeFactor: ITEM_MIN_SIZE_FACTOR,
            maxSizeFactor: ITEM_MAX_SIZE_FACTOR
        )
    }

    // MARK: - LAYOUT 02

    private var layout02SampleView: SampleView!

    private func setupLayout02SampleView()
    {
        self.layout02SampleView = self.createSampleView()
        self.layout02SampleView.layoutReport = { [weak self] in
            guard let this = self else { return }
            this.setupLayout02()
        }
    }

    private func setupLayout02()
    {
        // Scroll items.
        self.layout02SampleView.scrollingOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOut02()
        }
        // Perform the first laying out manually.
        self.layItemsOut02()
    }

    private func layItemsOut02()
    {
        let offset = self.layout02SampleView.scrollingOffset
        let position = -offset / PAGE_SCROLL_SIZE
        layViewsOut02(
            views: self.layout02SampleView.itemViews,
            offset: VIEWPORT_HEIGHT / 2.0 - ITEM_HEIGHT / 2.0, // Center of the view port.
            position: position,
            maxViewHeight: ITEM_HEIGHT,
            minSizeFactor: ITEM_MIN_SIZE_FACTOR,
            maxSizeFactor: ITEM_MAX_SIZE_FACTOR
        )
    }

}

