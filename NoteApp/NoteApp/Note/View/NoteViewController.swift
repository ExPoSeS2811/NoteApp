import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    // MARK: GUI Variables
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.rounded()
        textView.font = .boldSystemFont(ofSize: 14)
        
        return textView
    }()
    
    private lazy var attachmentView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.rounded()
        
        return imageView
    }()
    
    // MARK: - Properties
    var viewModel: NoteViewModelProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    // MARK: - Methods
    
    // MARK: - Private methods
    private func configure() {
        textView.text = viewModel?.text
//        guard let imageData = note.image,
//              let image = UIImage(data: imageData)  else { return }
//        attachmentView.image = image
    }
    
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        self.view.backgroundColor = .white
        
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        
        view.addGestureRecognizer(recognizer)
        
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
        setupConstraints()
        setImageHeight()
        setupBars()
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
        let height = attachmentView.image != nil ? 300 : 0
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc private func saveAction() {
        viewModel?.save(with: textView.text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)
    }
        
    @objc private func addImageAction() {
        // TODO: add image action
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func setupBars() {
        let trashButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteAction)
        )
        
        let addImage = UIBarButtonItem(
            title: "Add image",
            style: .done,
            target: self,
            action: #selector(addImageAction)
        )
        
        let spacing = UIBarButtonItem(systemItem: .flexibleSpace)
        
        setToolbarItems([trashButton, spacing, addImage], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveAction)
        )
    }
}

extension NoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        
        attachmentView.image = chosenImage
        picker.dismiss(animated: true)
    }
}
