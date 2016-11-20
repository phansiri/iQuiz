//
//  SubjectsTableViewCell.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/2/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class SubjectCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    func configureCell(subject: Subject) {
        titleLabel.text = subject.title
        descLabel.text = subject.desc
        imageLabel.image = UIImage(named: (subject.imageFile)!)
        imageLabel.layer.borderWidth = 1
        imageLabel.layer.cornerRadius = 4
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
