NotableWeb::Engine.routes.draw do
  get "users", to: "home#users"
  get "slow_actions", to: "home#slow_actions"
  get "slow_action", to: "home#slow_action"
  root to: "home#index"
end
