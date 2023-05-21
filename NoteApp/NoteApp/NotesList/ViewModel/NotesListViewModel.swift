import Foundation

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    
}

final class NotesListViewModel: NotesListViewModelProtocol {
    private(set) var section: [TableViewSection] = []
    
    init() {
        getNotes()
    }
    
    private func getNotes() {
        let notes = NotePersistent.fetchAll()
        print(notes)
        
        let groupedObjects = notes.reduce(into: [Date: [Note]]()) { result, note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
        }
        
        let keys = groupedObjects.keys
        
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let stringDate = dateFormatter.string(from: key)
            
            section.append(
                TableViewSection(
                    title: stringDate,
                    items: groupedObjects[key] ?? []
                )
            )
        }
    }
    
    private func setMocks() {
        let section = TableViewSection(
            title: "23 Apr 2023",
            items: [
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil
                ),
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil
                ),
                Note(
                    title: "First note",
                    description: "some description",
                    date: Date(),
                    imageURL: nil
                )
            ]
        )
        self.section = [section]
    }
}
