//
//  MoviesTableViewCell.swift
//  MVVM
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    // MARK: - Configure
    func configure(with movie: Movies) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        titleLabel.text = movie.name
        guard let posterURL = movie.posterPath else { return }
        let url = baseURL + posterURL
        downloadImage(urlString: url)
    }

    // MARK: - Download Image
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.image = UIImage(data: data)
        }
    }
}
