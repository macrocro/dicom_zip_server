class ExaminationsController < ApplicationController
  before_action :set_examination, only: [:show, :edit, :update, :destroy]

  # GET /examinations
  # GET /examinations.json
  # def index
  #   @examinations = Examination.all
  # end

  def index
    @examinations = Examination.find(:all)

    @study = params[:study]
    @mean_exposure = Examination.average(:exposure, :conditions => ['study == ?', @study]) if @study

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examinations }
    end
  end
  # GET /examinations/1
  # GET /examinations/1.json
  def show
  end

  # GET /examinations/new
  def new
    @examination = Examination.new
  end

  # GET /examinations/1/edit
  def edit
  end

  # POST /examinations
  # POST /examinations.json
  def create
    @examination = Examination.new(examination_params)

    respond_to do |format|
      if @examination.save
        format.html { redirect_to @examination, notice: 'Examination was successfully created.' }
        format.json { render action: 'show', status: :created, location: @examination }
      else
        format.html { render action: 'new' }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /examinations/1
  # PATCH/PUT /examinations/1.json
  def update
    respond_to do |format|
      if @examination.update(examination_params)
        format.html { redirect_to @examination, notice: 'Examination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /examinations/1
  # DELETE /examinations/1.json
  def destroy
    @examination.destroy
    respond_to do |format|
      format.html { redirect_to examinations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examination
      @examination = Examination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def examination_params
      params.require(:examination).permit(:study, :name, :voltage, :current, :exposure)
    end
end
