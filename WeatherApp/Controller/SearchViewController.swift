//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 21.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchResult = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            dismiss(animated: true) {
                WeatherManager.shared.fetchWeather(with: searchResult)
                DailyForecastManager.shared.fetchWeather(with: searchResult)
            }
        }
    }
}
