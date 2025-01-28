//
//  CoinTableViewCell.swift
//  CoinRanking
//
//  Created by Abdulrahman Foda on 28.01.25.
//

import UIKit
import SwiftUI
import Kingfisher



class CoinTableViewCell: UITableViewCell {
    static let identifier = "CoinTableViewCell"

    // Hosting controller for the SwiftUI view
    private var hostingController: UIHostingController<CoinImageView>?

    // Other UI Components
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Create a vertical stack view for the labels
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, changeLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        labelStack.alignment = .leading

        contentView.addSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80), // Leave space for image
            labelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with coin: Coin) {
        // Set text for labels
        nameLabel.text = coin.name
        priceLabel.text = coin.priceFormatted()
        changeLabel.text = coin.changeFormatted()
        changeLabel.textColor = coin.changeColor()

        // Embed the CoinImageView for the coin icon
        embedSwiftUIView(CoinImageView(imageUrl: coin.iconUrl))
    }

    private func embedSwiftUIView(_ swiftUIView: CoinImageView) {
        if hostingController == nil {
            // Create hosting controller for SwiftUI view
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingController.view)

            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                hostingController.view.widthAnchor.constraint(equalToConstant: 40), // Set fixed size for the image
                hostingController.view.heightAnchor.constraint(equalToConstant: 40)
            ])
            self.hostingController = hostingController
        } else {
            // Update root view for reusability
            hostingController?.rootView = swiftUIView
        }
    }
}
