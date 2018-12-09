//
//  AddCatViewController.swift
//  Toy2
//
//  Created by Mai Phuong Vu on 12/8/18.
//  Copyright © 2018 Citassy. All rights reserved.
//

import UIKit

var addCatViewController : AddCatViewController? = nil

class AddCatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var isPickerViewOpened :  Bool = false
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    @IBAction func DoneButtonTapped(_ sender: Any) {
       // let nameCell = TableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddCatTableViewCell
      //  let typeCell = TableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddCatTableViewCell
      //  let name = nameCell.TextView.text
      //  let type = typeCell.TextView.text
        Cat.addCat(name: name, age: age, image: #imageLiteral(resourceName: "cat1"), type: type)
        name = ""
        type = ""
        age = -1
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ClearButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
       // addCatViewController = self

        DoneButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Table View Methods
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 2
        }
        else{
            if (isPickerViewOpened){
                return 2
            }
            else{
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCatCell", for: indexPath) as! AddCatTableViewCell
        cell.TextView.tag = indexPath.row
        cell.TextView.textContainer.maximumNumberOfLines = 1;
        cell.TextView.textContainer.lineBreakMode = .byTruncatingTail
        cell.PickerView.isHidden = true
        
        if (indexPath.section == 0){
            cell.TextView.isEditable = true
            cell.TextView.textColor = UIColor.gray
            cell.TextView.isScrollEnabled = false
            if(indexPath.row == 0){
                cell.TextView.text = "Name"
            }
            else{
                cell.TextView.text = "Type"
            }
        }
        else{
            if(indexPath.row == 0){
                cell.TextView.isEditable = false
                cell.TextView.isSelectable = false
                cell.TextView.textColor = UIColor.black
                cell.TextView.isUserInteractionEnabled = false
                //cell.TextView.text = "Age"
                cell.TextView.isHidden = false
                if (age == -1){
                    cell.TextView.text = "Age"
                }
                else{
                    cell.TextView.text = "Age " + String(age)
                }
            }
            else{
                cell.TextView.isHidden = true
                cell.PickerView.isHidden = false
            }
        }
        cell.addCatViewController = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 10
        }
        else{
            if(indexPath.row == 0){
                return 50
            }
            else{
                return 100
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if (indexPath.section == 1 && indexPath.row == 0){
            if (isPickerViewOpened) {
                isPickerViewOpened = false
            }
            else{
                isPickerViewOpened = true
            }
            TableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
