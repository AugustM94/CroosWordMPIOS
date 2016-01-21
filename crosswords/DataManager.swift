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
    var succesfullyFetchedFromRemote = false
    var dataQueue: [(Int, Int, String)] = []
    //var mostRecenFetch: JSON = []
    let urlPath = "http://geniaz.com/crosswords/crosswordgamedata.php"
    

    func getDataFromRemote(){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: self.urlPath)
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
                    print(jsonResult)
                    // get the entire board as an NSArray from the JSON string
                    let boardContentArray = jsonResult![0]["board"] as NSArray?
                    if let dataString = (boardContentArray!.description as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
                        let boardArray = try NSJSONSerialization.JSONObjectWithData(dataString, options: []) as! NSArray
                        
                        self.remoteBoardContent = boardArray
                        self.succesfullyFetchedFromRemote = true
                        print("succesfully fetched json from remote")
                    }
                } catch let caught as NSError{
                    print("error2\(caught)")
                }
            }
        }
        task.resume()
    }
    

    
    func uploadNewUserInput(column: Int, row: Int, value: String){
        //addTaskToQueue(column, row: row, value: value)
        let url = NSURL(string: self.urlPath)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        //request.HTTPBody = jsonData
        let postString: String = "function=1&row=\(row)&col=\(column)&val=\(value)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){   data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                print("add user input to queue")
                return
            } else if data != nil{
                var responseString: NSString = ""
                responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                if responseString == "1" {
                    print("succesful upload")
                    print("row=\(row)&col=\(column)&val=\(value)")
                    self.removeTaskFromQueue(column, row: row)
                } else {
                    print("add user input to queue")
                }
            }
            
        }
        print("dataQueue: \(dataQueue.count)")
        task.resume()
    }
    
    func uploadDataQueueToRemote(){
        for dataTask in dataQueue {
            uploadNewUserInput(dataTask.0, row: dataTask.1, value: dataTask.2)
            //print("Column: \(dataTask.0), Row: \(dataTask.1), Value: \(dataTask.2)")
        }
    }
    
    func removeTaskFromQueue(column: Int, row: Int){
        print(dataQueue.count)
        for (index, dataTask) in dataQueue.enumerate(){
            if dataTask.0 == column && dataTask.1 == row{
                dataQueue.removeAtIndex(index)
                print("Removal: \"(index)")
            }
        }
    }
    
    func addTaskToQueue(column: Int, row: Int, value: String){
        for (index, dataTask) in dataQueue.enumerate(){
            if dataTask.0 == column && dataTask.1 == row{
                dataQueue[index] = (column, row, value)
                return
            }
        }
        dataQueue.append((column,row,value))
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
