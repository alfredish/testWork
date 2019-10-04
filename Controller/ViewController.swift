//
//  ViewController.swift
//  testWork
//
//  Created by кирилл корнющенков on 01/10/2019.
//  Copyright © 2019 кирилл корнющенков. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,XMLParserDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - all Var
    var posts:[Post] = []
    var parser = XMLParser()
    var elementName: String = String()
    var Title = String()
    var pubDate = String()
    var full_text = String()

    var index:Int = 0
    
    var myRefreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    //MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.titleLabel.text = String(posts[indexPath.row].title!)
        cell.contentLabel.text = String(posts[indexPath.row].pubDate!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        performSegue(withIdentifier: "show", sender: nil)
    }
   
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = myRefreshControl
        
        tableView.tableFooterView = UIView()
        
        updateData()
    
        
    }
    

    //MARK: - refresh
    @objc private func refresh(sender:UIRefreshControl){
        posts.removeAll()
        updateData()
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    //MARK: - updateData
    private func updateData(){
        if let path = NSURL(string: "http://www.vesti.ru/vesti.rss"){
            if let parser = XMLParser(contentsOf: path as URL) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    
    //MARK: - XMLParser Delegate
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "item" {
            Title = String()
            pubDate = String()
            full_text = String()
        }

        self.elementName = elementName
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let post = Post(title: Title, pubDate: pubDate, full_text: full_text)
            posts.append(post)
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       
        if (!data.isEmpty) {
            if self.elementName == "title" {
                Title += data
            }
            if self.elementName == "pubDate" {
                pubDate += data
            }
            if self.elementName == "yandex:full-text" {
                full_text += data
            }
           
  
           
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? sECONDViewController{
            editViewController.contentText = posts[index].full_text
            editViewController.titleText = posts[index].title
        }
    }

}
