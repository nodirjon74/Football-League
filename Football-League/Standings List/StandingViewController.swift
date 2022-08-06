//
//  StandingViewController.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import UIKit

class StandingViewController: UIViewController {
    
    //MARK: - Properties
    var expandedSectionHeaderNumber: Int = -1

    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    var kHeaderSectionTag = 6900
    
    // MARK: - Properties
    var standings: [Standings] = []
    var standingsModel: StandingModel?
    var present: StandingsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        present.viewDidLoad()
        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        navigationItem.title = "Standings"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor
                .constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor
                .constraint(equalTo: self.view.heightAnchor)
        ])
    }
    

}

extension StandingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if standings.count > 0 {
            return standings.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            
            let arrayOfItems = standings[section].stats
            return arrayOfItems.count
            
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.standings.count != 0) {
            return self.standings[section].team.displayName
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.5019607843, blue: 0, alpha: 1)
        header.textLabel?.textColor = UIColor.white

        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18))
        theImageView.image = UIImage(named: "Chevron-Dn-Wht")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)

    // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(StandingViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StandingsTableViewCell
        let section = self.standings[indexPath.section].stats[indexPath.row]
        cell.displayName.text = section.displayName
        cell.displayValue.text = section.displayValue

        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView

        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.standings[section].stats
        self.expandedSectionHeaderNumber = -1
        if (sectionData.count == 0) {
            
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.tableView.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        
        let sectionData = self.standings[section].stats
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1
            
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            
            self.expandedSectionHeaderNumber = section
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.tableView.endUpdates()
        }
    }
    
    
}

extension StandingViewController: ViewUpdate {
    
    func didUpdateData(_ model: Codable) {
        standingsModel = (model as! StandingModel)
        standings = standingsModel!.data.standings
        tableView.reloadData()
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
