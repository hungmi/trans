Rails.application.routes.draw do
	root "pages#home"
	scope "(:locale)", locale: /en|zh-TW/ do
		root "pages#home"
		controller :pages do
			get 'home', to: "pages#home"
			get 'aboutTRANS', to: "pages#about"
			get 'agenda', to: "pages#agenda"
		  get 'speaker', to: "pages#speaker"
		  get 'communityPartner', to: "pages#partner"
		  get 'faq', to: "pages#faq"
		  get 'review', to: "pages#review"
		  get 'register', to: "pages#register"
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'admin', to: redirect('/admin/people')
  namespace :admin do
		resources :partners
		resources :people
		resources :partners, controller: :people
		resources :users
	  get 'signin', to: 'sessions#new'
	  post 'signin', to: 'sessions#create'
	  delete 'logout', to: 'sessions#destroy'
	end
end
