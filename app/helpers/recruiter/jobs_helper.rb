module Recruiter::JobsHelper
  def btn_name
    if params[:arr] == "evaluate"
      t("job.btn_arrange")
    else
      t("job.btn_evaluate")
    end
  end

  def params_req
    if params[:arr] == "evaluate"
      :submission_time
    else
      :evaluate
    end
  end
end
