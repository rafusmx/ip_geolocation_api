Rails.application.routes.draw do
  resource :location_data, only: %i[create destroy show]
end
