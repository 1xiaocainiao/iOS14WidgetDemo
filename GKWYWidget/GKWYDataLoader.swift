//
//  GKWYDataLoader.swift
//  WidgetDemo
//
//  Created by xxf on 2020/11/18.
//

import Foundation
import UIKit

struct GKWYData {
    let title: String
    let desc: String
    let icon: String
    var bgImage: UIImage?
}

let defaultData = GKWYData(title: "每日音乐推荐", desc: "为你带来每日惊喜", icon: "cm4_disc_type_list", bgImage: UIImage(named: "background"))

struct GKWYDataLoader {
    //注意此接口返回的图片链接是http的不是https,会导致后续图片下载失败，造成Widget图片下载失败,需要做如下步骤
    //    1、在Info.plist中添加 NSAppTransportSecurity 类型 Dictionary ;
    //    2、在 NSAppTransportSecurity 下添加 NSAllowsArbitraryLoads 类型Boolean ,值设为 YES;
    static func request(completion: @escaping (GKWYData) -> Void) {
        guard let url = URL(string: "https://musicapi.qianqian.com/v1/restserver/ting?format=json&from=ios&channel=appstore&method=baidu.ting.billboard.billList&type=1&size=20&offset=0") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil && error == nil {
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                let error_code = json["error_code"] as! Int
                if error_code == 22000, let list = json["song_list"] as? [[String: Any]] {
                    let random = arc4random() % UInt32(list.count)
                    let item = list[Int(random)]
                    
                    let title = item["title"] as! String
                    let author = item["author"] as! String
                    let album = item["album_title"] as! String
                    let desc = author + "-" + album
                    let cover = item["pic_radio"] as! String
                    
                    var image: UIImage? = UIImage(named: "background")
                    
                    if let imageData = try? Data(contentsOf: URL(string: cover)!) {
                        print("图片下载成功")
                        image = UIImage(data: imageData)
                    } else {
                        print("图片下载失败")
                    }
                    
                    let myData = GKWYData(title: title, desc: desc, icon: "cm4_disc_type_list", bgImage: image)
                    completion(myData)
                } else {
                    completion(defaultData)
                }
            } else {
                completion(defaultData)
            }
        }.resume()
    }
}
