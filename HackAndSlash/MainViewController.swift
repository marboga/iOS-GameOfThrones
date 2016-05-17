//
//  ViewController.swift
//  HackAndSlash
//
//  Created by Michael Arbogast on 5/17/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var heroes: Array<NSDictionary> = []
    
    var rand2: Int = 0
    var personByName: Array<NSDictionary> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    @IBAction func GeneratePersonButtonPressed(sender: UIButton) {
        let random = arc4random_uniform(43)
        print(random)
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://www.anapioficeandfire.com/api/characters?page=\(random)&pageSize=50")
        print(url)
        // Create an NSURLSession to handle the request tasks
        let session = NSURLSession.sharedSession()
        // Create a "data task" which will request some data from a URL and then run a completion handler after it is done
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            do {
//                print("in do here")
                
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                    
                    for i in 0..<jsonResult.count {
                        if let culture: String = String(jsonResult[i]["culture"]!!) {
                            if culture != Optional("") {
                                if culture == "Northmen" || culture == "Ironborn" || culture == "Free Folk" || culture == "Dothraki" || culture == "Tyroshi" {
                                    
                                    self.personByName.append(jsonResult[i] as! NSDictionary)
                                    self.rand2 = Int(arc4random_uniform(UInt32(self.personByName.count/2)))
                                    
                                }
                                
                            }
                        }
                    }
                    print("rand", self.personByName[self.rand2])
                    if self.heroes.count <= 6 {
                        self.heroes.append(self.personByName[self.rand2] )
                        
                    }
                    print(self.heroes)
                } else {
                    print("huh")
                }
            } catch {
                print("Something went wrong")
            }
        })
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        

    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CharacterCell")
        cell!.textLabel?.text = String(self.heroes[indexPath.row]["name"]!)

        switch String(self.heroes[indexPath.row]["culture"]!) {
        case "Northmen":
            cell!.backgroundColor = UIColor.blueColor()
            cell!.textLabel?.textColor = UIColor.whiteColor()
        case "Dothraki":
            cell!.backgroundColor = UIColor.redColor()
        case "Ironborn":
            cell!.backgroundColor = UIColor.blackColor()
            cell!.textLabel?.textColor = UIColor.yellowColor()
        case "Free Folk":
            cell!.backgroundColor = UIColor.greenColor()
            cell!.textLabel?.textColor = UIColor.brownColor()
        case "Tyroshi":
            cell!.backgroundColor = UIColor.yellowColor()
            cell!.textLabel?.textColor = UIColor.purpleColor()
        default:
            break
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        return cell!
        
    }
// delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        heroes.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
// selected one hero, perform segue
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        performSegueWithIdentifier("DetailSegue", sender: nil)
    }
    
    
}

