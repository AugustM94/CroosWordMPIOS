//
//  gameData.swift
//  crosswords
//
//  Created by August Møbius on 13/01/16.
//  Copyright © 2016 drades. All rights reserved.
//
import Foundation

class DataManager{
    var mostRecentFetch: JSON = []
    let urlPath = "http://geniaz.com/crosswords/gamedata.php"
    
    
    func getDataFromRemote(){
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
    
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            var jsonResult: AnyObject?
                print("did start action")
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    print(error!.localizedDescription)
                }
    
                do{
                    print(data);
                    jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print(JSON(jsonResult!)[0]["board"])
                    self.mostRecentFetch = JSON(jsonResult!)
                } catch {
                    print("error2")
                }
         
            })
            
            task.resume()
    }
    
    func getMostRecentFetch() -> JSON{
        return mostRecentFetch
    }
    
    func parseNewUserInput(column: Int, row: Int, value: String){
        let url = NSURL(string: urlPath)
        /*let json = ["col":column, "row":row, "value":value]
        
        
        var jsonData: NSData!
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
        } catch {
            print("Error")
        }
        */
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        //request.HTTPBody = jsonData
        let postString: String = "function=2&row=\(row)&col=\(column)&val=\(value)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){   data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            do {
                if let responseJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [String:AnyObject]{
                    print(responseJSON)
                }
            } catch {
                print("error")
            }
        }
        
        task.resume()
        
    }
    
    
    
    
    
    
    
}
