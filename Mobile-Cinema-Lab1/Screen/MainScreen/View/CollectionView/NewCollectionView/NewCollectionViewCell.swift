//
//  NewCollectionViewCell.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class NewCollectionViewCell: UICollectionViewCell {
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.showAnimatedSkeleton(usingColor: UIColor(red: 33/255, green: 21/255, blue: 18/255, alpha: 1))
        setupViews()
        setupPosterImageView()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
    }

    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with movie: MovieModel) {
        posterImageView.loadImageWithURL(movie.poster) {
            self.hideSkeleton()
        }
    }
}

extension NewCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIImageView {
    func loadImageWithURL(_ url: String, contentMode: ContentMode = ContentMode.scaleAspectFill, completion: (() -> Void)? = nil) {
        let url = URL(string: url)
        self.contentMode = contentMode
        self.kf.setImage(with: url) { _ in
            if completion != nil {
                completion!()
            }
        }
    }
    func loadImageOnMainThread(_ url: String) {
        if let url = URL(string: url) {
            // Проверяем, есть ли данные в кэше
            if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {

                // Если есть, используем кэшированные данные для создания изображения
                let image = UIImage(data: cachedResponse.data)
                self.image = image

            } else {

                // Если данных в кэше нет, загружаем их и добавляем в кэш
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let response = response {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        URLCache.shared.storeCachedResponse(cachedData, for: URLRequest(url: url))
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.image = image
                        }
                    }
                }.resume()
            }
            contentMode = .scaleAspectFill
        }
    }
}
