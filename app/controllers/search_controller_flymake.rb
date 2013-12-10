class SearchController < ApplicationController
  def index
    type = params[:type]

    if type == "name"
      @examination = Examination.select(type).uniq
    elsif type == "series"
      type = "series_description"
      @examination = Examination.select(type).uniq
    else
      @examination = Examination.all
    end

    respond_to do |format|
      format.json { render :json => @examination, callback: params[:callback] }
    end
  end

  def getZip
    series = params[:series]

    examination = Examination.where("series_description = ?", series).select("file_path")

    #logger.debug (examination.inspect)

    files = ""
    examination.each do |obj|
      files += " " + obj.file_path
    end

    zip_folder = Rails.root.join("dicomdir").join("zip").to_s + "/"

    create_zip_path = zip_folder + series + ".zip"

    command = "zip "+ create_zip_path +files

    `#{command}`

    #stat = File::stat(create_zip_path)
    # response.headers['Content-type'] = 'application/zip'
    response.headers['Access-Control-Allow-Origin'] = '*'

    #logger.debug File.read(create_zip_path
    logger.debug create_zip_path
    logger.debug File.read(create_zip_path)

    # send_file(File.read(create_zip_path), :filename => series+'.zip')

    #logger.debug files

    # respond_to do |format|
    #   format.json { render :json => "hello", callback: params[:callback] }
    # end

    render :nothing => true
  end
end
