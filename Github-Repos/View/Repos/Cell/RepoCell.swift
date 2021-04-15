//
//  RepoCell.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoOwnerNameLbl: UILabel!
    @IBOutlet weak var repoDateLbl: UILabel!
    @IBOutlet weak var reedMeBtn: UIButton!
    
    
    public private (set) var repoUrl: URL?
    
    var repo: RepoCellViewMode? {
        didSet {
            repoNameLbl.text = repo?.name
            repoOwnerNameLbl.text = repo?.OwnerName
            repoDateLbl.getRepoDateFrom(repoUrl: repo?.repoDate ?? "")
            if let imgUrl = repo?.imageUrl {
                repoImageView.downloadFrom(fromLink: imgUrl, contentMode: .scaleAspectFill)
            }
            if let url = repo?.repoUrl {
                repoUrl = url
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
//        repoImageView.kf.cancelDownloadTask()
        repoImageView.image = nil
    }
    
}
