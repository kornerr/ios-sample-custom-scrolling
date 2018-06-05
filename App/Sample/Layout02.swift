import UIKit

func layViewsOut02(
    views: [UIView],
    offset: CGFloat,
    position: CGFloat,
    maxViewHeight: CGFloat,
    minSizeFactor: CGFloat,
    maxSizeFactor: CGFloat)
{
    var y: CGFloat = offset - position * maxViewHeight * minSizeFactor
    for id in 0..<views.count
    {
        // Distance from current position to this view.
        let distance = abs(position - CGFloat(id))
        // Default size factor.
        var sizeFactor = minSizeFactor
        if distance < maxSizeFactor
        {
            let factor = maxSizeFactor - distance
            // Restrict factor (linearly) to [minSizeFactor; maxSizeFactor] range.
            let amplitude = maxSizeFactor - minSizeFactor
            sizeFactor = amplitude * factor + minSizeFactor
        }

        let view = views[id]
        var frame = view.frame
        // Height.
        frame.size.height = maxViewHeight * sizeFactor

        // Position.
        frame.origin.y = y
        y += frame.size.height

        // Apply changes.
        view.frame = frame
    }
}
