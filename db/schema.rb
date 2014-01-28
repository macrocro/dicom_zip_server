# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131225014654) do

  create_table "DICOMImages", primary_key: "SOPInstanc", force: true do |t|
    t.string  "SOPClassUI", limit: 64
    t.string  "ImageNumbe", limit: 12
    t.string  "ImageDate",  limit: 8
    t.string  "ImageTime",  limit: 16
    t.string  "EchoNumber", limit: 64
    t.string  "NumberOfFr", limit: 12
    t.string  "AcqDate",    limit: 8
    t.string  "AcqTime",    limit: 16
    t.string  "ReceivingC", limit: 16
    t.string  "AcqNumber",  limit: 12
    t.string  "SliceLocat", limit: 16
    t.string  "SamplesPer", limit: 5
    t.string  "PhotoMetri", limit: 16
    t.string  "Rows",       limit: 5
    t.string  "Colums",     limit: 5
    t.string  "BitsStored", limit: 5
    t.string  "ImageType",  limit: 128
    t.string  "ImageID",    limit: 16
    t.string  "ImagePat",   limit: 64
    t.string  "SeriesInst", limit: 64
    t.integer "AccessTime"
    t.integer "qTimeStamp"
    t.integer "qFlags"
    t.string  "qSpare",     limit: 64
    t.string  "ObjectFile", limit: 254
    t.string  "DeviceName", limit: 32
  end

  add_index "DICOMImages", ["ImagePat"], name: "images_pat", using: :btree
  add_index "DICOMImages", ["SeriesInst"], name: "images_lnk", using: :btree

  create_table "DICOMPatients", primary_key: "PatientID", force: true do |t|
    t.string  "PatientNam", limit: 64
    t.string  "PatientBir", limit: 8
    t.string  "PatientSex", limit: 16
    t.integer "AccessTime"
    t.integer "qTimeStamp"
    t.integer "qFlags"
    t.string  "qSpare",     limit: 64
  end

  create_table "DICOMSeries", primary_key: "SeriesInst", force: true do |t|
    t.string  "SeriesNumb", limit: 12
    t.string  "SeriesDate", limit: 8
    t.string  "SeriesTime", limit: 16
    t.string  "SeriesDesc", limit: 64
    t.string  "Modality",   limit: 16
    t.string  "PatientPos", limit: 16
    t.string  "ContrastBo", limit: 64
    t.string  "Manufactur", limit: 64
    t.string  "ModelName",  limit: 64
    t.string  "BodyPartEx", limit: 64
    t.string  "ProtocolNa", limit: 64
    t.string  "StationNam", limit: 16
    t.string  "Institutio", limit: 64
    t.string  "FrameOfRef", limit: 64
    t.string  "SeriesPat",  limit: 64
    t.string  "StudyInsta", limit: 64
    t.integer "AccessTime"
    t.integer "qTimeStamp"
    t.integer "qFlags"
    t.string  "qSpare",     limit: 64
  end

  add_index "DICOMSeries", ["SeriesPat"], name: "series_pat", using: :btree
  add_index "DICOMSeries", ["StudyInsta"], name: "series_lnk", using: :btree

  create_table "DICOMStudies", primary_key: "StudyInsta", force: true do |t|
    t.string  "StudyDate",  limit: 8
    t.string  "StudyTime",  limit: 16
    t.string  "StudyID",    limit: 16
    t.string  "StudyDescr", limit: 64
    t.string  "AccessionN", limit: 16
    t.string  "ReferPhysi", limit: 64
    t.string  "PatientsAg", limit: 16
    t.string  "PatientsWe", limit: 16
    t.string  "StudyModal", limit: 64
    t.string  "PatientNam", limit: 64
    t.string  "PatientBir", limit: 8
    t.string  "PatientSex", limit: 16
    t.string  "PatientID",  limit: 64
    t.integer "AccessTime"
    t.integer "qTimeStamp"
    t.integer "qFlags"
    t.string  "qSpare",     limit: 64
  end

  add_index "DICOMStudies", ["PatientID"], name: "study_lnk", using: :btree

  create_table "DICOMWorkList", id: false, force: true do |t|
    t.string  "AccessionN", limit: 16
    t.string  "PatientID",  limit: 64
    t.string  "PatientNam", limit: 64
    t.string  "PatientBir", limit: 8
    t.string  "PatientSex", limit: 16
    t.string  "MedicalAle", limit: 64
    t.string  "ContrastAl", limit: 64
    t.string  "StudyInsta", limit: 64
    t.string  "ReqPhysici", limit: 64
    t.string  "ReqProcDes", limit: 64
    t.string  "Modality",   limit: 16
    t.string  "ReqContras", limit: 64
    t.string  "ScheduledA", limit: 16
    t.string  "StartDate",  limit: 8
    t.string  "StartTime",  limit: 16
    t.string  "PerfPhysic", limit: 64
    t.string  "SchedPSDes", limit: 64
    t.string  "SchedPSID",  limit: 16
    t.string  "SchedStati", limit: 16
    t.string  "SchedPSLoc", limit: 16
    t.string  "PreMedicat", limit: 64
    t.string  "SchedPSCom", limit: 64
    t.string  "ReqProcID",  limit: 16
    t.string  "ReqProcPri", limit: 16
    t.integer "AccessTime"
    t.integer "qTimeStamp"
    t.integer "qFlags"
    t.string  "qSpare",     limit: 64
  end

  create_table "UIDMODS", primary_key: "OldUID", force: true do |t|
    t.integer "MODTime"
    t.string  "MODType", limit: 32
    t.string  "NewUID",  limit: 64
  end

  add_index "UIDMODS", ["OldUID"], name: "mods_old", using: :btree

  create_table "dicom_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dicom_patients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dicom_series", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dicom_studies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dicom_work_lists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examinations", force: true do |t|
    t.string   "study"
    t.string   "name"
    t.string   "voltage"
    t.string   "current"
    t.string   "exposure"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uidmods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
