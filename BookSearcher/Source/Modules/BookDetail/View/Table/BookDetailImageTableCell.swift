//
//  BookDetailImageTableCell.swift
//  BookSearcher
//
//  Created by Arman Turalin on 02.03.2022.
//

import UIKit
import SDWebImage

final class BookDetailImageTableCell: UITableViewCell {
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
extension BookDetailImageTableCell {
    func setThumnailPath(_ path: String) {
        thumbnailImageView.sd_setImage(with: URL(string: path))
    }
}

// MARK: - Private methods
private extension BookDetailImageTableCell {
    func setupView() {
        selectionStyle = .none
        [thumbnailImageView].forEach(contentView.addSubview(_:))
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstraintConstant.large),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstraintConstant.medium),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstraintConstant.medium),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstraintConstant.medium)
        ])
    }
}
