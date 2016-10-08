//
//  LoginViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 17/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    var logar:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground();
        navigationItem.imageNavigation();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!

    @IBAction func logar(sender: AnyObject) {
        
        verificaLogin()
        
        
        if(self.logar){
        self.performSegueWithIdentifier("LoginMapaSegue", sender: self)
        }else{
            
        }
        
        
    }
    
    
    func verificaLogin()
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://gustavocalixto.pe.hu/index.php/cliente")!)
        request.HTTPMethod = "POST"
        do {
            let json = ["login":txtLogin.text! , "senha": txtSenha.text!]
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            
            
            request.HTTPBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                                          print("error=\(error)")
                    return
                }
                
                do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                let resultado  = json as? [[String: AnyObject]]
                
                for lines in resultado!  {
                    if let result = lines["result"] as? Bool {
                        self.logar = result
                    }
                    
                }
                }
                catch {
                    
                }
            }
            task.resume()
        
        } catch {
        }
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
