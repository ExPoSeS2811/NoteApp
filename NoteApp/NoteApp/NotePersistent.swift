import CoreData
import Foundation

final class NotePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ note: Note) {
        guard let description = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) else { return }
        let entity = NoteEntity(entity: description, insertInto: context)
        
        entity.title = note.title
        entity.text = note.description
        entity.date = note.date
        entity.imageUrl = note.imageURL
        
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save note error: \(error)")
        }
    }
    
    static func delete(_ note: Note) {
        postNotification()
    }
    
    static func fetchAll() -> [Note] {
        let request = NoteEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    
    // MARK: - Private methods
    private static func convert(entities: [NoteEntity]) -> [Note] {
        let notes = entities.map {
            Note(
                title: $0.title ?? "",
                description: $0.text,
                date: $0.date ?? Date(),
                imageURL: $0.imageUrl
            )
        }
        
        return notes
    }
    
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
}
