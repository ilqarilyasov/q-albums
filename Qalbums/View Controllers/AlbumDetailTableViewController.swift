//
//  AlbumDetailTableViewController.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {
    
    // MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? { didSet { updateViews() }}
    var tempsSongs: [Song] = []

    
    // MARK: - Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtUrlsTextField: UITextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 140
    }
    
    
    // MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempsSongs.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let songCell = cell as! SongTableViewCell
        
        let song = tempsSongs[indexPath.row]
        songCell.song = song
        songCell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    
    // MARK: - Update views
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        if let album = album {
            title = album.name
            albumNameTextField.text = album.name
            artistNameTextField.text = album.artist
            genresTextField.text = album.genres.joined(separator: ", ")
            let urlStr = album.coverArtURLs.map { $0.absoluteString }
            coverArtUrlsTextField.text = urlStr.joined(separator: ", ")
            tempsSongs = album.songs
        } else {
            title = "New Album"
        }
    }
    
    
    // MARK: - SongTableViewCell Delegate
    
    func addSong(with title: String, duration: String) {
        guard let albumController = albumController else { return }
        let song = albumController.createSong(duration: title, title: duration)
        tempsSongs.append(song)
        
        tableView.reloadData()
        let indexPath = IndexPath(row: tempsSongs.count, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}
