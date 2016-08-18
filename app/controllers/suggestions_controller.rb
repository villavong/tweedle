class SuggestionsController < ApplicationController
  autocomplete :user, :country
  autocomplete :user, :city

  autocomplete :user, :company_name

  autocomplete :user, :school

  autocomplete :user, :major
  autocomplete :user, :institute



end
