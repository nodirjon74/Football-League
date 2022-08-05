//
//  StandingsPresenter.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

protocol StandingViewPresent: AnyObject {
    init(view: StandingsView)
    func viewDidLoad()
}

class StandingsPresenter: StandingViewPresent {
    
    var view: StandingsView?
    
    required init(view: StandingsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getMethod()
    }
    
    //MARK: - Networking
    private func getMethod() {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/arg.1/standings?season=2020&sort=asc") else {
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


    private func parse(data: Data) -> StandingModel? {
        let decoder = JSONDecoder()

        do {
            let jsonDecoded = try decoder.decode(StandingModel.self, from: data)
            return jsonDecoded
        } catch {
            view?.didFailWithError(error: error)
        }
        print("Error")
        return nil
    }
    
}
