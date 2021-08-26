//
//  SendToDMModel.swift
//  Swift6ChatApp1
//
//  Created by HiroakiSaito on 2021/08/26.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    
    
    func sendProfileOKDelegate(url:String)
    
}

class SendToDBModel {
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init(){
        
        
        
    }
    
    func sendProfileImagedata(data:Data){
        
        //画像データを取得
        let image = UIImage(data: data)
        //画像データを1/10に圧縮//データ型に変換もしている
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        //パスを準備
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        
        //データをFirebaseStrageにおく
        imageRef.putData(profileImageData!, metadata: nil) { (metaData, error) in
            
            if error != nil{
                
                print(error.debugDescription)
                return
                
            }
            
            //FirebaseStorage内の画像URLが返される
            imageRef.downloadURL { (url, error) in
                
                if error != nil{
                    
                    print(error.debugDescription)
                    return
                    
                }
                //abosoluteStringでURLをStringにしてアプリ内で保存
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
            }
            
        }
        
        
        
    }
    
    
}
