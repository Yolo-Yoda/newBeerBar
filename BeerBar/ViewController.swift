//
//  ViewController.swift
//  BeerBar
//
//  Created by Виктор Васильков on 16.02.22.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var menu: [UILabel]!
    
    @IBOutlet weak var markCashbox: UILabel!
    
    @IBOutlet weak var startNewDay: UIButton!
    
    @IBOutlet weak var daysOnWork: UILabel!
    
    @IBOutlet var litres05: [UIButton]!
    
    @IBOutlet var litres10: [UIButton]!
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Barmanager.shared.setBeerObjects()
        markMenu()
        markCashbox.text = "Now cashbox: \(Barmanager.shared.cashbox) $"
    }
    
//MARK: - Mark Buttons
    func markMenu() {
        for paragraphmenu in menu {
            paragraphmenu.text = """
                            Name: \(Barmanager.shared.newBeers[i].name),
                            Price: \(Barmanager.shared.newBeers[i].price)$,
                            Country: \(Barmanager.shared.newBeers[i].sendingCountry)
                            Remainder: \(Barmanager.shared.newBeers[i].remainderVolume)
                            """
            i += 1
        }
        for i in litres05 {
            i.setTitle("0.5 L", for: .normal)
        }
        for i in litres10 {
            i.setTitle("1.0 L", for: .normal)
        }
        startNewDay.setTitle("hand over the cashier", for: .normal)
        daysOnWork.text = "Our BAR works: \(Barmanager.shared.ourBarWorks) day"
        i = 0
    }

//MARK: - WhatHappendWhanPushButton
    
    //0.5
    
    @IBAction func pushButton05(_ sender: UIButton) {
        let name = Barmanager.shared.newBeers[sender.tag].name
        markCashbox.text = "Now cashbox: \(Barmanager.shared.buyBeer(name, 0.5, sender.tag)) $"
        markMenu()
    }
        
    //1.0
    
    @IBAction func pushButton10(_ sender: UIButton) {
        let name = Barmanager.shared.newBeers[sender.tag].name
        
        markCashbox.text = "Now cashbox: \(Barmanager.shared.buyBeer(name, 1.0, sender.tag)) $"
        markMenu()
    }
    
    @IBAction func pushstartNewDay(_ sender: UIButton) {
        markCashbox.text = "Now cashbox: \(Barmanager.shared.newDay()) $"
        markMenu()
        daysOnWork.text = "Our BAR works: \(Barmanager.shared.ourBarWorks) day"
    }
    
}
