//
//  BookTableCell.swift
//  BookSearcher
//
//  Created by Arman Turalin on 01.03.2022.
//

import UIKit

final class BookTableCell: UITableViewCell {
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.thumbnailCornerRadius
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = highlighted ? .init(scaleX: 0.98, y: 0.98) : .identity
        })
    }
}

// MARK: - Public methods
extension BookTableCell {
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setAuthor(_ text: String) {
        authorLabel.text = text
    }
    
    func setThumbnail(_ image: UIImage?) {
        thumbnailImageView.image = image
    }
}

// MARK: - Private methods
private extension BookTableCell {
    func setupView() {
        selectionStyle = .none
        
        [thumbnailImageView, stackView].forEach(contentView.addSubview(_:))
        [titleLabel, authorLabel].forEach(stackView.addArrangedSubview(_:))
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstant.large),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: Constants.thumbnailSize),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.thumbnailSize),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstraintConstant.large),
            stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: ConstraintConstant.medium),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstraintConstant.large),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstraintConstant.large)
        ])
    }
}

// MARK: - Theme
private extension BookTableCell {
    enum Constants {
        static let thumbnailSize: CGFloat = 48.0
        static let thumbnailCornerRadius: CGFloat = 8.0
    }
}
