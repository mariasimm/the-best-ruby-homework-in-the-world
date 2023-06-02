require 'prawn'
require 'prawn/table'

class DataExportController < ApplicationController
  def export
    respond_to do |format|
      format.pdf do
        data = Hospital.joins(card: :patient).select('hospitals.name as hospital_name, hospitals.phone as hospital_phone, hospitals.street as hospital_street, patients.name as patient_name')
        send_data generate_pdf(data), filename: 'data_hospital_patient.pdf', type: 'application/pdf'
      end

      format.csv do
        data = Hospital.joins(card: :patient).select('hospitals.name as hospital_name, hospitals.phone as hospital_phone, hospitals.street as hospital_street, patients.name as patient_name')
        send_data generate_csv(data), filename: 'data_hospital_patient.csv', type: 'text/csv'
      end
    end
  end

  def download_hospital_info_pdf
    @hospital = Hospital.all
    send_data generate_hospital_info_pdf(@hospital), filename: 'Hospital_info.pdf', type: 'application/pdf'
  end

  def download_patient_info_pdf
    @patient = Patient.all
    send_data generate_patient_info_pdf(@patient), filename: 'Patient_info.pdf', type: 'application/pdf'
  end

  private

  def generate_pdf(data)
    pdf = Prawn::Document.new

    pdf.font_families.update( "Arial" => {
      :normal => "arial.ttf",
      :bold => "arialbd.ttf"
    }
    )
    pdf.font("Arial", :style => :normal)

    table_header = ["Name", "Zip Code", "Phone", "Address"]
    table_data = [table_header]

    data.each do |data|
      hospital_data = []
      hospital_data << data.hospital_name
      hospital_data << data.hospital_phone
      hospital_data << data.hospital_street
      hospital_data << data.patient_name
      table_data << hospital_data
    end

    pdf.text "Patients of hospitals", align: :center
    pdf.move_down 10

    pdf.image URI.open("https://static.vecteezy.com/system/resources/previews/004/493/181/original/hospital-building-for-healthcare-background-illustration-with-ambulance-car-doctor-patient-nurses-and-medical-clinic-exterior-free-vector.jpg"), width: 280, height: 200
    pdf.move_down 10

    pdf.table(table_data, :header => true) do |table|
      table.row_colors = ["a2a3eb"]
      table.column_widths = { 0 => 150, 1 => 100, 2 => 100, 3 => 100 }
      table.header = true
      table.row(0).font_style = :bold
    end
    pdf.render
  end

  def generate_csv(data)
    CSV.generate do |csv|
      csv << ['Hospital Name', 'Hospital Phone', 'Hospital Address', 'Patient Name']

      data.each do |datum|
        csv << [datum.hospital_name, datum.hospital_phone, datum.hospital_street, datum.patient_name]
      end
    end
  end

  def generate_hospital_info_pdf(hospital)
    pdf = Prawn::Document.new

    pdf.font_families.update( "Arial" => {
      :normal => "arial.ttf",
      :bold => "arialbd.ttf"
    }
    )
    pdf.font("Arial", :style => :normal)

    table_header = ["Name", "Zip Code", "Phone", "Address"]
    table_data = [table_header]

    hospital.each do |hospital|
      hospital_data = []
      hospital_data << hospital.name
      hospital_data << hospital.address
      hospital_data << hospital.phone
      hospital_data << hospital.street
      table_data << hospital_data
    end

    pdf.text "Hospitals", align: :center
    pdf.move_down 10

    pdf.table(table_data, :header => true) do |table|
      table.row_colors = ["FFFFFF"]
      table.column_widths = { 0 => 150, 1 => 100, 2 => 100, 3 => 100 }
      table.header = true
      table.row(0).font_style = :bold
    end
    pdf.render
  end

  def generate_patient_info_pdf(patient)
    pdf = Prawn::Document.new

    pdf.font_families.update( "Arial" => {
      :normal => "arial.ttf",
      :bold => "arialbd.ttf"
    }
    )
    pdf.font("Arial", :style => :normal)

    table_header = ["Name"]
    table_data = [table_header]

    # Populate table data
    patient.each do |patient|
      patient_data = []
      patient_data << patient.name
      table_data << patient_data
    end

    pdf.text "Patients", align: :center

    pdf.move_down 10
    pdf.table(table_data, :header => true) do |table|
      table.row_colors = ["a1ffbb"]
      table.column_widths = { 0 => 150}
      table.header = true
      table.row(0).font_style = :bold
    end

    pdf.render
  end
end
