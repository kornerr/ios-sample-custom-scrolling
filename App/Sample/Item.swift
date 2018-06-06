
import UIKit

struct Item
{
    var id: String
    var title = ""
    // TODO: Change to UIImage
    var color: UIColor?

    init(_ title: String, color: UIColor?)
    {
        self.id = UUID().uuidString
        self.title = title
        self.color = color
    }

}

