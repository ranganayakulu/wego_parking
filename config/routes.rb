Rails.application.routes.draw do
  resources :parking_lots, path: 'carparks' do
    collection do
      get :nearest
    end
  end
end
