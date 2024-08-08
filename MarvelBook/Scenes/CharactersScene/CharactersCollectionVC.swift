//
//  CharactersCollectionVC.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import UIKit

class CharactersCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UI.Size.Screen.width - 48) / 2, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCellView.self, forCellWithReuseIdentifier: CellIdentifier.CharCell.rawValue)

        setupConstraints()
        fetchCharacters()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func fetchCharacters() {
        LoadingManager.shared.visible()
        APIService.shared.request(endpoint: .characters) { (result: Result<MarvelResponse<Character>, Error>) in
            switch result {
            case let .success(response):
                self.characters = response.data.results
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
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.CharCell.rawValue, for: indexPath) as! CharacterCellView
        let character = characters[indexPath.item]
        cell.configure(with: character)
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        let detailVC = CharacterDetailVC()
        detailVC.character = character
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
