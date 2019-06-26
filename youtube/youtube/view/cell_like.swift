//
//  cell_like.swift
//  youtube
//
//  Created by HaiPhan on 6/26/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class cell_like: feed_cell {
    override func setup_view() {
        super.setup_view()
    }
    override func get_array_video() {
        api_serivce.share.fetch_video_like { (array_video_json) in
            self.array_video = array_video_json
            DispatchQueue.main.async {
                self.collect_feed.reloadData()
            }

        }
    }
}
