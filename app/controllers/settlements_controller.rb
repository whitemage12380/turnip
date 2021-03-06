class SettlementsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  # GET /settlements
  # GET /settlements.json
  def index
    @settlements = Settlement.all_for_user(current_user).collect { |s| s.to_h }
    respond_to do |format|
      format.html
      format.json { render :json => @settlements }
    end
  end

  # GET /settlements/markdown/1.json
  def markdown
    @settlement = Settlement.find(current_user, params[:id])
    respond_to do |format|
      format.json { render json: @settlement.to_markdown }
    end
  end

  # POST /settlements.json
  def create
    settlement_type = params.require(:type)
    @new_settlement = Settlement.new(current_user, settlement_type)
    respond_to do |format|
      if @new_settlement.save
        # format.html
        format.json { render json: @new_settlement.to_h, status: :created }
      else
        # format.html
        format.json { render json: {error: true}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settlements/<name>
  # PATCH/PUT /settlements/<name>.json
  # Currently can only rename settlement
  def update
    @settlement = Settlement.find(current_user, params[:id])
    respond_to do |format|
      if @settlement.update(settlement_params)
        format.json { render json: @settlement.to_h, status: :ok }
      else
        format.json { render json: {error: true}, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlements/<name>
  # DELETE /settlements/<name>.json
  def destroy
    @settlement = Settlement.find(current_user, params[:id])
    @settlement.destroy(current_user)
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def settlement_params
      params.require(:settlement).permit(:name)
    end

end
