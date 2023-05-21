import UIKit

final class NotesListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.register(SimpleNoteTableViewCell.self, forCellReuseIdentifier: "SimpleNoteTableViewCell")
        tableView.register(ImageNoteTableViewCell.self, forCellReuseIdentifier: "ImageNoteTableViewCell")
        
    }
}

