//
//  StandingsPresenter.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

protocol StandingViewPresent: AnyObject {
    init(view: ViewUpdate, _ league: String)
    func viewDidLoad()
    
}

class StandingsPresenter: StandingViewPresent {
    
    
    var ntw: Networking
    var view: ViewUpdate?
    var urlParam: String = ""
    
    required init(view: ViewUpdate, _ league: String) {
        self.view = view
        urlParam = league
        ntw = Networking()
    }

    func viewDidLoad() {
        
        ntw.requestData(from: urlParam, view: view!) { data in
            let decoder = JSONDecoder()

            do {
                let jsonDecoded = try decoder.decode(StandingModel.self, from: data)
                return jsonDecoded as StandingModel
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
