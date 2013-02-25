class AdminController < ApplicationController

  def view
    @json = Admin.get_result_json()
  end



end
