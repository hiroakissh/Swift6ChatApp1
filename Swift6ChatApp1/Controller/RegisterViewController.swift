//
//  RegisterViewController.swift
//  Swift6ChatApp1
//
//  Created by HiroakiSaito on 2021/08/26.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var emailTextFileld: UITextField!
    @IBOutlet weak var passwodTextField: UITextField!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var sendToDBModel = SendToDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkModel = CheckPermission()
        checkModel.showCheckPermission()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touroku(_ sender: Any) {
        
        //emailTextfiledがからでない,passtextがからでないことを確認
        
        if emailTextFileld.text?.isEmpty != true && passwodTextField.text?.isEmpty != true, let image = profileImageView.image{
            
            Auth.auth().createUser(withEmail: emailTextFileld.text!, password: passwodTextField.text!) { (result, error) in
                
                if error != nil{
                    print(error.debugDescription)
                    return
                
                }
                
                let data = image.jpegData(compressionQuality: 1.0)
                
                self.sendToDBModel.sendProfileImageData(data: data!)
                
                
                
            }
            
        }
        
        //登録
        
        //emailTextField,profileImage値
        
        
    }
    
    
    @IBAction func tapImageView(_ sender: Any) {
        
        //カメラまたはアルバムから選択
        
        //アラートを出す
        showAlert()
        
        
        
    }
    
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //ライブラリ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if info[.originalImage] as? UIImage != nil{
                
                let selectedImage = info[.originalImage] as! UIImage
                profileImageView.image = selectedImage
                picker.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        
        //アラート
        func showAlert(){
            
            let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
            
            let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
                
                self.doCamera()
                
            }
            let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
                
                self.doAlbum()
                
            }

            let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
            
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(action3)
            self.present(alertController, animated: true, completion: nil)
            
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
