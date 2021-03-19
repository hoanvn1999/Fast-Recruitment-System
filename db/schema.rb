# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_17_092513) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "curriculum_vitaes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "education_time"
    t.float "experience_time"
    t.float "extra_experience_time"
    t.string "refer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "field_id"
    t.index ["field_id"], name: "index_curriculum_vitaes_on_field_id"
    t.index ["user_id"], name: "index_curriculum_vitaes_on_user_id"
  end

  create_table "educations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "university_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.float "gpa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_educations_on_curriculum_vitae_id"
  end

  create_table "experiences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_experiences_on_curriculum_vitae_id"
  end

  create_table "extra_experiences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_extra_experiences_on_curriculum_vitae_id"
  end

  create_table "fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "field_name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_name"], name: "index_fields_on_field_name"
  end

  create_table "hobbies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "hobby_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_hobbies_on_curriculum_vitae_id"
  end

  create_table "institutions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "institution_name"
    t.text "address"
    t.string "logo"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_name"], name: "index_institutions_on_institution_name"
  end

  create_table "jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.integer "number_of_staffs"
    t.integer "type_of_work"
    t.integer "position"
    t.float "min_salary"
    t.float "max_salary"
    t.float "candidate_experience"
    t.datetime "due_date"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "field_id"
    t.index ["created_at"], name: "index_jobs_on_created_at"
    t.index ["field_id"], name: "index_jobs_on_field_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "language_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_languages_on_curriculum_vitae_id"
  end

  create_table "recruitments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "job_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_recruitments_on_curriculum_vitae_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "skill_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "curriculum_vitae_id"
    t.index ["curriculum_vitae_id"], name: "index_skills_on_curriculum_vitae_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.string "full_name"
    t.datetime "date_of_birth"
    t.text "address"
    t.integer "role"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "actived_at"
    t.string "remember_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "institution_id"
    t.index ["actived_at"], name: "index_users_on_actived_at"
    t.index ["institution_id"], name: "index_users_on_institution_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "curriculum_vitaes", "fields"
  add_foreign_key "curriculum_vitaes", "users"
  add_foreign_key "educations", "curriculum_vitaes"
  add_foreign_key "experiences", "curriculum_vitaes"
  add_foreign_key "extra_experiences", "curriculum_vitaes"
  add_foreign_key "hobbies", "curriculum_vitaes"
  add_foreign_key "jobs", "fields"
  add_foreign_key "jobs", "users"
  add_foreign_key "languages", "curriculum_vitaes"
  add_foreign_key "recruitments", "curriculum_vitaes"
  add_foreign_key "skills", "curriculum_vitaes"
  add_foreign_key "users", "institutions"
end
