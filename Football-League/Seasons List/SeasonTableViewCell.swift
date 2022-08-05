//
//  SeasonTableViewCell.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {
    
    lazy var year: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var startDate: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var endDate: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var displayName: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.lineBreakMode = .byClipping
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var types: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var dateStack: UIStackView = {
        var stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fillEqually
        stk.spacing = 40
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    lazy var typeStack: UIStackView = {
        var stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fillEqually
        stk.spacing = 40
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    lazy var mainStack: UIStackView = {
        var stk = UIStackView()
        stk.axis = .vertical
        stk.distribution = .fillProportionally
        stk.spacing = 7
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(displayName)
        mainStack.addArrangedSubview(dateStack)
        mainStack.addArrangedSubview(typeStack)
        
        dateStack.addArrangedSubview(startDate)
        dateStack.addArrangedSubview(types)
        
        typeStack.addArrangedSubview(endDate)
        typeStack.addArrangedSubview(year)
        
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leftAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            mainStack.rightAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            mainStack.bottomAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            dateStack.heightAnchor
                .constraint(equalToConstant: 20),
            typeStack.heightAnchor
                .constraint(equalToConstant: 20)

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
