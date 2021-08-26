//
//  RoomViewController.swift
//  Swift6ChatApp1
//
//  Created by HiroakiSaito on 2021/08/26.
//

import UIKit
import ViewAnimator

class RoomViewController: UIViewController,UITabBarDelegate,UITableViewDataSource, UITableViewDelegate {

    
    
    
    var roomNameArray = ["誰でも話そうよ！","20代たまり場！","1人ぼっち集合","地球住み集合！！","好きなYoutuberを語ろう","大学生集合！！","高校生集合！！","中学生集合！！","暇なひと集合！","A型の人！！"]
    var roomImageStringArray = ["0","1","2","3","4","5","6","7","8","9"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.isHidden = false
        
        //書き直す必要があるs
        let animation = AnimationType.from(direction: .top, offset: 300)
        UIView.animate(views: tableView.visibleCells, animations: [animation],delay: 0,duration: 2)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roomNameArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: roomImageStringArray[indexPath.row])
        
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = roomNameArray[indexPath.row]
        
         
        
        
        
        //cell.imageView?.image = UIImage(named: roomImageStringArray[indexPath.row])
        //cell.imageView?.contentMode = .scaleAspectFill
        //cell.textLabel!.text = roomNameArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "roomChat", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let roomChatVC = segue.destination as! ChatViewController
        //roomNameに受け渡し
        roomChatVC.roomName = roomNameArray[sender as! Int]
        
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
