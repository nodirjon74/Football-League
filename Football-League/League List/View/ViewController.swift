//
//  ViewController.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import UIKit

protocol UpdateView: AnyObject {
    
    func didUpdateData(_ model: LeagueModel)
    func didFailWithError(error: Error)
}

class ViewController: UIViewController {
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView
            .translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        label.text = "No items yet wait..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        present.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    // MARK: - Properties
    var leaguedata: [LeagueData] = []
    var present: LeagueViewPresenter!
    
    
    
//    MARK: - SETUP UI
    private func setupUI() {

        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.view.addSubview(placeholderLabel)
        
        navigationItem.title = "League"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor
                .constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor
                .constraint(equalTo: self.view.heightAnchor),
            placeholderLabel.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            placeholderLabel.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor)
        ])
    }

}

// MARK: - TABLE VIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = self.leaguedata.isEmpty
        placeholderLabel.isHidden = !self.leaguedata.isEmpty
        return leaguedata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.leagueName.text = leaguedata[indexPath.row].name
        cell.leagueAbr.text = leaguedata[indexPath.row].abbr
        cell.leagueImage.image = UIImage(data: try! Data(contentsOf: URL(string: leaguedata[indexPath.row].logos.light)!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = SeasonsViewController()
        let present = SeasonPresnter(view: newViewController)
        newViewController.present = present
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
//MARK: - Protocol Impl

extension ViewController: UpdateView {
    func didUpdateData(_ model: LeagueModel) {
        leaguedata = model.data
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


