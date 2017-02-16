# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :projects do
  get 'subscriptions/:id/time_entries', to: 'subscriptions#time_entries'
  resources :subscriptions do
    resources :extra_times
  end
end
