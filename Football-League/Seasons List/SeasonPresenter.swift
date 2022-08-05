//
//  SeasonPresenter.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

protocol SeasonViewPresent: AnyObject {
    init(view: UpdateView1)
    func viewDidLoad()
    func dateFormat(_ str: String) -> String
}


class SeasonPresnter: SeasonViewPresent {
    
    var view: UpdateView1?
    
    required init(view: UpdateView1) {
        self.view = view
    }
    
    func viewDidLoad() {
        getMethod()
    }
    
    func dateFormat(_ str: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mmZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: str) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
            return ""
        }
        
    }
    
    //MARK: - Networking
    private func getMethod() {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues/arg.1/seasons") else {
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


    private func parse(data: Data) -> SeasonsModel? {
        let decoder = JSONDecoder()

        do {
            let jsonDecoded = try decoder.decode(SeasonsModel.self, from: data)
            return jsonDecoded
        } catch {
            view?.didFailWithError(error: error)
        }
        print("Error")
        return nil
    }
}
