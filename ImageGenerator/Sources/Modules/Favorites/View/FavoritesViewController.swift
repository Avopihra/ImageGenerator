//
//  FavoritesViewController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    //MARK: - Private Properties

    private var presenter: FavoritesPresenter?
    private var favorites: [ImageData] = []
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.getFavorites()
        self.configureNavigationBar()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainThread {
            self.presenter?.getFavorites()
        }
    }
    
    //MARK: - Private Methods

    private func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = translate("Favorite.favorites")
        titleLabel.textColor = .black
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupTableView() {
        guard let tableView = self.tableView else {
            return
        }
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil),
                           forCellReuseIdentifier: "FavoriteCell")
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.rowsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteCell.self), for: indexPath) as? FavoriteCell, favorites.count > 0 else {
            return UITableViewCell()
        }
        guard let imageData = favorites[indexPath.row].data else {
            return UITableViewCell()
        }
        let imageRequest = favorites[indexPath.row].request
        cell.setCellContent(data: imageData,
                            text: ReferenceGenerator.sourceStringURL(size: defaultImageSize, text: imageRequest))
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
        if editingStyle == .delete {
            Vibration.notificationOccured(notificationType: .success)
            presenter?.removeFromFavorites(at: indexPath.row)
        } else {
            Vibration.vibrate(style: .medium)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - ViewProtocol Methods

extension FavoritesViewController: FavoritesViewProtocol {
    func displayFavorites(_ favorites: [ImageData]) {
        self.favorites = favorites
        self.tableView?.reloadData()
    }
    
    func displayError(_ message: String) {
        Vibration.notificationOccured(notificationType: .error)
        AlertManager.showErrorAlert(from: self, message: message)
    }
}

//MARK: - Presenter Setup

extension FavoritesViewController {
    func setup(presenter: FavoritesPresenter?) {
        self.presenter = presenter
    }
}
