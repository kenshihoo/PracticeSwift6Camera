//
//  CheckPermission.swift
//  Swift6Camera
//
//  Created by Kenshiro on 2020/12/05.
//

//カメラの使用許可のアラートを出すためのプログラム

import Foundation
import Photos

class checkPermission {
    //ユーザに許可を促す
    func checkCakmera(){
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
            case .authorized:
                print("許可されました")
            case .notDetermined:
                print("選択してません")
            case .restricted:
                print("カメラを使えません")
            case .denied:
                print("ユーザによって拒否されました")
            case .limited:
                print("制限付きで許可されています")
            @unknown default:
                break
            }
        }
    }
    
}
