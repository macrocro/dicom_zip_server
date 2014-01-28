class DicomSeries < ActiveRecord::Base
  self.table_name = 'DICOMSeries'
  has_many :dicom_images
end
