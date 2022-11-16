//
//  DetailsMovieViewController.swift
//  MVVM
//

import UIKit

class DetailsMovieViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    var selectedMovie: Movies?

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(selectedMovie)
    }

    // MARK: - Configure
    func configure(_ movie: Movies?) {
        nameLabel.text = selectedMovie?.name
        overviewTextView.text = selectedMovie?.overview
    }
}
