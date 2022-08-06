//
//  StandingsTableViewCell.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    
    lazy var displayName: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var displayValue: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 1
        lbl.textAlignment = .right
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var mainStack: UIStackView = {
        var stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fillProportionally
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(displayName)
        mainStack.addArrangedSubview(displayValue)
        
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leftAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            mainStack.rightAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            mainStack.bottomAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            displayValue.widthAnchor
                .constraint(equalToConstant: 100)

        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
