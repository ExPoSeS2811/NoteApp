import Foundation

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    
}

final class NotesListViewModel: NotesListViewModelProtocol {
    private(set) var section: [TableViewSection] = []
    
    init() {
        getNotes()
        setMocks()
    }
    
    private func getNotes() {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(
            title: "23 Apr 2023",
            items: [
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil,
                    image: nil
                ),
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil,
                    image: nil
                ),
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil,
                    image: nil
                )
            ]
        )
        self.section = [section]
    }
}
