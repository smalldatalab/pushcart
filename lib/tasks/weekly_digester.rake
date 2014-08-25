namespace :weekly_digester do

  desc "Sends out all weekly digests"
  task :mail_all_users => :environment do
    initialize_performance_assessments("Processing weekly digests for all users.")

    User.all.each do |u|
      digest = WeeklyEmailDigester.new(u, 1.day.ago)

      if digest.purchases.blank?
        puts "No weekly digest send for User ##{u.id} (No purchases found for previous week)."
      else
        UserMailer.weekly_digest(u, digest).deliver
        @counter += 1
      end
    end

    output_performance_report
  end

private 

  def initialize_performance_assessments(message)
    @counter = 0
    @start_time = Time.now
    puts "#{message} (#{@start_time})"
  end

  def output_performance_report
    puts "Task complete. #{@counter} mailer jobs sent in #{Time.now - @start_time} seconds."
  end

end