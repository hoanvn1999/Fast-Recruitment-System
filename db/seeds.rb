# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

institution = Institution.new(institution_name: "Freelance",
                              address: "Global",
                              description: Faker::Company.catch_phrase)
institution.logo.attach(io: File.open("app/assets/images/logos/freelance.jpg"),
                        filename: "freelance.jpg", content_type: "image/jpg")
institution.save

institution = Institution.new(institution_name: "Fast Recruitment Joint Stock Company",
                              address: "Da Nang",
                              created_by: 2,
                              description: Faker::Company.catch_phrase)
institution.logo.attach(io: File.open("app/assets/images/logos/freelance.jpg"),
                        filename: "freelance.jpg", content_type: "image/jpg")
institution.save

10.times do |n|
  institution = Institution.new(institution_name: Faker::Company.name,
                                address: ["Da Nang", "Ha Noi", "HCM"].sample,
                                description: Faker::Company.catch_phrase,
                                created_by: rand(1..20))
  institution.logo.attach(io: File.open("app/assets/images/logos/#{n}.jpg"),
                          filename: "logo#{n}.jpg", content_type: "image/jpg")
  institution.save
end

myself = User.new(email: ENV['USER_EMAIL'],
                  phone_number: "+84 77 540 0703",
                  full_name: "FRS Admin",
                  address: "Đà Nẵng",
                  date_of_birth: "01-01-1998",
                  role: 2,
                  activated: true,
                  password: "hoan@123",
                  password_confirmation: "hoan@123")
myself.avatar.attach(io: File.open("app/assets/images/avatars/myself.png"),
                     filename: "myself.jpg", content_type: "image/png")
myself.save

myself = User.new(email: ENV['EMAIL_RECRUITER'],
                  phone_number: "+84 77 540 0703",
                  full_name: "Hoàn (Recruiter)",
                  address: "Đà Nẵng",
                  date_of_birth: "01-01-1998",
                  role: 0,
                  institution_id: 2,
                  activated: true,
                  password: "hoan@123",
                  password_confirmation: "hoan@123")
myself.avatar.attach(io: File.open("app/assets/images/avatars/myself.png"),
                     filename: "myself.jpg", content_type: "image/png")
myself.save

myself = User.new(email: ENV['EMAIL_CANDIDATE'],
                  phone_number: "+84 77 540 0703",
                  full_name: "Hoàn (Candidate)",
                  address: "Đà Nẵng",
                  date_of_birth: "01-01-1998",
                  role: 1,
                  institution_id: 1,
                  activated: true,
                  password: "hoan@123",
                  password_confirmation: "hoan@123")
myself.avatar.attach(io: File.open("app/assets/images/avatars/myself.png"),
                     filename: "myself.jpg", content_type: "image/png")
myself.save

20.times do |n|
  user = User.new(email: "example-#{n + 1}@example.com",
                  phone_number: Faker::Base.numerify('+84 ## ### ####'),
                  full_name: Faker::Name.name,
                  address: ["Đà Nẵng", "Hà Nội", "HCM"].sample,
                  date_of_birth: Faker::Date.between(from: "1980-09-23", to: "2014-09-25"),
                  role: [0, 1, 2].sample,
                  institution_id: rand(1..10),
                  activated: true,
                  password: "hoan@123",
                  password_confirmation: "hoan@123")
  user.avatar.attach(io: File.open("app/assets/images/avatars/#{n}.jpg"),
                     filename: "avatar#{n}.jpg", content_type: "image/jpg")
  user.save!
end

File.open("app/assets/files/field_example", 'rb') do |f|
  data = f.read.split("\n")
  data.each do |field_name|
    Field.create!(field_name: field_name)
  end
end

50.times do |n|
  job = Job.new(title: Faker::Job.title,
                content: Faker::Quote.matz,
                number_of_staffs: rand(1..20),
                type_of_work: rand(2),
                position: rand(5),
                min_salary: rand(1000000..4000000),
                max_salary: rand(4500000..50000000),
                candidate_experience: rand(10),
                due_date: Faker::Date.between(from: "2022-09-15", to: "2022-12-25"),
                status: 1,
                user_id: rand(4..23),
                field_id: rand(1..15))
  job.post_image.attach(io: File.open("app/assets/images/jobs/#{rand(28)}.jpg"),
                        filename: "job#{n}.jpg", content_type: "image/jpg")
  job.save!
end

10.times do |n|
  job = Job.new(title: Faker::Job.title,
                content: Faker::Quote.matz,
                number_of_staffs: rand(1..20),
                type_of_work: rand(2),
                position: rand(5),
                min_salary: rand(1000000..4000000),
                max_salary: rand(4500000..50000000),
                candidate_experience: rand(10),
                due_date: Faker::Date.between(from: "2022-09-15", to: "2022-12-25"),
                status: 1,
                user_id: 2,
                field_id: rand(1..15))
  job.post_image.attach(io: File.open("app/assets/images/jobs/#{rand(28)}.jpg"),
                        filename: "job#{n}.jpg", content_type: "image/jpg")
  job.save!
end

Field.all.each do |field|
  CurriculumVitae.create!(user_id: 3, field_id: field.id, mark: rand(1..20))
  users = User.all
  20.times do |n|
    if users[n+3].candidate? && [true, false].sample
      CurriculumVitae.create!(user_id: users[n+3].id, field_id: field.id, mark: rand(1..20))
    end
  end
end

Job.last(10).each do |job|
  cvs = CurriculumVitae.all
  cvs.each do |cv|
    if cv.field_id == job.field_id
      Recruitment.create!(curriculum_vitae_id: cv.id, job_id: job.id)
    end
  end
end
