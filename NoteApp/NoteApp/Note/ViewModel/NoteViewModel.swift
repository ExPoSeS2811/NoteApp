import UIKit

protocol NoteViewModelProtocol {
    var text: String { get }
    
    func save(with text: String, and image: UIImage?, imageName: String?)
    func delete()
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    var text: String {
        return (note?.title ?? "") + "\n\n" + (note?.description ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(note: Note?) {
        self.note = note
    }
    
    func save(with text: String, and image: UIImage?, imageName: String?) {
        if let image = image,
           let name = imageName  {
            FileManagerPersistent.save(image, with: name)
        }
        
        let date = note?.date ?? Date()
        let (title, description) = createTitleAndDescription(from: text)
        
        let note = Note(
            title: title,
            description: description,
            date: date,
            imageURL: nil
        )
        NotePersistent.save(note)
    }
    
    func delete() {
        guard let note = note else { return }
        NotePersistent.delete(note)
    }
    
    // MARK: - Private methods
    private func createTitleAndDescription(from text: String) -> (String, String?) {
        var description = text
        
        guard let index = description.firstIndex(where: { $0 == "." || $0 == "!" || $0 == "\n" || $0 == "?" }) else { return (text, nil) }
        
        let title = String(description[...index])
        description.removeSubrange(...index)
        
        return (title, description)
    }
}
