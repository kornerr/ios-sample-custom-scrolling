
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

    private var sampleView: SampleView!

    init()
    {
        // Create View and VC.
        self.sampleView = UIView.loadFromNib()
        self.sampleView.setupScrolling(viewportHeight: VIEWPORT_HEIGHT)
        self.sampleView.itemHeight = ITEM_HEIGHT
        self.sampleView.itemHeightCollapsed = ITEM_HEIGHT_COLLAPSED

        let vc = UIViewControllerTemplate<SampleView>(mainView: self.sampleView)
        //let nc = UINavigationController(rootViewController: vc)
        self.rootVC = vc

        self.setupItems()
        self.setupLayout()
    }

    private func setupItems()
    {
        typealias MItem = MasterItem
        let items = [
            MItem("EDGE-TOP", color: .red),
            MItem("Clothing", color: .magenta),
            MItem("Swim", color: .green),
            MItem("Shoes", color: .blue),
            MItem("Handbags", color: .yellow),
            MItem("Accessories", color: .cyan),
            MItem("EDGE-BOTTOM", color: .gray),
        ]
        self.sampleView.items = items
    }

    // MARK: - LAYING OUT

    private func setupLayout()
    {
        self.sampleView.layoutReport = { [weak self] in
            guard let this = self else { return }
            //this.setupLayout01()
            this.setupLayout02()
        }
    }

    // MARK: - LAYOUT 01

    private func setupLayout01()
    {
        // Scroll items.
        self.sampleView.scrollingOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOut01()
        }
        // Perform the first laying out manually.
        self.layItemsOut01()
    }

    private func layItemsOut01()
    {
        let offset = self.sampleView.scrollingOffset
        let position = -offset / PAGE_SCROLL_SIZE
        layViewsOut01(
            views: self.sampleView.itemViews,
            offset: 0,
            position: position,
            maxViewHeight: ITEM_HEIGHT,
            minSizeFactor: ITEM_MIN_SIZE_FACTOR,
            maxSizeFactor: ITEM_MAX_SIZE_FACTOR
        )
    }

    // MARK: - LAYOUT 02

    private func setupLayout02()
    {
        // Scroll items.
        self.sampleView.scrollingOffsetReport = { [weak self] in
            guard let this = self else { return }
            this.layItemsOut02()
        }
        // Perform the first laying out manually.
        self.layItemsOut02()
    }

    private func layItemsOut02()
    {
        let offset = self.sampleView.scrollingOffset
        let position = -offset / PAGE_SCROLL_SIZE
        layViewsOut02(
            views: self.sampleView.itemViews,
            offset: VIEWPORT_HEIGHT / 2.0 - ITEM_HEIGHT / 2.0, // Center of the view port.
            position: position,
            maxViewHeight: ITEM_HEIGHT,
            minSizeFactor: ITEM_MIN_SIZE_FACTOR,
            maxSizeFactor: ITEM_MAX_SIZE_FACTOR
        )
    }

}

