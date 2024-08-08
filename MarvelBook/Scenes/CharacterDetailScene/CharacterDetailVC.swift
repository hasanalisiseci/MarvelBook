//
//  CharacterDetailVC.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Kingfisher
import SwiftUI
import UIKit

class CharacterDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
        return tableView
    }()

    var character: Character?
    private var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)

        setupConstraints()
        configureView()
        fetchEvents()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func configureView() {
        guard let character = character else { return }

        nameLabel.text = character.name
        descriptionLabel.text = character.description.isEmpty ? "No Description Available" : character.description

        if let url = URL(string: "\(character.thumbnail.path).\(character.thumbnail.extension)") {
            imageView.kf.setImage(with: url)
        }
    }

    private func fetchEvents() {
        LoadingManager.shared.visible()
        guard let characterId = character?.id else { return }

        let endpoint = Endpoint.events(characterId: characterId)
        APIService.shared.request(endpoint: endpoint) { (result: Result<MarvelResponse<Event>, Error>) in
            switch result {
            case let .success(response):
                self.events = response.data.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    LoadingManager.shared.visible(false)
                }
            case let .failure(error):
                print("Error: \(error)")
                LoadingManager.shared.visible(false)
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.title
        cell.contentConfiguration = UIHostingConfiguration(content: {
            EventCellView(event: event)
        })
        return cell
    }
}
