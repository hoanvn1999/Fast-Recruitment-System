require 'rake'
namespace :send_mail do
  desc 'Intro jobs'
  task :intro_jobs => :environment do
    JobMailer.intro_job(User.third, Job.limit(3)).deliver_later
  end
end