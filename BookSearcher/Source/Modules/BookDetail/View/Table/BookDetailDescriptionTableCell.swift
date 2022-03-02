//
//  BookDetailDescriptionTableCell.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit

final class BookDetailDescriptionTableCell: UITableViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = ConstraintConstant.small
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold) // TODO: - Add font manager
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14) // TODO: - Add font manager
        label.textColor = UIColor.black.withAlphaComponent(0.8) // TODO: - Add color manager
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16) // TODO: - Add font manager
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
}

// MARK: - Public methods
extension BookDetailDescriptionTableCell {
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setAuthor(_ text: String) {
        authorLabel.text = text
    }
    
    func setDescription(_ text: String) {
        descriptionLabel.text = text
    }
}

// MARK: - Private methods
private extension BookDetailDescriptionTableCell {
    func setupView() {
        selectionStyle = .none
        [stackView, descriptionLabel].forEach(contentView.addSubview(_:))
        [titleLabel, authorLabel].forEach(stackView.addArrangedSubview(_:))
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstraintConstant.large),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstant.large),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstraintConstant.large),

            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: ConstraintConstant.large),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstant.large),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstraintConstant.large),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstraintConstant.large)
        ])
    }
}
