class Notification < ActionMailer::Base
  default :from => "buildingprotectors@gmail.com"

  def new_complaint(complaint, bin)
  	@bin = bin
  	@url = "http://a810-bisweb.nyc.gov/bisweb/" << complaint.values[0]
  	mail(
  		:to => "jollyburnz@gmail.com",
  		:subject => "[Building Protectors] New Complaint for BIN##{@bin}",
  		)
  end

  def monthly_update()

	end
end
