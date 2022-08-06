//
//  LeaguePresenter.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import Foundation

protocol LeagueViewPresenter: AnyObject {
    init(view: ViewUpdate)
    func viewDidLoad()
    
}

class LeaguePresenter: LeagueViewPresenter {
    
    var ntw: Networking
    var view: ViewUpdate?
    
    required init(view: ViewUpdate) {
        self.view = view
        ntw = Networking()
    }
    
    func viewDidLoad() {
        ntw.requestData(from: "", view: view!) { data in
            let decoder = JSONDecoder()

            do {
                let jsonDecoded = try decoder.decode(LeagueModel.self, from: data)
                return jsonDecoded as LeagueModel
            } catch {
                self.view?.didFailWithError(error: error)
            }
            print("Error")
            return nil
        } onFailure: {
            print("ERROR on Closure")
        }
        
    }

}
