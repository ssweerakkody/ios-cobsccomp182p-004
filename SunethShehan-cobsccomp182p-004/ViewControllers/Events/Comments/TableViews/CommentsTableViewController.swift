//
//  CommentsTableViewController.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/29/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit


class CommentsTableViewController: UITableViewController {
    
    
    var selectedEventID :String?
    
    var CommentIDs = [String]()
    var Comments = [Comment](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backimage.jpg")!)
        
        
        
        FirestoreClient.getComments(selectedEventID: "jEvuIE6R7lS6ijMofasV",completion: { comments in
          
            self.Comments.removeAll()
            if(comments.count != 0)
            {
                self.Comments = comments
            }
            
        })
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Comments.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell",for: indexPath) as! CommentsTableViewCell
        
        let comment = Comments[indexPath.row]
        
        cell.lblCommentText.text = comment.CommentText
        
        cell.lblCommetedBy.text = comment.CommentedBy
        
        let imageURL = URL(string: comment.CommnetedUserImage)
        cell.imgUser.kf.setImage(with: imageURL)
        
        return cell
    }
    
    
    @IBAction func AddComment(_ sender: Any) {
        
        let ac = UIAlertController(title: "Enter Comment", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        
        ac.addAction(UIAlertAction(title: "Post", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            
            let comment = Comment(CommentID: UUID().uuidString,CommentedBy: UserDefaults.standard.string(forKey: "DisplayName") as Any as! String, CommentText: answer.text!, CommnetedUserImage: UserDefaults.standard.string(forKey: "ProfileImageUrl")as Any as! String)
        
            
            FirestoreClient.addComment(eventID:"jEvuIE6R7lS6ijMofasV", newComment: comment,presentingVC: self,completion: { isAdded in
                
                if(isAdded)
                {
                     self.tableView.reloadData()
                }
                
            })
            
        })
        
        
        present(ac, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // share item at indexPath
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    
}
