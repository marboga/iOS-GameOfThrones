//
//  CharacterDetailController.swift
//  HackAndSlash
//
//  Created by Michael Arbogast on 5/17/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class CharacterDetailController: UITableViewController {
    
    weak var delegate: CharacterDetailProtocol?
    
 
    @IBOutlet var ourHeroDetailsCollection: [UILabel]!
    
    
    var heroToPass: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ourHero = heroToPass {
            print("OUR MOTHER HEROING HERO",ourHero)
            
            if let name = ourHero["name"] {
                ourHeroDetailsCollection[0].text = "Name: \(name)"
            }
            if let house = ourHero["house"] {
                ourHeroDetailsCollection[1].text = "House: \(house)"
            }
            if let culture = ourHero["culture"] {
                ourHeroDetailsCollection[2].text = "Culture: \(culture)"
            }
            if let titles = ourHero["titles"] {
                ourHeroDetailsCollection[3].text = "Title: "
            }
//            if let titles = ourHero["titles"] {
//                ourHeroDetailsCollection[4].text = "Title: \(titles)"
//            }
            if let born = ourHero["born"] {
                ourHeroDetailsCollection[4].text = "Born: \(born)"
            }
            if let gender = ourHero["gender"] {
                ourHeroDetailsCollection[5].text = "Gender: \(gender)"
            }
            
//            ourHeroDetailsCollection[1].text = "House: \(ourHero["house"])"
//            ourHeroDetailsCollection[2].text = "Culture: \(ourHero["culture"])"
//            ourHeroDetailsCollection[3].text = "Aliases: \(ourHero["alias"])"
//            ourHeroDetailsCollection[4].text = "Born: \(ourHero["born"])"
//            ourHeroDetailsCollection[5].text = "Gender: \(ourHero["gender"])"
////            ourHeroDetailsCollection[0].text = "Name: \(ourHero["name"])"
        }
    }
    
   
    
}
