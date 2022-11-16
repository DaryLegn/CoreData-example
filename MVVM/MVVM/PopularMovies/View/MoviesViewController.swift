//
//  ViewController.swift
//  MVVM
//

import UIKit
import CoreData

class MoviesViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let manager = CoreDataManager.shared
    private var viewModel = MoviesViewModel()
    private lazy var fetchedResultController: NSFetchedResultsController<Movies> =
        {
            let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
            fetchRequest.fetchBatchSize = 20
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            controller.delegate = self
        return controller
    }()

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        getDataContent()
    }

    // MARK: - Get Content
    func getDataContent() {
        do {
            try fetchedResultController.performFetch()
            print("Count: \(String(describing: fetchedResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("Error: \(error)")
        }

        let service = ApiManager()
        service.getMoviesRequest { (result) in
            switch result {
            case .success(let data):
                self.viewModel.clearData()
                self.viewModel.saveMovie(data.results)
            case .error(let message):
                print("Error: \(message)")
            }
        }
    }
}

// MARK: - TableViewDataSource
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        let movie = fetchedResultController.object(at: indexPath) as Movies
        cell.configure(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailsMovieViewController
        let navController = UINavigationController(rootViewController: controller)
        let movie = fetchedResultController.object(at: indexPath) as Movies
        controller.selectedMovie = movie
        controller.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated:true, completion: nil)
    }
}
// MARK: -  NSFetchedResultsControllerDelegate
extension MoviesViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
