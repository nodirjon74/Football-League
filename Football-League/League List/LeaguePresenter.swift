//
//  LeaguePresenter.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import Foundation

protocol LeagueViewPresenter: AnyObject {
    init(view: UpdateView)
    func viewDidLoad()
    
}

class LeaguePresenter: LeagueViewPresenter {
    
    var view: UpdateView?
    
    required init(view: UpdateView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getMethod()
        
    }
    
    //MARK: - Networking
    private func getMethod() {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                DispatchQueue.main.async { [self] in
                
                    self.view!.didUpdateData(parse(data: safeData)!)
                    //print(prettyPrintedJson)
                }
            }
        }.resume()
    }


    private func parse(data: Data) -> LeagueModel? {
        let decoder = JSONDecoder()

        do {
            let jsonDecoded = try decoder.decode(LeagueModel.self, from: data)
            return jsonDecoded
        } catch {
            view?.didFailWithError(error: error)
        }
        print("Error")
        return nil
    }
    
}
