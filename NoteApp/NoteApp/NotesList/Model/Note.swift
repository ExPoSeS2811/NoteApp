import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let description: String?
    let date: Date
    let imageURL: URL?
}
