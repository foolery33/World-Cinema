//
//  ProfileSectionsTableView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit

class ProfileSectionsTableView: UITableView {

    private let sections: [(UIImage, String)] = [(UIImage(named: "Chat")!, "Обсуждения"), (UIImage(named: "Clock")!, "История"), (UIImage(named: "Settings")!, "Настройки")]
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        separatorStyle = .none
        self.register(ProfileSectionTableViewCell.self, forCellReuseIdentifier: ProfileSectionTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileSectionsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSectionTableViewCell.identifier, for: indexPath) as! ProfileSectionTableViewCell
        
        let section = sections[indexPath.row]
        cell.setup(image: section.0, sectionName: section.1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
}

extension ProfileSectionsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}


extension ProfileSectionsTableView {
    func countHeight() -> CGFloat {
        return 44 * CGFloat(sections.count)
    }
}
