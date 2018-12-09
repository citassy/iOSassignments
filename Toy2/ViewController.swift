//
//  ViewController.swift
//  Toy2
//
//  Created by Mai Phuong Vu on 11/16/18.
//  Copyright © 2018 Citassy. All rights reserved.
//

import UIKit

extension UIViewController{
    func dismissKeyBoardWhenTappingAround(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(false)
    }
}
class ViewController: UIViewController {
    
    var submitted : Bool = false

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var ClassLabel: UILabel!

    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var ClassTextField: UITextField!
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBOutlet weak var DisplayLabel: UILabel!
    
    func enterClearMode() -> Void {
        NameLabel.isHidden = true
        ClassLabel.isHidden = true
        NameTextField.isHidden = true
        ClassTextField.isHidden = true
        DisplayLabel.isHidden = false
        SubmitButton.setTitle("Clear", for: .normal)
        submitted = true
        
    }
    
    func enterSubmitMode() -> Void{
        NameLabel.isHidden = false
        ClassLabel.isHidden = false
        NameTextField.isHidden = false
        ClassTextField.isHidden = false
        DisplayLabel.isHidden = true
        SubmitButton.setTitle("Submit", for: .normal)
        submitted = false
    }
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        if (submitted){
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "class")
            enterSubmitMode()
        }
        else{
            let name = NameTextField.text ?? ""
            let classYr = ClassTextField.text ?? ""
            DisplayLabel.text = "Welcome, " + name + " of " + classYr + "!"
            NameTextField.text = ""
            ClassTextField.text = ""
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(classYr, forKey: "class")
            enterClearMode()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyBoardWhenTappingAround()
        if(UserDefaults.standard.object(forKey: "name") != nil
            &&
            UserDefaults.standard.object(forKey: "class") != nil) {
            let name = UserDefaults.standard.string(forKey: "name")
            let classYr = UserDefaults.standard.string(forKey: "class")
            DisplayLabel.text = "Welcome, " + name! + " of " + classYr! + "!"
            enterClearMode()
        }
        else{
            enterSubmitMode()
        }
        
        if (Cat.count == 0){
           // Cat.addCat(name: "Alice", age: 1, image: #imageLiteral(resourceName: "cat1"), type: "British Shorthair")
           // Cat.addCat(name: "Bob", age: 2, image: #imageLiteral(resourceName: "cat2"), type: "American Shorthair")
           // Cat.addCat(name: "Karen", age: 4, image: #imageLiteral(resourceName: "cat3"), type: "American Shorthair")
            //Cat.loadCats()
            Cat.loadCats{ (result) in
                for dict in result {
                    let imageURL = URL(string: dict["image"]!)
                    let image = UIImage(data: try! Data(contentsOf: imageURL!))
                    Cat.addCat(name: dict["name"]!, age: Int(dict["age"]!), image: image, type: dict["type"]!)
                }
                
            }
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


    
}

