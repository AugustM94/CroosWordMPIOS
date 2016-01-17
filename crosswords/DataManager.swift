//
//  gameData.swift
//  crosswords
//
//  Created by August Møbius on 13/01/16.
//  Copyright © 2016 drades. All rights reserved.
//
import Foundation

class DataManager{
    var remoteBoardContent: NSArray!
    //var mostRecenFetch: JSON = []
    let urlPath = "http://geniaz.com/crosswords/gamedata.php"
    
    func getDataFromRemote(){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlPath)
        print("attempt to get json from server")
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            var jsonResult: AnyObject?
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            else{
                do{                    
                    jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    // get the entire board as an NSArray from the JSON string
                    let boardContentArray = jsonResult![0]["board"] as NSArray?
                    if let dataString = (boardContentArray!.description as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
                        let boardArray = try NSJSONSerialization.JSONObjectWithData(dataString, options: []) as! NSArray
                        
                        self.remoteBoardContent = boardArray
                        print("succesfully fetched json from remote")
                    }
                } catch let caught as NSError{
                    print("error2\(caught)")
                }
            }
        }
        task.resume()
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
    
    func getRemoteTileText (column: Int, row: Int) -> String?{
        let remoteBoardContenColumn = remoteBoardContent[row] as! NSArray
        return remoteBoardContenColumn[column] as? String
    }

    /*
        getters and setters
    */
    
    
    func getRemoteBoardContent() -> NSArray{
        return remoteBoardContent
    }
}
