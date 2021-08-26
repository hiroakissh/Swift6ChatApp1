//
//  ChatViewController.swift
//  Swift6ChatApp1
//
//  Created by HiroakiSaito on 2021/08/26.
//

import UIKit
import Firebase
import SDWebImage

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var roomName = String()
    var imageString = String()
    var messages:[Message] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        //カスタムセルの登録
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //もしUserImageがnilでなければ
        if UserDefaults.standard.object(forKey: "userImage") != nil{
            //imageStringにuserImageを入れる
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
            
        }
        //もし、rommNameがなければAllにする
        if roomName == ""{
            
            roomName = "All"
            
        }
        print(roomName)
        //navigationItem.titleにroomNameを入れる
        self.navigationItem.title = roomName
        
        //loadMessage関数を読み込み、引数にroomName
        loadMessages(roomName: roomName)
    }
    
    //Messageの読み込み
    //roomNameを引数として
    func loadMessages(roomName:String){
        print("loadMessagesを読んだよ")
        //dbのroomNameのorderdateをsnapする
        db.collection(roomName).order(by: "date").addSnapshotListener { (snapShot,error) in
            
            self.messages = []
            print("messagesの初期化")
            if error != nil{
                
                print(error.debugDescription)
                return
                
            }
            print("errorなかったよ")
            if let snapShotDoc = snapShot?.documents{
                print("snapShotの読み込み始めるよ")
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    if let sender = data["sender"] as? String,let body = data["body"] as? String,let imageString = data["imageString"] as? String{
                        
                        let newMessage = Message(sender: sender, body: body, imageString: imageString)
                        
                        self.messages.append(newMessage)
                        print(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            print(indexPath)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            
                        }
                        
                    }else {
                        print("読み込めてないよ")
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        
        let message = messages[indexPath.row]
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            
            cell.LeftImageView.isHidden = true
            cell.RightImageView.isHidden = false
            cell.RightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.LeftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            cell.backView.backgroundColor = .systemTeal
            cell.label.textColor = .white
            
        }else{
            
            cell.LeftImageView.isHidden = false
            cell.RightImageView.isHidden = true
            cell.RightImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.LeftImageView.sd_setImage(with: URL(string: messages[indexPath.row].imageString), completed: nil)
            
            cell.backView.backgroundColor = .orange
            cell.label.textColor = .white
            
            
        }
        
        return cell
        
        
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        if let messageBody = messageTextField.text,let sender = Auth.auth().currentUser?.email{
            
            db.collection(roomName).addDocument(data: ["sender":sender,"body":messageBody,"imageString":imageString,"date":Date().timeIntervalSince1970]) { (error) in
                
                if error != nil {
                    
                    print(error.debugDescription)
                    return
                }
                
                //非同期処理
                DispatchQueue.main.async {
                    
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    
                }
                
                
                
                
            }
            
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
