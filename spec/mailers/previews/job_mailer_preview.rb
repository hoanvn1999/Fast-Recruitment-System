# Preview all emails at http://localhost:3000/rails/mailers/job_mailer
class JobMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/job_mailer/interview
  def interview
    JobMailer.interview
  end

end
