//
//  UILabelExt.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

extension UILabel {
    func getRepoDateFrom(repoUrl: String) {
        NetworkServices.request(endPoint: Repos_EndPoints.getDate(dateURL: repoUrl), responseClass: ReposDetailsData.self) { (dateResponse, error) in
            DispatchQueue.main.async {
                if let dateString = dateResponse?.createdAt {
                    self.convertDateFrom(date: dateString)
                }else {
                    self.text = ""
                }
            }
        }
        
    }
    
    func convertDateFrom(date: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateStyle = .full
        dateFormatterPrint.locale = Locale(identifier: "en_EH")
        
        if let date = dateFormatterGet.date(from: date) {
            self.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
            self.text = "date format error"
        }
    }
}
