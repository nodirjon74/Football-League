//
//  SeasonPresenter.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

protocol SeasonViewPresent: AnyObject {
    init(view: ViewUpdate, _ league: String)
    func viewDidLoad()
    func dateFormat(_ str: String) -> String
}


class SeasonPresnter: SeasonViewPresent {
    
    var ntw: Networking
    var view: ViewUpdate?
    var urlParam: String = ""
    
    required init(view: ViewUpdate, _ league: String) {
        self.view = view
        urlParam = league
        ntw = Networking()
    }
    
    func viewDidLoad() {
        //MARK: - Networking
        ntw.requestData(from: urlParam, view: view!) { data in
            let decoder = JSONDecoder()

            do {
                let jsonDecoded = try decoder.decode(SeasonsModel.self, from: data)
                return jsonDecoded as SeasonsModel
            } catch {
                self.view?.didFailWithError(error: error)
            }
            print("Error")
            return nil
        } onFailure: {
            print("ERROR on Closure")
        }

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
    
}
