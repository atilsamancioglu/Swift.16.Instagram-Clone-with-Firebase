//
//  FirstViewController.swift
//  Firebase Instagram Clone
//
//  Created by Atıl Samancıoğlu on 30/01/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
        var userNameArray = [String]()
        var postTextArray = [String]()
        var postImageURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromServer()
    
    }
    
    
    func getDataFromServer() {
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            
            
            let values = snapshot.value! as! NSDictionary
            
            let posts = values["posts"] as! NSDictionary
            
            let postIDs = posts.allKeys
            
            for id in postIDs {
                
                let singlePost = posts[id] as! NSDictionary
                
                self.userNameArray.append(singlePost["postedby"] as! String)
                self.postTextArray.append(singlePost["posttext"] as! String)
                self.postImageURLArray.append(singlePost["image"] as! String)
                
            }
            
            self.tableView.reloadData()
            
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.postText.text = postTextArray[indexPath.row]
        cell.userName.text = userNameArray[indexPath.row]
        cell.postImage.sd_setImage(with: URL(string: self.postImageURLArray[indexPath.row]))
        

        return cell
    }
 
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "usersigned")
        UserDefaults.standard.synchronize()
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signUp
        
        delegate.rememberLogin()
        
    }
    


}

