//
//  CreatorDetailVC.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Kingfisher
import UIKit

class CreatorDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private func titleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private let comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: CellIdentifier.ComicsCell.rawValue)
        return collectionView
    }()

    private let seriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: CellIdentifier.SeriesCell.rawValue)
        return collectionView
    }()

    private let storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: CellIdentifier.StoriesCell.rawValue)
        return collectionView
    }()

    private var creator: Creator?
    private var comic: Comic?

    init(comic: Comic) {
        self.comic = comic
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()
        setupConstraints()
        configureView()
    }

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(descriptionLabel)

        stackView.addArrangedSubview(titleLabel(title: "Comics"))
        stackView.addArrangedSubview(comicsCollectionView)

        stackView.addArrangedSubview(titleLabel(title: "Series"))
        stackView.addArrangedSubview(seriesCollectionView)

        stackView.addArrangedSubview(titleLabel(title: "Stories"))
        stackView.addArrangedSubview(storiesCollectionView)

        comicsCollectionView.dataSource = self
        comicsCollectionView.delegate = self

        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self

        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            comicsCollectionView.heightAnchor.constraint(equalToConstant: 150),
            seriesCollectionView.heightAnchor.constraint(equalToConstant: 150),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }

    private func configureView() {
        fetchCreator()
    }

    private func fetchCreator() {
        LoadingManager.shared.visible()
        guard let id = comic?.creators.items.first?.id else { return }
        let endpoint = Endpoint.creators(creatorId: id)
        APIService.shared.request(endpoint: endpoint) { (result: Result<MarvelResponse<Creator>, Error>) in
            switch result {
            case .success(let response):
                self.creator = response.data.results.first
                DispatchQueue.main.async {
                    if let url = self.creator?.imageURL {
                        self.imageView.kf.setImage(with: url)
                    }
                    self.nameLabel.text = self.creator?.fullName ?? "\(self.creator?.firstName ?? "") \(self.creator?.lastName ?? "")"
                    self.descriptionLabel.text = "Modified: \(self.creator?.modified ?? "Unknown")"

                    self.comicsCollectionView.reloadData()
                    self.seriesCollectionView.reloadData()
                    self.storiesCollectionView.reloadData()
                    LoadingManager.shared.visible(false)
                }
            case .failure(let error):
                print("Error: \(error)")
                LoadingManager.shared.visible(false)
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        switch collectionView {
        case comicsCollectionView:
            return creator?.comics.items.count ?? 0
        case seriesCollectionView:
            return creator?.series.items.count ?? 0
        case storiesCollectionView:
            return creator?.stories.items.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InfoCell
        switch collectionView {
        case comicsCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ComicsCell.rawValue, for: indexPath) as! InfoCell
            let comic = creator?.comics.items[indexPath.row]
            cell.configure(with: comic?.name ?? "Unknown Comic", borderColor: .red)
        case seriesCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.SeriesCell.rawValue, for: indexPath) as! InfoCell
            let series = creator?.series.items[indexPath.row]
            cell.configure(with: series?.name ?? "Unknown Series", borderColor: .green)
        case storiesCollectionView:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.StoriesCell.rawValue, for: indexPath) as! InfoCell
            let story = creator?.stories.items[indexPath.row]
            cell.configure(with: story?.name ?? "Unknown Story", borderColor: .blue)
        default:
            fatalError("Unexpected collection view")
        }
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) // Set an appropriate item size
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
