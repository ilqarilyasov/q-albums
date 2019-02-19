//
//  SongTableViewCell.swift
//  Qalbums
//
//  Created by Ilgar Ilyasov on 2/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SongTableViewCellDelegate?
    var song: Song? { didSet { updateViews() }}
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = song?.title,
            let duration = song?.duration else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        songTitleTextField.text = nil
        durationTextField.text = nil
        addSongButton.isHidden = true
    }
    
    
    // MARK: - Update views
    
    private func updateViews() {
        guard let song = song else { return }
        
        songTitleTextField.text = song.title
        durationTextField.text = song.duration
    }
    
}
