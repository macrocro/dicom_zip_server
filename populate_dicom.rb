# Libraries required:
require 'find'
require 'active_record'
require 'dicom'
require 'pp'

# Load your yml config from rails:
db_config = YAML::load(File.open("./config/database.yml"))
# Connect to the proper database:
ActiveRecord::Base.establish_connection(db_config['development'])
# Load the custom model we created earlier:
require './app/models/examination'

# Discover all the files contained in the specified directory and all its sub-directories:
dirs = ["/var/www/rails/dicom/dicomdir"]
files = Array.new
for dir in dirs
  Find.find(dir) do |path|
    if FileTest.directory?(path)
      next
    else
      files << path  # Store the file in our array
    end
  end
end

# Use a loop to run through all the files, reading its data and transferring it to the database.

files.each do |file|
  # Read the file:
  dcm = DICOM::DObject.read(file)
  # If the file was read successfully as a DICOM file, go ahead and extract content:
  if dcm.read?
    sop_instance_uid = dcm.sop_instance_uid.value
    examination = Examination.where('sop_instance_uid = ?', sop_instance_uid)

    if examination.blank?
      study = dcm.value("0008,1030")
      name = dcm.value("0010,0010")
      voltage = dcm.value("0018,0060")
      current = dcm.value("0018,1151")
      exposure = dcm.value("0018,1152")
      study_instance_uid = dcm.study_instance_uid.value
      series_instance_uid = dcm.series_instance_uid.value
      series_description = dcm.series_description.value

      # Store the data in the database:
      e = Examination.new
      e.study = study
      e.study_instance_uid = study_instance_uid
      e.series_instance_uid = series_instance_uid
      e.series_description = series_description
      e.sop_instance_uid = sop_instance_uid
      e.name = name
      e.voltage = voltage
      e.current = current
      e.exposure = exposure
      e.file_path = file
      e.save
    end
  end
end

