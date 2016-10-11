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
        
        
        
        if(verificaLogin()){
        self.performSegueWithIdentifier("LoginMapaSegue", sender: self)
        }else{
            
        }
        
        
    }
    
    
    func verificaLogin() -> Bool
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/usuario.php/login")!)
        request.HTTPMethod = "POST"
        var resultado:Bool = false
        
        var semaphore = dispatch_semaphore_create(0)
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
                    let json : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                
                    resultado  = json.valueForKey("result") as! Bool
                    dispatch_semaphore_signal(semaphore)
                }catch {
                    
                    
                }
                
            }
           
            
            task.resume()
        
        
        } catch {
    
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    return resultado
        
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
