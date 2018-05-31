
import UIKit

// Internal logging function.
private func SCROLLING_LOG(_ message: String)
{
    NSLog("Scrolling \(message)")
}

// This class
// * adds its pan gesture recognizer to the provided UIView
// * detects pan guestures on the provided UIView
// * report scrolling
class Scrolling
{

    // MARK: - SETUP

    private weak var trackedView: UIView?
    private weak var panGestureRecognizer: UIPanGestureRecognizer?

    init(trackedView: UIView)
    {
        self.trackedView = trackedView
        let panGR =
            UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        self.trackedView?.addGestureRecognizer(panGR)
        self.panGestureRecognizer = panGR
    }

    private var lastTranslation = CGPoint(x: 0, y: 0)

    @objc func pan(_ recognizer: UIPanGestureRecognizer)
    {
        guard
            let piece = recognizer.view 
        else
        {
            SCROLLING_LOG("ERROR Gesture recognizer has no view. Cannot proceed")
            return
        }
        let translation = recognizer.translation(in: piece.superview)

        // Begin.
        if recognizer.state == .began
        {
            SCROLLING_LOG("Begin")
            self.resetVerticalScrolling()
            self.lastTranslation = CGPoint(x: 0, y: 0)
        }

        // Move.
        if recognizer.state != .cancelled
        {
            let delta =
                CGPoint(
                    x: translation.x - self.lastTranslation.x,
                    y: translation.y - self.lastTranslation.y
                )
            let velocity = recognizer.velocity(in: piece.superview)
            self.reportVerticalScrolling(delta, velocity)
            self.lastTranslation = translation
        }
        // Cancel.
        else
        {
            SCROLLING_LOG("Cancel")
        }

        // Finish.
        if recognizer.state == .ended
        {
            SCROLLING_LOG("Finish")
            let none = CGPoint(x: 0, y: 0)
            self.reportVerticalScrolling(none, none)
            self.reportVerticalScrollingFinish()
        }
    }

    // MARK: - VERTICAL SCROLLING
    
    var verticalReport: SimpleCallback?
    var verticalFinishReport: SimpleCallback?

    var verticalDelta: CGFloat = 0
    var verticalVelocity: CGFloat = 0

    private func resetVerticalScrolling()
    {
        self.verticalDelta = 0
        self.verticalVelocity = 0
    }

    private func reportVerticalScrolling(_ delta: CGPoint, _ velocity: CGPoint)
    {
        self.verticalDelta = delta.y
        self.verticalVelocity = velocity.y
        if let report = self.verticalReport
        {
            report()
        }
    }

    private func reportVerticalScrollingFinish()
    {
        if let report = self.verticalFinishReport
        {
            report()
        }
    }

}

