require 'rubygems'
#require 'rake'
require 'rufus/scheduler'

#load File.join(RAILS_ROOT,'lib','tasks','daily.rake')

scheduler = Rufus::Scheduler.start_new

scheduler.every '1m' do
	#Rake::Task['daily_task'].invoke
	system("rake daily_task")
end