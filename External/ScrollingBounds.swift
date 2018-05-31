
import UIKit

// Internal logging function.
private func SCROLLING_BOUNDS_LOG(_ message: String)
{
    NSLog("ScrollingBounds \(message)")
}

// TODO Support horizontal and vertical configurations.

// This class
// * has viewport concept
// * has content concept
// * does not allow empty space outside content
// * only works when content's height is greater than viewport's one
class ScrollingBounds
{

    // MARK: - SETUP

    private let viewportHeight: CGFloat
    private let contentHeight: CGFloat

    init(
        viewportHeight: CGFloat,
        contentHeight: CGFloat,
        initialContentOffset: CGFloat = 0
    ) {
        self.viewportHeight = viewportHeight
        self.contentHeight = contentHeight
        self.contentOffset = initialContentOffset
        SCROLLING_BOUNDS_LOG(
            "Viewport height: '\(viewportHeight)' " +
            "Content height: '\(contentHeight)' " +
            "Initial content offset: '\(initialContentOffset)'"
        )
    }

    // MARK: - CONTENT OFFSET

    var contentOffsetReport: SimpleCallback?
    private(set) var contentOffset: CGFloat

    func setContentOffset(delta: CGFloat)
    {
        let offset = self.contentOffset + delta

        // Minimize offset to achieve snapping
        // if original offset would result in viewport
        // showing empty space instead of content.

        // Restrict any more offset at the top.
        let topThreshold: CGFloat = 0
        if offset > topThreshold
        {
            // Ignore repeated snapping.
            if (self.contentOffset != topThreshold)
            {
                self.contentOffset = topThreshold
                self.reportContentOffset()
            }
            return
        }

        // Restrict any more offset at the bottom.
        let bottomThreshold = -(self.contentHeight - self.viewportHeight)
        if offset < bottomThreshold
        {
            // Ignore repeated snapping.
            if (self.contentOffset != bottomThreshold)
            {
                self.contentOffset = bottomThreshold
                self.reportContentOffset()
            }
            return
        }

        // Allow offset.
        self.contentOffset = offset
        self.reportContentOffset()
    }

    private func reportContentOffset()
    {
        if let report = self.contentOffsetReport
        {
            report()
        }
    }

}

