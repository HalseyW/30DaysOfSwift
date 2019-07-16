//
//  ArtistListViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/16.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {
    let feedParser = FeedParser()
    let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    var news = [(title: String, content: String, date: String)]()
    var cellState = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Apple Hot News"
        self.view.backgroundColor = .lightGray
        
        tableView.separatorStyle = .none
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)

        feedParser.parseFeed(feedURL: feedURL) { [weak self] news in
            self?.news = news
            self?.cellState = Array(repeating: false, count: news.count)
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell
        let item = news[indexPath.row]
        cell.selectionStyle = .none
        (cell.labelTitle.text, cell.labelDate.text, cell.labelContent.text) = (item.title, item.date, item.content)
        cell.labelContent.numberOfLines = cellState[indexPath.row] ? 0 : 2
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let newExpandState = !cellState[indexPath.row]
        cell.labelContent.numberOfLines = newExpandState ? 0 : 2
        cellState[indexPath.row] = newExpandState
        tableView.endUpdates()
        
        if newExpandState {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

class FeedParser: NSObject, XMLParserDelegate {
    fileprivate var rssItems = [(title: String, content: String, date: String)]()
    fileprivate var currentElement = ""
    fileprivate var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    fileprivate var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    fileprivate var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    fileprivate var parserCompletionHandler: (([(title: String, content: String, date: String)]) -> Void)?
    
    func parseFeed(feedURL: String, completionHandler: (([(title: String, content: String, date: String)]) -> Void)?) -> Void {
        parserCompletionHandler = completionHandler
        
        guard let feedURL = URL(string:feedURL) else {
            print("feed URL is invalid")
            return
        }
        
        URLSession.shared.dataTask(with: feedURL, completionHandler: { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data fetched")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }).resume()
    }
    
    // MARK: - XMLParser Delegate
    func parserDidStartDocument(_ parser: XMLParser) {
        rssItems.removeAll()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /// Note: current string may only contain part of info.
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = (title: currentTitle, content: currentDescription, date: currentPubDate)
            rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
