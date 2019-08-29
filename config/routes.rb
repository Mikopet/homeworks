Rails.application.routes.draw do
  root 'chart#index'

  get 'event_counts', to: 'chart#event_counts'
  get 'event_counts_by_month', to: 'chart#event_counts_by_month'

  get 'setup_start_counts_by_month', to: 'chart#setup_start_counts_by_month'
  get 'setup_counts_cumulated_by_month', to: 'chart#setup_counts_cumulated_by_month'
end
