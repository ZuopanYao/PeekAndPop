//
//  ViewController.swift
//  PeekAndPop
//
//  Created by Harvey on 2017/10/16.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var datas: [String] = {
        return [
        "https://m.baidu.com",
        "https://m.hao123.com",
        "https://m.163.com",
        "https://m.sohu.com"
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if traitCollection.forceTouchCapability == .available {
            
            registerForPreviewing(with: self, sourceView: view)
            print("3d touch avilable")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let sorce = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {
            
            return;
        }
        
        sorce.preferredContentSize = CGSize(width: 0.0, height: 400)
        sorce.url = datas[indexPath.row]
        show(sorce, sender: self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")!
        let label = cell.viewWithTag(10) as! UILabel
        label.text = datas[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: CGPoint(x: location.x, y: location.y-64.0)) else {

            return nil
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            
            return nil
        }
        
        guard let sorce = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {
            
            return nil;
        }
        
        sorce.preferredContentSize = CGSize(width: 0.0, height: 400)
        sorce.url = datas[indexPath.row]
      
        var rect = cell.frame
        rect.origin.y += 68.0
        previewingContext.sourceRect = rect
        
        print("Peek")
        return sorce
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        print("Pop")
    }
}

