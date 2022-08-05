//
//  SeasonsViewController.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import UIKit

protocol UpdateView1: AnyObject {
    
    func didUpdateData(_ model: SeasonsModel)
    func didFailWithError(error: Error)
}

class SeasonsViewController: UIViewController {
    
    // MARK: - Properties
    var seasondata: [Seasons] = []
    var present: SeasonViewPresent!
    
    

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
        tableView.tableFooterView = UIView()
        tableView.register(SeasonTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //    MARK: - SETUP UI
    private func setupUI() {
        
        self.view.addSubview(tableView)
        
        view.backgroundColor = .white
        
        navigationItem.title = "Seasons"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SeasonsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = self.seasondata.isEmpty
        return seasondata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SeasonTableViewCell
        cell.displayName.text = seasondata[indexPath.row].displayName
        cell.startDate.text = "Starts: " + present.dateFormat(seasondata[indexPath.row].startDate)
        cell.endDate.text = "Ends: " + present.dateFormat(seasondata[indexPath.row].endDate)
        cell.types.text = "Types: " + "\(seasondata[indexPath.row].types.count)"
        cell.year.text = "Year: " + "\(seasondata[indexPath.row].year)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = StandingViewController()
        let present = StandingsPresenter(view: newViewController)
        newViewController.present = present
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}

extension SeasonsViewController: UpdateView1 {
    func didUpdateData(_ model: SeasonsModel) {
        self.seasondata = model.data.seasons
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
