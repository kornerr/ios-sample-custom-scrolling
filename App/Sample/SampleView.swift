
import UIKit

private func SAMPLE_VIEW_LOG(_ message: String)
{
    NSLog("SampleView \(message)")
}

class SampleView: UIView
{

    // MARK: - SETUP
    
    @IBOutlet private var gestureView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupScrolling()
    }
    
    // MARK: - SCROLLING

    private var scrolling: Scrolling!
    
    private func setupScrolling()
    {
        self.scrolling = Scrolling(trackedView: self.gestureView)
        self.scrolling.verticalReport = { [weak self] in
            guard let this = self else { return }
            SAMPLE_VIEW_LOG("Vertical delta: '\(this.scrolling.verticalDelta)'")
            SAMPLE_VIEW_LOG("Vertical velocity: '\(this.scrolling.verticalVelocity)'")
        }
        self.scrolling.verticalReport = {
            SAMPLE_VIEW_LOG("Finished vertical scrolling")
        }
    }

    /*
    // MARK: - ITEMS

    private var items = [MasterItem]()

    func setItems(_ items: [MasterItem])
    {
        self.items = items
        // TODO Provide size from actual screen size (80% height, 100% width)
        let size = CGSize(width: 320, height: 320)
        self.generateBackgroundViews(for: self.items, withSize: size)
        // TODO Display items in views
    }

    // MARK: - ITEM BACKGROUNDS
    
    @IBOutlet private var itemsView: UIView!
    private var scrollView: UIView!
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
    */

}

