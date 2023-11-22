//
//  CustomTableViewCell.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow unlimited number of lines for dynamic cell height
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: CustomTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "Cell")

        contentView.addSubview(labelTitle)

        // Set up constraints for your custom UI elements
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    // Configure the cell with data
    func configure(with text: String) {
        labelTitle.text = text
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
