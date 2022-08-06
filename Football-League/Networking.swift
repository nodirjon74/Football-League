//
//  Networking.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

protocol ViewUpdate {
    func didUpdateData(_ model: Codable)
    func didFailWithError(error: Error)
}

struct Networking {
    

    func getMethod(_ url: String, view: ViewUpdate, completion: @escaping (_ data: Data) -> Codable?, onFailure: () -> Void ) {
        guard let url = URL(string: "https://api-football-standings.azharimm.site/leagues" + url) else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                DispatchQueue.main.async {
                    let datas = completion(safeData)
                    view.didUpdateData(datas!)
                    //print(prettyPrintedJson)
                }
            }
        }.resume()
    }
    
}
