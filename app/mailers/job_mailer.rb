class JobMailer < ApplicationMailer
  helper :application
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.job_mailer.interview.subject
  #
  def interview candidate, recruiter, recruitment
    @candidate = candidate
    @recruiter = recruiter
    @recruitment = recruitment

    mail to: candidate.email, subject: t("email.subject.interview")
  end

  def intro_job candidate, jobs
    @candidate = candidate
    @jobs = jobs

    mail to: candidate.email, subject: t("email.subject.intro_jobs")
  end
end
