
import UIKit

struct DetailItem
{
    var id = ""
    var title = ""

    init(_ title: String)
    {
        self.id = UUID().uuidString
        self.title = title
    }

}

