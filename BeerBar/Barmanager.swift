//
//  Barmanager.swift
//  BeerBar
//
//  Created by Виктор Васильков on 16.02.22.
//

import UIKit
import RealmSwift

class Barmanager {
    
    let realm = try! Realm()
    lazy var newBeers: Results<BeerObject> = {self.realm.objects(BeerObject.self)}()

    var cashbox: Double
    var ourBarWorks: Int
    
    static public var shared: Barmanager = Barmanager()
    
    private init() { self.cashbox = 0; self.ourBarWorks = 0 }
//MARK: - Buying
    func setBeerObjects() {
        
        if newBeers.count == 0 {
            
            try! realm.write() {
                let newBeer1 = BeerObject()
                newBeer1.name = "Arctic Ale"
                newBeer1.price = 7.89
                newBeer1.sendingCountry = "British"
                newBeer1.remainderVolume = 100
                self.realm.add(newBeer1)
                let newBeer2 = BeerObject()
                newBeer2.name = "Loerik 1998"
                newBeer2.price = 3.44
                newBeer2.sendingCountry = "Avsralian"
                newBeer2.remainderVolume = 100
                self.realm.add(newBeer2)
                let newBeer3 = BeerObject()
                newBeer3.name = "The End of History"
                newBeer3.price = 2.16
                newBeer3.sendingCountry = "USA"
                newBeer3.remainderVolume = 100
                self.realm.add(newBeer3)
                let newBeer4 = BeerObject()
                newBeer4.name = "Westvleteren XII"
                newBeer4.price = 1.35
                newBeer4.sendingCountry = "Belgium"
                newBeer4.remainderVolume = 100
                self.realm.add(newBeer4)
                let newBeer5 = BeerObject()
                newBeer5.name = "Antarctic Nail Ale"
                newBeer5.price = 3.63
                newBeer5.sendingCountry = "Avsralian"
                newBeer5.remainderVolume = 100
                self.realm.add(newBeer5)
                
            }
            newBeers = realm.objects(BeerObject.self)
        }
    }
    
    func buyBeer(_ name: String,_ count: Double, _ tagOfBeer: Int) -> Double {
        guard let buyingBeer = newBeers.filter({ $0.name == name }).first else { return 0 }
        let price = buyingBeer.price
        cashbox += price
        if count == 0.5 {
            try! realm.write {
                newBeers[tagOfBeer].remainderVolume -= 0.5
            }
        } else if count == 1.0 {
            try! realm.write {
                newBeers[tagOfBeer].remainderVolume -= 1.0
            }
        }
        return cashbox
    }
    func clearBeers() {
        try! realm.write {
            for i in 0..<newBeers.count {
                newBeers[i].remainderVolume = 100
            }
        }
    }

//MARK: - CountMoneyinCashBox
    
    func countMoney() -> Double {
        cashbox
    }
    
//MARK: - StartNewDay
    
    func newDay () -> Double {
        cashbox = 0
        ourBarWorks += 1
        clearBeers()
        return cashbox
    }

}
