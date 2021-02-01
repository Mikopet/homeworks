Rails.application.routes.draw do
  root 'chart#index'

  get 'event_counts', to: 'chart#event_counts'
  get 'event_counts_by_month', to: 'chart#event_counts_by_month'

  get 'setup_start_counts_by_month', to: 'chart#setup_start_counts_by_month'
  get 'setup_counts_cumulated_by_month', to: 'chart#setup_counts_cumulated_by_month'

  get '/task', to: 'chart#task'

  get 'completed_setup_by_month', to: 'chart#completed_setup_by_month'
  get 'average_setup_duration_by_month', to: 'chart#average_setup_duration_by_month'
end
