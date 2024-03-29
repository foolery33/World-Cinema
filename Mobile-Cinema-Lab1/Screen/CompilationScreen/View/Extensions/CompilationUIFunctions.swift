//
//  CompilationUIFunctions.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 11.04.2023.
//

import UIKit
import SnapKit

extension CompilationScreenView {
    @objc func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: card)
        
        let xFromCenter = card.center.x - self.center.x
        
        card.center = CGPoint(x: initialFrontCardCenter.x + point.x, y: initialFrontCardCenter.y + point.y)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / self.divisor)

        if(xFromCenter > 0) {
            frontCompilationCardView.userReactionImageView.image = R.image.like()
        }
        else if(xFromCenter < 0) {
            frontCompilationCardView.userReactionImageView.image = R.image.reject()
        }
        
        frontCompilationCardView.userReactionImageView.alpha = 2 * abs(xFromCenter) / self.center.x
     
        if(sender.state == UIGestureRecognizer.State.ended) {
            if isSwipedAway(card: card) {
                dislikeMovie()
                if isSwipedToLeft(card: card) {
                    // Move off to the left side
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                        card.alpha = 0
                    })
                } else {
                    addToFavourites()
                    // Move off to the right side
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                        card.alpha = 0
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if(self.currentMovieIndex <= self.viewModel.movies.count - 1) {
                        card.center = self.initialFrontCardCenter
                        card.transform = CGAffineTransform(rotationAngle: 0)
                        self.setupImages()
                        self.frontCompilationCardView.userReactionImageView.alpha = 0
                        self.currentMovieIndex += 1
                        card.alpha = 1
                    } else {
                        self.showEmptyScreen()
                    }
                }
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.initialFrontCardCenter
                    self.frontCompilationCardView.userReactionImageView.alpha = 0
                    card.transform = CGAffineTransform(rotationAngle: 0)
                })
            }
        }
    }

    func isSwipedAway(card: UIView) -> Bool {
        return isSwipedToLeft(card: card) || isSwipedToRight(card: card)
    }

    func isSwipedToLeft(card: UIView) -> Bool {
        return card.center.x < 75
    }

    func isSwipedToRight(card: UIView) -> Bool {
        return card.center.x > frame.width - 75
    }

    func showEmptyScreen() {
        self.contentView.removeFromSuperview()
        
        let emptyStack = UIStackView()
        emptyStack.axis = .vertical
        emptyStack.spacing = 32
        emptyStack.alignment = .center
        scrollView.addSubview(emptyStack)
        emptyStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(44)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        let emptyImage = UIImageView(image: R.image.emptyImage()?.resizeImage(newWidth: 213, newHeight: 198))
        emptyStack.addArrangedSubview(emptyImage)
        emptyImage.snp.makeConstraints { make in
            make.width.equalTo(213)
            make.height.equalTo(198)
        }
        
        let emptyLabel = UILabel()
        emptyLabel.text = R.string.compilationScreenStrings.compilation_movies_over()
        emptyLabel.font = .systemFont(ofSize: 24, weight: .regular)
        emptyLabel.textColor = .grayTextColor
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyStack.addArrangedSubview(emptyLabel)
    }
    
    func setupImage() {
        self.backCompilationCardView.removeFromSuperview()
        self.filmLabel.text = self.viewModel.movies[self.currentMovieIndex].name
        self.frontCompilationCardView.cardImageView.loadImageWithURL(self.viewModel.movies[self.currentMovieIndex].poster)
    }
    
    func setupImages() {
        self.backCompilationCardView.cardImageView.loadImageWithURL(self.viewModel.movies[self.currentMovieIndex + 1].poster)
        
        self.filmLabel.text = self.viewModel.movies[self.currentMovieIndex].name
        self.frontCompilationCardView.cardImageView.loadImageWithURL(self.viewModel.movies[self.currentMovieIndex].poster)
    }
    
    @objc func likeAnimation() {
        let initialFrontCardCenter = self.initialFrontCardCenter
        self.frontCompilationCardView.userReactionImageView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.frontCompilationCardView.center = CGPoint(x: self.frontCompilationCardView.center.x + 500, y: self.frontCompilationCardView.center.y - 75)
            let xFromCenter = self.frontCompilationCardView.center.x - self.center.x
            if(xFromCenter > 0) {
                self.frontCompilationCardView.userReactionImageView.image = R.image.like()
            }
            else if(xFromCenter < 0) {
                self.frontCompilationCardView.userReactionImageView.image = R.image.reject()
            }
            self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: xFromCenter / self.divisor)
        }) { finished in
            if(self.currentMovieIndex < self.viewModel.movies.count - 1) {
                self.setupImages()
                self.frontCompilationCardView.userReactionImageView.alpha = 0
                self.frontCompilationCardView.center = initialFrontCardCenter
                self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: 0)
                self.frontCompilationCardView.alpha = 1
                self.currentMovieIndex += 1
            }
            else if(self.currentMovieIndex == self.viewModel.movies.count - 1) {
                self.frontCompilationCardView.center = initialFrontCardCenter
                self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: 0)
                self.setupImage()
                self.frontCompilationCardView.userReactionImageView.alpha = 0
                self.frontCompilationCardView.alpha = 1
                self.currentMovieIndex += 1
            }
            else {
                self.showEmptyScreen()
            }
        }
        self.dislikeMovie()
        self.addToFavourites()
    }
    
    @objc func dislikeAnimation() {
        let initialFrontCardCenter = self.initialFrontCardCenter
        self.frontCompilationCardView.userReactionImageView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.frontCompilationCardView.center = CGPoint(x: self.frontCompilationCardView.center.x - 500, y: self.frontCompilationCardView.center.y - 75)
            let xFromCenter = self.frontCompilationCardView.center.x - self.center.x
            if(xFromCenter > 0) {
                self.frontCompilationCardView.userReactionImageView.image = R.image.like()
            }
            else if(xFromCenter < 0) {
                self.frontCompilationCardView.userReactionImageView.image = R.image.reject()
            }
            self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: xFromCenter / self.divisor)
        }) { finished in
            if(self.currentMovieIndex < self.viewModel.movies.count - 1) {
                self.setupImages()
                self.frontCompilationCardView.userReactionImageView.alpha = 0
                self.frontCompilationCardView.center = initialFrontCardCenter
                self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: 0)
                self.frontCompilationCardView.alpha = 1
                self.currentMovieIndex += 1
            }
            else if(self.currentMovieIndex == self.viewModel.movies.count - 1) {
                self.frontCompilationCardView.center = initialFrontCardCenter
                self.frontCompilationCardView.transform = CGAffineTransform(rotationAngle: 0)
                self.setupImage()
                self.frontCompilationCardView.userReactionImageView.alpha = 0
                self.frontCompilationCardView.alpha = 1
                self.currentMovieIndex += 1
            }
            else {
                self.showEmptyScreen()
            }
        }
        self.dislikeMovie()
    }
    
    func setupSkeleton() {
        self.frontCompilationCardView.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
        self.filmLabel.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor() ?? UIColor.skeletonViewColor)
        self.buttonsStack.isUserInteractionEnabled = false
    }
    
    func stopSkeleton() {
        self.frontCompilationCardView.hideSkeleton()
        self.filmLabel.hideSkeleton()
        self.buttonsStack.isUserInteractionEnabled = true
    }
    
}
