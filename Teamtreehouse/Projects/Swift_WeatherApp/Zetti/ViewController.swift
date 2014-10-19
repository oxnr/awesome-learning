//
//  ViewController.swift
//  Zetti
//
//  Created by Onur Akpolat on 28/09/14.
//  Copyright (c) 2014 Onur Akpolat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    // Read keys from keys.plist TODO
    //var dict = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")!)
    
    private let apiKeyForecast = "276897e4c78bcf6d69a234213296bc29"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshActivityIndicator.hidden = true
        getCurrentWeatherData()
    }

    func getCurrentWeatherData() -> Void {
        var location = "52.516318,13.416529"
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKeyForecast)/")
        let forecastURL = NSURL(string: location, relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location:NSURL!, response: NSURLResponse!, error:NSError!) -> Void in
            
            if (error == nil){
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary:weatherDictionary)
                
                // Submit closure async to main thread because UI interaction
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon!
                    self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    
                    // Stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshButton.hidden = false
                    self.refreshActivityIndicator.hidden = true
                    
                })
            } else {
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data", preferredStyle: .Alert)
                let okButtton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButtton)
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    // Stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshButton.hidden = false
                    self.refreshActivityIndicator.hidden = true
                    
                })
            }
            
        })
        downloadTask.resume()
    }
    
    @IBAction func refresh() {
        
        getCurrentWeatherData()
        
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

