//
//  FriendViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 20.02.2023.
//

import UIKit
import SnapKit
import SideMenu


// MARK: Page Information of Friend
final class FriendViewController: UIViewController {
    
    // MARK: Outlets
    
    var nickName: String
    
    var avatarImage: UIImage
    
    var name: String

    var surname: String
    
    var job: String
    
    var gender: String
    
    var publicationResult: Int
    
    var subscriptionResult: Int
    
    var subscriberResult: Int
    
    var posts: [Post]
    
    var photos: [Photo]
    
    var albums: [Album]
    
    var comments: [[String]]
    
    let viewModel = FriendViewModel()
    
    private enum CellReuseIdentifiers: String {
        case posts
        case photos
    }
    
    
    lazy var postsTableView: UITableView = {
        let postsTableView = UITableView(frame: .zero, style: .grouped)
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue)
        postsTableView.register(FriendPhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        return postsTableView
    }()
    
    init(nickName: String, avatarImage: UIImage, name: String, surname: String, job: String, gender: String, publicationResult: Int, subscriptionResult: Int, subscriberResult: Int,posts: [Post], photos: [Photo], albums: [Album], comments: [[String]]) {
        self.nickName = nickName
        self.avatarImage = avatarImage
        self.name = name
        self.surname = surname
        self.job = job
        self.gender = gender
        self.posts = posts
        self.photos = photos
        self.albums = albums
        self.comments = comments
        self.publicationResult = publicationResult
        self.subscriptionResult = subscriptionResult
        self.subscriberResult = subscriberResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItem?.tintColor = Tint.orange
        
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    
    @objc func openMenu() {
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(postsTableView)
        
        postsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: Extension Table view

extension FriendViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if tableView == postsTableView {
            count = 2
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.photos.rawValue) as! FriendPhotosTableViewCell
            cell.rightPointerButton.addTarget(self, action: #selector(openPhotosAction), for: .touchUpInside)
            cell.photos = photos
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.posts.rawValue) as! PostsTableViewCell
            cell.userImageView.image = avatarImage
            cell.surnameLabel.text = surname
            cell.nameLabel.text = name
            cell.jobLabel.text = job
            cell.commentLabel.text = "\(3)"
            cell.postTextLabel.attributedText = makeAttributedString(title: "", subtitle: post.description)
            cell.postImageVIew.image = post.image
            cell.likesLabel.text = "\(post.likes)"
            cell.dateLabel.text = post.date.toString(dateFormat: "MMM d")
            
            // MARK: Like Action / Adding a post to favourite posts
            let tapRecognizer = TapGestureRecognizer(block: { [self] in
                if ((CoreDataManager.shared.posts.contains( where: { $0.descript == post.description })))  {
                    presentAlert(title: "", message: "the_post_has_been_already_added".localized)
            } else {
                cell.likeButton.tintColor = .red
                cell.likesLabel.text = "\(post.likes + 1)"
                CoreDataManager.shared.addNewPost(surname: surname, name: name, description: post.description)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            }
        })
            tapRecognizer.numberOfTapsRequired = 1
            cell.likeButton.isUserInteractionEnabled = true
            cell.likeButton.addGestureRecognizer(tapRecognizer)
            
            // MARK: Open information about post with comments
            let imageTapRecognizer = TapGestureRecognizer(block: { [self] in
                let postVC = PostViewController(userImage: avatarImage , nickName: nickName, job: job, image: post.image ?? UIImage(named: "")!, text: post.description, likesCount: post.likes, date: post.date, comments: comments)
                self.navigationController?.pushViewController(postVC, animated: true)
            })
            imageTapRecognizer.numberOfTapsRequired = 1
            cell.postImageVIew.isUserInteractionEnabled = true
            cell.postImageVIew.addGestureRecognizer(imageTapRecognizer)
            
            // MARK: BookMark Action
            let bookMarkTapRecognizer = TapGestureRecognizer(block: {
                cell.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .highlighted)
                cell.bookMarkButton.tintColor = .red
            })
            bookMarkTapRecognizer.numberOfTapsRequired = 1
            cell.bookMarkButton.isUserInteractionEnabled = true
            cell.bookMarkButton.addGestureRecognizer(bookMarkTapRecognizer)
            return cell
        }
    }
    
    @objc func openPhotosAction() {
        let photosVC = FriendPhotosViewController(photos: photos, albums: albums)
        navigationController?.pushViewController(photosVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            
            // MARK: Data in FriendHeaderView
            let view = FriendHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            view.nickNameLabel.text = nickName
            view.nameLabel.text = name
            view.surnameLabel.text = surname
            view.avatarImageView.image = avatarImage
            view.jobLabel.text = job
            view.genderLabel.text = gender
            let publicationLocalized = "publications".localized
            view.publicationResultLabel.text = "\(publicationResult) \(publicationLocalized)"
            let subscriptionLocalized = "subscriptions".localized
            view.subscriptionResultLabel.text = "\(subscriptionResult) \(subscriptionLocalized)"
            let subscribersLocalized = "subscribers".localized
            view.subscriberResultLabel.text = "\(subscriberResult) \(subscribersLocalized)"
            view.infoLabel.isUserInteractionEnabled = true
            let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openInfoPageAction))
            view.infoLabel.addGestureRecognizer(guestureRecognizer)
            view.messageButton.addTarget(self, action: #selector(openChatAction), for: .touchUpInside)
            return view
        } else {
            return UIView()
        }
    }
    

    @objc func openInfoPageAction() {
        let infoPageVC = InformationViewController(nickName: nickName, name: name, surname: surname, job: job, gender: gender, birth: "17.12.95", city: "Астана")
        navigationController?.pushViewController(infoPageVC, animated: true)
    }
    
    @objc func openChatAction() {
        let chatVC = ChatViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 580
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return 0
        }
    }
}
