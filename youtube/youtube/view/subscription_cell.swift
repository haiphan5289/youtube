//
//  subscription_cell.swift
//  youtube
//
//  Created by HaiPhan on 6/26/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class subscription_cell: feed_cell {
    override func setup_view() {
        super.setup_view()
    }
    override func get_array_video() {
        api_serivce.share.fetch_video_share { (array_video_share) in
            self.array_video = array_video_share
            DispatchQueue.main.async {
                self.collect_feed.reloadData()
            }
        }
    }
}
