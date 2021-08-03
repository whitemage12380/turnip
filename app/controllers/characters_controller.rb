class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all
    respond_to do |format|
      format.html
      format.json { render :json => @characters }
    end
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created }
      else1
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end
end