import UIKit

final class FileManagerPersistent {
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
        
        do {
            try data?.write(to: url)
            print("Image save")
            return url
        } catch let error {
            print("Image didn't save \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
        return UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("Deleted image")
        } catch let error {
            print(error)
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
