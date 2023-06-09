import SnapKit
import UIKit

final class SimpleNoteTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private lazy var wrapperContainerView: UIView = {
        let view = UIView()
        
        view.dropShadow(color: UIColor.color)
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.color
        view.rounded()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Title here"
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(note: Note) {
        titleLabel.text = note.title
    }
    
    // MARK: - Private methods
    private func setupUI() {
        containerView.addSubview(titleLabel)
        wrapperContainerView.addSubview(containerView)
        addSubview(wrapperContainerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        wrapperContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