# {"File Meta Information Group Length"=>188
#  "File Meta Information Version"=>nil
#  "Media Storage SOP Class UID"=>"1.2.840.10008.5.1.4.1.1.4"
#  "Media Storage SOP Instance UID"=>"1.3.12.2.1107.5.2.6.22500.5.0.3251589727342981"
#  "Transfer Syntax UID"=>"1.2.840.10008.1.2.1"
#  "Implementation Class UID"=>"1.2.826.0.1.3680043.2.360.0.3.5.4"
#  "Implementation Version Name"=>"IIS_354"
#  "Specific Character Set"=>"ISO_IR 100"
#  "Image Type"=>"ORIGINAL\\SECONDARY\\POSDISP\\M\\ND"
#  "SOP Class UID"=>"1.2.840.10008.5.1.4.1.1.4"
#  "SOP Instance UID"=>"1.3.12.2.1107.5.2.6.22500.5.0.3251589727342981"
#  "Study Date"=>"20030725"
#  "Series Date"=>"20030725"
#  "Acquisition Date"=>"20030725"
#  "Content Date"=>"20030725"
#  "Study Time"=>"155651"
#  "Series Time"=>"163107.125000"
#  "Acquisition Time"=>"155442.067493"
#  "Content Time"=>"163107.250000"
#  "Accession Number"=>"3000002371207001"
#  "Modality"=>"MR"
#  "Manufacturer"=>"SIEMENS"
#  "Institution Name"=>"Yokohama City Univ Hospital"
#  "Referring Physician's Name"=>nil
#  "Station Name"=>"MRC22500"
#  "Study Description"=>"Head^orbit"
#  "Procedure Code Sequence"=>{"Item 0"=>{"Code Value"=>"00H130"
#  "Coding Scheme Designator"=>"PL/COMASSISTANT"
#  "Coding Scheme Version"=>"1.0"
#  "Code Meaning"=>"GE"}}
#  "Series Description"=>"PosDisp: t1_se_cor 4"
#  "Manufacturer's Model Name"=>"Symphony"
#  "Referenced Study Sequence"=>{"Item 0"=>{"Referenced SOP Class UID"=>"1.2.840.10008.5.1.4.1.1.4"
#  "Referenced SOP Instance UID"=>"1.2.392.200036.9121.7.1.1.0.20030725155357.3000002371207001.13"}}
#  "Referenced Performed Procedure Step Sequence"=>{"Item 0"=>{"Referenced SOP Class UID"=>"1.2.840.10008.3.1.2.3.3"
#  "Referenced SOP Instance UID"=>"1.3.12.2.1107.5.2.6.22500.2.0.274271614683022"}}
#  "Referenced Patient Sequence"=>{"Item 0"=>{"Referenced SOP Class UID"=>"1.2.840.10008.5.1.4.1.1.4"
#  "Referenced SOP Instance UID"=>"1.2.392.200036.9121.7.1.1.0.20030725155357.3000002371207001.13"}}
#  "Lossy Image Compression (Retired)"=>"01"
#  "Source Image Sequence"=>{"Item 0"=>{"Referenced SOP Class UID"=>"1.2.840.10008.5.1.4.1.1.4"
#  "Referenced SOP Instance UID"=>"1.3.12.2.1107.5.2.6.22500.5.0.3252635111071984"}}
#  "Patient's Name"=>"HAGIWARA^HIROAKI"
#  "Patient ID"=>"01027739"
#  "Patient's Birth Date"=>"19661030"
#  "Patient's Sex"=>"M"
#  "Patient's Weight"=>"75"
#  "Pregnancy Status"=>0
#  "Scanning Sequence"=>"GR"
#  "Sequence Variant"=>"SP"
#  "Scan Options"=>nil
#  "MR Acquisition Type"=>"2D"
#  "Sequence Name"=>"*fl2d1"
#  "Angio Flag"=>"N"
#  "Slice Thickness"=>"10"
#  "Repetition Time"=>"20"
#  "Echo Time"=>"5"
#  "Number of Averages"=>"1"
#  "Imaging Frequency"=>"63.695871"
#  "Imaged Nucleus"=>"1H"
#  "Echo Number(s)"=>"0"
#  "Magnetic Field Strength"=>"1.494"
#  "Spacing Between Slices"=>"12"
#  "Number of Phase Encoding Steps"=>"128"
#  "Echo Train Length"=>"1"
#  "Percent Sampling"=>"50"
#  "Percent Phase Field of View"=>"100"
#  "Pixel Bandwidth"=>"180"
#  "Device Serial Number"=>"22500"
#  "Software Version(s)"=>"syngo MR 2002B 4VA21A"
#  "Date of Last Calibration"=>"20021122"
#  "Time of Last Calibration"=>"112103.000000"
#  "Transmit Coil Name"=>"Body"
#  "Acquisition Matrix"=>"0\\256\\128\\0"
#  "In-plane Phase Encoding Direction"=>"ROW"
#  "Flip Angle"=>"40"
#  "Variable Flip Angle Flag"=>"N"
#  "SAR"=>"0.24137302"
#  "dB/dt"=>"0"
#  "Patient Position"=>"HFS"
#  "Study Instance UID"=>"1.2.392.200036.9121.7.1.1.0.20030725155357.3000002371207001.13"
#  "Series Instance UID"=>"1.3.12.2.1107.5.2.6.22500.5.0.3251588425573132"
#  "Study ID"=>"000015535700H130"
#  "Series Number"=>"5002"
#  "Acquisition Number"=>"1"
#  "Instance Number"=>"2"
#  "Image Position (Patient)"=>"0\\-140\\140"
#  "Image Orientation (Patient)"=>"0\\1\\0\\0\\0\\-1"
#  "Frame of Reference UID"=>"1.3.12.2.1107.5.2.6.22500.20030725155653906.0.0.0"
#  "Position Reference Indicator"=>nil
#  "Slice Location"=>"0"
#  "Image Comments"=>"16 of 16"
#  "Samples per Pixel"=>1
#  "Photometric Interpretation"=>"MONOCHROME2"
#  "Rows"=>256
#  "Columns"=>256
#  "Pixel Spacing"=>"1.09375\\1.09375"
#  "Bits Allocated"=>16
#  "Bits Stored"=>12
#  "High Bit"=>11
#  "Pixel Representation"=>0
#  "Smallest Image Pixel Value"=>0
#  "Largest Image Pixel Value"=>365
#  "Window Center"=>"222"
#  "Window Width"=>"491"
#  "Window Center & Width Explanation"=>"Algo1"
#  "Lossy Image Compression"=>"01"
#  "Lossy Image Compression Ratio"=>"9"
#  "0029
# 0010"=>nil
#  "0029
# 0011"=>nil
#  "0029
# 0012"=>nil
#  "0029
# 1008"=>nil
#  "0029
# 1009"=>nil
#  "0029
# 1010"=>nil
#  "0029
# 1018"=>nil
#  "0029
# 1019"=>nil
#  "0029
# 1020"=>nil
#  "0029
# 1131"=>nil
#  "0029
# 1134"=>nil
#  "0029
# 1208"=>nil
#  "0029
# 1209"=>nil
#  "0029
# 1210"=>nil
#  "Requested Procedure Description"=>"RequestDescription"
#  "Requested Procedure Code Sequence"=>{"Item 0"=>{"Code Value"=>"00H130"
#  "Coding Scheme Designator"=>"PL/COMASSISTANT"
#  "Coding Scheme Version"=>"1.0"
#  "Code Meaning"=>"GE"}}
#  "Performed Procedure Step Start Date"=>"20030725"
#  "Performed Procedure Step Start Time"=>"155651.234000"
#  "Performed Procedure Step ID"=>"000015535700H130"
#  "Performed Procedure Step Description"=>"Description"
#  "Request Attributes Sequence"=>{"Item 0"=>{"Scheduled Procedure Step Description"=>"Description"
#  "Scheduled Protocol Code Sequence"=>{"Item 0"=>{"Code Value"=>"00H130"
#  "Coding Scheme Designator"=>"PL/COMASSISTANT"
#  "Coding Scheme Version"=>"1.0"
#  "Code Meaning"=>"GE"}}
#  "Scheduled Procedure Step ID"=>"000015535700H130"
#  "Requested Procedure ID"=>"000015535700H130"}}
#  "Overlay Rows"=>256
#  "Overlay Columns"=>256
#  "Number of Frames in Overlay"=>"1"
#  "Overlay Description"=>"Siemens MedCom Object Graphics"
#  "Overlay Type"=>"G"
#  "Overlay Origin"=>"1\\1"
#  "Image Frame Origin"=>1
#  "Overlay Bits Allocated"=>1
#  "Overlay Bit Position"=>0
#  "Overlay Data"=>nil
#  "Pixel Data"=>nil}
