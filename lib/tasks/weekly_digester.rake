namespace :weekly_digester do

  desc "Sends out all weekly digests"
  task :mail_all_users, [:end_date_days_ago] => :environment do |t, args|
    unless args[:end_date_days_ago].blank? || !!(args[:end_date_days_ago] =~ /\A[-+]?[0-9]+\z/)
      raise ">>> End date must be an integer! (# of days since end of period)"
    end

    end_date_of_period = args[:end_date_days_ago].blank? ? 1 : args[:end_date_days_ago].to_i

    initialize_performance_assessments("Processing weekly digests for all users.")

    User.all.each do |u|
      comparison_digest = WeeklyEmailDigester.new(u, (end_date_of_period + 7).days.ago).categories_breakdown

      if comparison_digest
        digest = WeeklyEmailDigester.new(u, end_date_of_period.day.ago, comparison_digest)
      else
        digest = WeeklyEmailDigester.new(u, end_date_of_period.day.ago)
      end

      if digest.purchases.blank?
        puts "No weekly digest send for User ##{u.id}. (No purchases found for time period.)"
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