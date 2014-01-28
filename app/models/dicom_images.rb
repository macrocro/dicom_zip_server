class DicomImages < ActiveRecord::Base
  self.table_name = 'DICOMImages'
  belongs_to :dicom_series
end
