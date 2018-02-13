require 'dotenv/load'
require 'csv'
require 'json'
require 'thor'
require 'rest-client'

def id_emp_code(response)
  result = []
  response.each do |val|
    hash = {
      id: val['id'],
      emp_code: val['emp_code'],
    }
    result << hash
  end
  result
end

class CrewCli < Thor
  desc 'dump to csv', 'dump'
  def dump
    results = []

    per_page = 100
    url = "https://#{ENV['SMARTHR_SUBDOMAIN']}.smarthr.jp/api/v1/crews?per_page=#{per_page}"
    headers = {
      Authorization: "Bearer #{ENV['SMARTHR_API_TOKEN']}"
    }

    client = RestClient.get(url, headers)
    results.concat(id_emp_code(JSON.parse(client.body)))

    x_total_count = client.headers[:x_total_count]
    max_page = (x_total_count.to_f / per_page).ceil

    if max_page > 1
      for page in 2..max_page do
        url = "https://#{ENV['SMARTHR_SUBDOMAIN']}.smarthr.jp/api/v1/crews?per_page=#{per_page}&page=#{page}"
        client = RestClient.get(url, headers)
        results.concat(id_emp_code(JSON.parse(client.body)))
      end
    end

    # write csv
    CSV.open('dump.csv', 'w') do |csv|
      csv << %w(id old_emp_code new_emp_code)
      results.each do |val|
        csv << [val[:id], val[:emp_code], '']
      end
    end
  end

  desc 'bulk update crew.emp_code from csv', 'bulk_update_emp_code CSV_PATH'
  def bulk_update_emp_code(csv_path)
    url = "https://#{ENV['SMARTHR_SUBDOMAIN']}.smarthr.jp/api/v1/crews"
    headers = {
      Authorization: "Bearer #{ENV['SMARTHR_API_TOKEN']}",
    }

    CSV.foreach(csv_path, headers: true) do |csv|
      id = csv[0]
      old_emp_code = csv[1]
      new_emp_code = csv[2]
      endpoint = "#{url}/#{id}"
      payload = {
        emp_code: new_emp_code
      }
      begin
        RestClient.patch(endpoint, payload, headers)
      rescue => e
        puts e.message
      end
    end
  end
end

CrewCli.start(ARGV)
