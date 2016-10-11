//
//  PerfilViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 07/10/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var fotoJogador: UIImageView!
    @IBOutlet weak var txtApelido: UILabel!
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtIdade: UILabel!
    @IBOutlet weak var txtTelefone: UILabel!
    
    @IBOutlet weak var txtLatLong: UILabel!
    
    var tipoUsu:String = ""
    var id:Int = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        navigationItem.imageNavigation()

        if(tipoUsu == "J"){
            getJogador(id)
        }
        else{
            getQuadra(id)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getJogador(id: Int){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/jogador.php/consultar_jogador")!)
        request.HTTPMethod = "POST"
        let json = ["id": String(id) ]
        
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            
            request.HTTPBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                                          print("error=\(error)")
                    return
                }
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let resultado = json["result"] as? [[String: AnyObject]] {
                        
                    
                    for lines in resultado {
                        if let apelido = lines["apelido"] as? String {
                            self.txtApelido.text = apelido
                        }
                        if let nome = lines["nome"] as? String {
                            self.txtNome.text = nome
                        }
                        if let idade = lines["idade"] as? String {
                            self.txtIdade.text = idade
                        }
                        if let telefone = lines["telefone"] as? String {
                            self.txtTelefone.text = telefone
                        }
                        if let latLong = lines["latLong"] as? String {
                            self.txtApelido.text = latLong
                        }
                        
                    }
                    }
                }
                catch {
                    
                }
                
            }
            task.resume()
        }catch{
        }
    }
    
    func getQuadra(id: Int){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/quadra/consultar_quadra")!)
        request.HTTPMethod = "POST"
        let json = ["id": String(id) ]
        
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            
            request.HTTPBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                                          print("error=\(error)")
                    return
                }
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let resultado = json["result"] as? [[String: AnyObject]] {
                        
                        
                        for lines in resultado {
                            if let apelido = lines["apelido"] as? String {
                                self.txtApelido.text = apelido
                            }
                            if let nome = lines["nome"] as? String {
                                self.txtNome.text = nome
                            }
                            if let idade = lines["idade"] as? String {
                                self.txtIdade.text = idade
                            }
                            if let telefone = lines["telefone"] as? String {
                                self.txtTelefone.text = telefone
                            }
                            if let latLong = lines["latLong"] as? String {
                                self.txtApelido.text = latLong
                            }
                            
                        }
                    }
                }
                catch {
                    
                }
                
            }
            task.resume()
        }catch{
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
