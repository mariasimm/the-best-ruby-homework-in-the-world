Rails.application.routes.draw do
  devise_for :users

  get 'pages/home'
  root 'pages#home'

  resources :patients
  resources :cards
  resources :doctors
  resources :specialities
  resources :departments
  resources :hospitals

  get 'export_data', to: 'data_export#export', format: 'pdf'
  get 'download_hospital_info_pdf', to: 'data_export#download_hospital_info_pdf', format: 'pdf'
  get 'download_patient_info_pdf', to: 'data_export#download_patient_info_pdf', format: 'pdf'
  get 'export_data', to: 'data_export#export', format: 'csv'

end
