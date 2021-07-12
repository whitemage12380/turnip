class SettlementsController < ApplicationController

  # GET /settlements
  # GET /settlements.json
  def index
    @settlements = Settlement.all_for_user(current_user)
    respond_to do |format|
      format.html
      format.json { render :json => @settlements}
    end
  end
end
