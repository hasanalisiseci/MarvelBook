//
//  ComicsCollectionVC.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import UIKit

class ComicsCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private var comics: [Comic] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ComicCellView.self, forCellWithReuseIdentifier: CellIdentifier.ComicCell.rawValue)

        setupConstraints()
        fetchComics()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func fetchComics() {
        LoadingManager.shared.visible()
        let endpoint = Endpoint.comics
        APIService.shared.request(endpoint: endpoint) { (result: Result<MarvelResponse<Comic>, Error>) in
            switch result {
            case let .success(response):
                self.comics = response.data.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    LoadingManager.shared.visible(false)
                }
            case let .failure(error):
                print("Error: \(error)")
                LoadingManager.shared.visible(false)
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return comics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ComicCell.rawValue, for: indexPath) as! ComicCellView
        let comic = comics[indexPath.item]
        cell.configure(with: comic)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedComic = comics[indexPath.item]
        let detailViewController = CreatorDetailVC(comic: selectedComic)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
