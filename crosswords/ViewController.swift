//
//  ViewController.swift
//  crosswords
//
//  Created by Martin Meincke on 05/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        let urlPath = "http://geniaz.com/crosswords/service.php"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
        var jsonResult: NSArray = ["August"]
            print("did start action")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            do{
                jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                print("made it")
            } catch {
                print("error")
            }
            if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                print("JSON Error \(err!.localizedDescription)")
            }
            
            if let results: NSArray = jsonResult {
                dispatch_async(dispatch_get_main_queue(), {
                    print(results)
                })
            }else{
                print("failed to load")
            }
        })
        
        task.resume()
        
        }
}

