//
//  ViewController.swift
//  Swift6Camera
//
//  Created by Kenshiro on 2020/12/03.
//

import UIKit
import Photos

class ViewController: UIViewController,
                      //カメラを使う際に必要なデリゲート
                      UIImagePickerControllerDelegate       ,UINavigationControllerDelegate {
    
    //CheckPermission内のcheckPermissionクラスを使うために初期化(変数化した)
    var checkUseFunction = checkPermission()
    
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUseFunction.checkCakmera()
    }

    @IBAction func cameraButton(_ sender: Any) {
        //カメラを起動させる(同時にカメラを使う許可も行う)
        let cameraFunction:UIImagePickerController.SourceType = .camera
        activeFunction(functionType: cameraFunction)
    }
    
    
    @IBAction func albumButton(_ sender: Any) {
        //アルバムを起動させる(同時にアルバムを使う許可も行う)
        let albumFunction:UIImagePickerController.SourceType = .photoLibrary
        activeFunction(functionType: albumFunction)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        
        let shareText = ""
        //シェアする画像を圧縮して使用(jpedDataがその指示)
        let shareImage = backImageView.image?.jpegData(compressionQuality: 0.5)
         let shareItem = [shareText,shareImage as Any]
        //アクションシートを使うために初期化(変数にした)
        let activityVC = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
        //アクションシートをViewControllerに表示
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    //カメラやアルバムの機能を起動するときに使うメソッド
    func activeFunction(functionType:UIImagePickerController.SourceType){
        
        let functionPicker = UIImagePickerController()
        
            functionPicker.sourceType = functionType
            //編集の許可の可否
            functionPicker.allowsEditing = true
        //UIImagePickerControllerが持っているデリゲートをViewControllerクラスでも使えるように委任した
            functionPicker.delegate = self
        //カメラを起動
        self.present(functionPicker, animated: true, completion: nil)
    }
    //キャンセルボタンで、カメラやアルバムの機能が終了されたときに使うメソッド
    //該当メソッドをPhotosがもっている
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //撮影画面やアルバム画面を終了
        picker.dismiss(animated: true, completion: nil)
    }
    
    //撮影 or アルバムでの画像選択が完了したときにつかうメソッド
    //該当メソッドをPhotosがもっている
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage{
            //撮影 or アルバムで選択された画像をbackImageViewに反映
            backImageView.image = pickedImage
            //撮影画面やアルバム画面を終了
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

