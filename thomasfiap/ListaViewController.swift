//
//  ListaViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 29/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedTipo: UISegmentedControl!
    @IBOutlet weak var tableLista: UITableView!
    var idJogador:[Int] = [1,2]
    var listaJogador:[String] = ["José", "Fracasso"]
    var idQuadra:[Int] = [1,2]
    var listaQuadra:[String] = ["Quadra Boleiros", "Quadra Fracasso"]
    
    var lastSelectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        navigationItem.imageNavigation()
        mudarLista(segmentedTipo)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var returnValue = 0
        if(segmentedTipo.selectedSegmentIndex == 0){
            returnValue = listaJogador.count
        }else{
            returnValue = listaQuadra.count
        }
        
        
        return returnValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("cellListaUsu", forIndexPath: indexPath)
        if(segmentedTipo.selectedSegmentIndex == 0){//Jogador
            myCell.textLabel?.text = listaJogador[indexPath.row]
        }else{//Quadra
            myCell.textLabel?.text = listaQuadra[indexPath.row]
        }
        
        
        return myCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.lastSelectIndex = indexPath.item
        
        self.performSegueWithIdentifier("ListaPerfilSegue", sender: self)
        
        
    }
    
    @IBAction func mudarLista(sender: AnyObject) {
        if(segmentedTipo.selectedSegmentIndex == 0){
            getListJogador()
        }else{
            getListQuadra()
        }
        
        tableLista.reloadData()
    }
    
    func getListJogador(){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/jogador.php/listar_jogador")!)
        request.HTTPMethod = "POST"
        let json = ["latitude": 0.0, "longitude":0.0 ]
        
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
                    self.listaJogador = []
                    self.idJogador = []
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let resultado = json["result"] as? [[String: AnyObject]] {
                        
                        
                        for lines in resultado {
                            if let id = lines["id"] as? Int {
                                self.idJogador.append(id)
                            }
                            if let nome = lines["nome"] as? String {
                                self.listaJogador.append(nome)
                            }
                           
                            
                        }
                    }
                    dispatch_semaphore_signal(semaphore)
                    
                }
                catch {
                    
                }
                
            }
            task.resume()
        }catch{
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func getListQuadra(){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://11mob.890m.com/quadra.php/listar_quadra")!)
        request.HTTPMethod = "POST"
        let json = ["latitude": 0.0, "longitude":0.0 ]
        
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
                    self.listaQuadra = []
                    self.idQuadra = []
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let resultado = json["result"] as? [[String: AnyObject]] {
                        
                        
                        for lines in resultado {
                            if let id = lines["id"] as? Int {
                                self.idQuadra.append(id)
                            }
                            if let nome = lines["nome"] as? String {
                                self.listaQuadra.append(nome)
                            }
                            
                            
                        }
                    }
                    dispatch_semaphore_signal(semaphore)
                    
                }
                catch {
                    
                }
                
            }
            task.resume()
        }catch{
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }


    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "ListaPerfilSegue"{
            let otherView = segue.destinationViewController as! PerfilViewController
            if(segmentedTipo.selectedSegmentIndex == 0){
            otherView.tipoUsu = "J"
                otherView.id = self.lastSelectIndex + 1;
            }else{
            otherView.tipoUsu = "Q"
                otherView.id = self.lastSelectIndex + 1;
            }
            
        }
        
        
     }
    

}
