//
//  TableViewCell.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var lblStack: UIStackView = {
        var stk = UIStackView()
        stk.axis = .vertical
        stk.distribution = .fillProportionally
        stk.spacing = 10
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    lazy var leagueImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = frame.height / 1.5
        img.clipsToBounds = true
        return img
    }()
    
    lazy var leagueName: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.lineBreakMode = .byClipping
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var leagueAbr: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6462910633)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(leagueImage)
        self.contentView.addSubview(lblStack)
        
        lblStack.addArrangedSubview(leagueName)
        lblStack.addArrangedSubview(leagueAbr)
        
        NSLayoutConstraint.activate([
            leagueImage.centerYAnchor
                .constraint(equalTo:self.contentView.centerYAnchor),
            leagueImage.leadingAnchor
                .constraint(equalTo:self.contentView.leadingAnchor, constant:10),
            leagueImage.widthAnchor
                .constraint(equalToConstant:70),
            leagueImage.heightAnchor
                .constraint(equalToConstant:70),
            lblStack.leftAnchor
                .constraint(equalTo: leagueImage.rightAnchor, constant: 10),
            lblStack.rightAnchor
                .constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            lblStack.centerYAnchor
                .constraint(equalTo:self.contentView.centerYAnchor),
            lblStack.heightAnchor
                .constraint(equalToConstant: 70)
        ])
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
