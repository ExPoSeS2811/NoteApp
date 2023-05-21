import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    // MARK: GUI Variables
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.text = "Mock text"
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    private lazy var attachmentView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "mockImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.rounded()
        
        return imageView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    // MARK: - Methods
    func set(note: Note) {
        textView.text = note.title + " " + note.description
        guard let imageData = note.image,
              let image = UIImage(data: imageData)  else { return }
        attachmentView.image = image
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        self.view.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        
        view.addGestureRecognizer(recognizer)
        
        setupConstraints()
        setImageHeight()
    }
    
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-10)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc private func hideKeyboard() {
        textView.resignFirstResponder()
    }
}
