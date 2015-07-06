//
//  DNService.swift
//  Sends OAuthToken to server in HTTP Header
//  and requests JSON data
//
//  Created by Jiashan Wu on 7/5/15.
//

import Alamofire

struct DNService {
    //Doc: https://coffeeapi.percolate.com/
    
    private static let baseURL = "https://coffeeapi.percolate.com"
    private static var OAuthToken = "*" // Paste token here
    
    
    static func poffeesForSection(section: String, response: (JSON) -> ()) {
        let manager = Alamofire.Manager.sharedInstance
        let urlString = baseURL + "/api/coffee/" + section

        let URL =  NSURL(string: urlString)
        var mutableUrlRequest = NSMutableURLRequest(URL: URL!)
        mutableUrlRequest.HTTPMethod = Alamofire.Method.GET.rawValue
        mutableUrlRequest.setValue(OAuthToken, forHTTPHeaderField:"Authorization")

        manager.request(mutableUrlRequest).responseJSON { (_, _, data, error) in
            let poffees = JSON(data ?? [])
            //println(poffees)
            response(poffees)
        }
    }


}
