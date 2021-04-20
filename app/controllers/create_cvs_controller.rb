class CreateCvsController < ApplicationController
  def show
    @cv = CurriculumVitae.find_by id: params[:id]
  end

  def new
    @cv = CurriculumVitae.new
    @cv.skills.build
    @cv.languages.build
    @cv.hobbies.build
    @cv.educations.build
    @cv.experiences.build
    @cv.references.build
    return if logged_in?

    flash[:warning] = t "account.pls_login"
    redirect_to login_path
  end

  def create
    @cv = current_user.curriculum_vitaes.build(cv_params)
    if logged_in? && @cv.save
      flash[:success] = t "create_cv.created.success"
      redirect_to create_cv_path(id: current_user.curriculum_vitaes.last.id)
    else
      flash.now[:danger] = t "create_cv.created.failed"
      render :new
    end
  end

  private

  def cv_params
    params.require(:curriculum_vitae)
          .permit :field_id, :about_me,
                  skills_attributes: [:skill_name],
                  languages_attributes: [:language_name, :level],
                  hobbies_attributes: [:hobby_name],
                  educations_attributes: [:start_date, :end_date,
                                          :university_name, :major, :gpa],
                  experiences_attributes: [:start_date, :end_date,
                                           :position, :company_name,
                                           :description],
                  references_attributes: [:name, :position, :email,
                                          :phone_number]
  end
end
