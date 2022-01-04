//
//  BaseProtocol.swift
//  Pokedex
//
//  Created by 이준성 on 2022/01/04.
//

import RxSwift
import RxCocoa

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
}

protocol BaseViewControllerProtocol: AnyObject {
    associatedtype ViewModel: BaseViewModel
    var disposeBag: DisposeBag { get set }
    
    init(viewModel: ViewModel)
}

class BaseViewController<ViewModel: BaseViewModel, View: UIView>: UIViewController, BaseViewControllerProtocol {
    var contentView = View()
    var viewModel: ViewModel
    var disposeBag: DisposeBag = DisposeBag()

    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = contentView
    }

    convenience init() {
        fatalError("init() has not been implemented")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
