//
//  CadastroViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 17/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {
    
    var cadastrado:Bool = false
    
    @IBOutlet weak var segmentedJogQua: UISegmentedControl!
    
    @IBOutlet weak var NomePlayer: UILabel!
    @IBOutlet weak var labelTelefone: UILabel!
    
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground();
        
        labelLatitude.hidden = true
        labelLongitude.hidden = true
        txtLatitude.hidden = true
        txtLongitude.hidden = true
        
navigationItem.imageNavigation();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBAction func trocaPerfil(sender: AnyObject) {
        
        if(segmentedJogQua.selectedSegmentIndex == 0) {
            
            NomePlayer.text = "Nome de Boleiro"
            labelLatitude.hidden = true
            labelLongitude.hidden = true
            txtLatitude.hidden = true
            txtLongitude.hidden = true
            
        } else {
            
            NomePlayer.text = "Nome da Quadra"
            labelLatitude.hidden = false
            labelLongitude.hidden = false
            txtLatitude.hidden = false
            txtLongitude.hidden = false
        }
        
    }

    @IBAction func logarFb(sender: AnyObject) {
    }
    @IBAction func cadastrar(sender: AnyObject) {
        
        if(segmentedJogQua.selectedSegmentIndex == 0) {
            cadastrado = addJogador()
        } else {
           cadastrado = addQuadra()
        }
        
        if(cadastrado){
            self.performSegueWithIdentifier("CadastroMapaSegue", sender: self)
        }else{
            
        }
        
    }
    
    func addJogador() -> Bool{
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/jogador.php/add_jogador")!)
        request.HTTPMethod = "POST"
        let json = ["email":txtEmail.text! , "login": txtLogin.text!, "senha": txtSenha.text!, "telefone": txtTelefone.text!]
        var resultado:Bool = false
        
        var semaphore = dispatch_semaphore_create(0)
        do{
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
                dispatch_semaphore_signal(semaphore)            }
            catch {
                dispatch_semaphore_signal(semaphore)
            }

        }
        task.resume()
        }catch{
            dispatch_semaphore_signal(semaphore)
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return resultado

    }
    
    
    func addQuadra() -> Bool{
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/quadra.php/add_quadra")!)
        request.HTTPMethod = "POST"
        let json = ["email":txtEmail.text! , "login": txtLogin.text!, "senha": txtSenha.text!, "telefone": txtTelefone.text!, "latitude":txtLatitude.text!, "longitude":txtLongitude.text!]
        var resultado:Bool = false
        
        var semaphore = dispatch_semaphore_create(0)
        do{
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
                    dispatch_semaphore_signal(semaphore)                }
                catch {
                    dispatch_semaphore_signal(semaphore)
                }
                
            }
            task.resume()
        }catch{
            dispatch_semaphore_signal(semaphore)
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
