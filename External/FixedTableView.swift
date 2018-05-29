
import UIKit

class FixedTableView<ItemView: UIView>: UIView, UITableViewDataSource
{

    // MARK: - SETUP

    init(rowHeight: CGFloat)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.setupTableView()
        self.tableView.rowHeight = rowHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ITEMS

    private var items = [ItemView]()

    func setItems(_ items: [ItemView])
    {
        self.items = items
        self.tableView.reloadData()
    }

    // MARK: - TABLE VIEW

    private var tableView: UITableView!

    private let CellId = "CellId"
    private typealias Cell = UITableViewCellTemplate<ItemView>

    private func setupTableView()
    {
        self.tableView = UITableView()
        self.embeddedView = self.tableView
        self.tableView.dataSource = self
        self.tableView.register(Cell.self, forCellReuseIdentifier: CellId)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            self.tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath)
            as! Cell
        let item = self.items[indexPath.row]
        cell.itemView = item
        return cell
    }

}
