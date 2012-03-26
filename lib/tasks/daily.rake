desc "Daily Check for Complaints"
task :daily_task => :environment do
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	test = Complaint.all

	test.each do |t|
		puts t.bin
		url = "http://a810-bisweb.nyc.gov/bisweb/ComplaintsByAddressServlet?allbin=#{t.bin}"
		doc = Nokogiri::HTML(open(url))
		latest_complaint_raw = doc.at_css("tr:nth-child(3) .content:nth-child(1) a")
		latest_complaint = latest_complaint_raw.text
			
		if latest_complaint.to_i > t.latest.to_i
			latest_date = doc.at_css("tr:nth-child(3) :nth-child(3)").text
			t.update_attributes(:latest => latest_complaint)
			t.update_attributes(:date => latest_date)
			Notification.new_complaint(latest_complaint_raw, t.bin).deliver
		    Rails.logger.debug "#{t.bin} has been updated and an notification email has been sent."
			puts "#{t.bin} has been updated and an notification email has been sent."
		else
			Rails.logger.debug "#{t.bin} has no new complaints."
			puts "#{t.bin} has no new complaints."
		end

		#puts latest_complaint
		#puts latest_date
		Rails.logger.debug "#######################################################################"
		puts "...."
	end

	# url = "http://a810-bisweb.nyc.gov/bisweb/ComplaintsByAddressServlet?allbin=4056431"
	# doc = Nokogiri::HTML(open(url))
	# latest_complaint = doc.at_css("tr:nth-child(3) .content:nth-child(1)").text 
	# latest_date = doc.at_css("tr:nth-child(3) :nth-child(3)").text
	# puts latest_date
end
