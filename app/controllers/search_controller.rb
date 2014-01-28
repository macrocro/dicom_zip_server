class SearchController < ApplicationController
  def index
    type = params[:type]

    if type == "name"
      # @examination = Dicom.select(type).uniq
    elsif type == "series"
      type = "SeriesDesc"
      @dicom_series = DicomSeries.select(type).uniq
    else
      @dicom_series = DicomSeries.all
    end

    respond_to do |format|
      format.json { render :json => @dicom_series, callback: params[:callback] }
    end
  end

  def getZip
    series = params[:series]

    # dicom_series = DicomSeries.where("SeriesDesc = ?",series).select("SeriesInst")

    dicom_series = DicomImages.joins("LEFT OUTER JOIN `DICOMSeries` ON `DICOMSeries`.`SeriesInst` = `DICOMImages`.`SeriesInst`").where("`DICOMSeries`.`SeriesDesc` = ?", series).select("`DICOMImages`.`ObjectFile`")

    #logger.debug (examination.inspect)

    files = ""
    dicom_series.each do |obj|
      files += " " + "/usr/lib/cgi-bin/data/" + obj.ObjectFile
    end

    #logger.debug files.inspect

    zip_folder = Rails.root.join("dicomdir").to_s + "/"

    create_zip_path = zip_folder + series + ".zip"

    command = "zip -j "+ create_zip_path +files

    # logger.debug create_zip_path
    # logger.debug command

    `#{command}`

    stat = File::stat(create_zip_path)

    response.headers['Access-Control-Allow-Origin'] = '*'

    send_file(create_zip_path, :filename => series+'.zip', :length => stat.size)

  end
end
