class SuggestionsController < ApplicationController
  autocomplete :user, :country
  autocomplete :user, :city

  autocomplete :user, :school

  autocomplete :user, :major


end
