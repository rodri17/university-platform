class SyncCoursesJob < ApplicationJob
  queue_as :default

  # A realistic bank of course names by field
  COURSE_TEMPLATES = [
    { name: "Introduction to Programming",    code: "CS101", credits: 6 },
    { name: "Data Structures & Algorithms",   code: "CS201", credits: 6 },
    { name: "Database Systems",               code: "CS301", credits: 5 },
    { name: "Web Development",                code: "CS401", credits: 6 },
    { name: "Machine Learning",               code: "DS201", credits: 7 },
    { name: "Statistics & Probability",       code: "DS101", credits: 5 },
    { name: "Linear Algebra",                 code: "MA101", credits: 5 },
    { name: "Calculus I",                     code: "MA201", credits: 5 },
    { name: "Software Engineering",           code: "CS501", credits: 6 },
    { name: "Computer Networks",              code: "CS601", credits: 5 }
  ].freeze

  DAYS = %w[Monday Tuesday Wednesday Thursday Friday].freeze

  def perform
    Rails.logger.info "[SyncCoursesJob] Starting..."

    University.find_each do |university|
      next if university.departments.any? # already has structure, skip

      ensure_structure_for(university)
    end

    Rails.logger.info "[SyncCoursesJob] Done."
  end

  private

  def ensure_structure_for(university)
    Rails.logger.info "[SyncCoursesJob] Building structure for #{university.name}"

    # Department
    dept = university.departments.find_or_create_by!(
      name: "Computer Science",
      code: "CS"
    )

    # Term
    term = university.terms.find_or_create_by!(
      name: "Autumn 2025",
      season: "Autumn",
      year: 2025,
      start_date: Date.new(2025, 9, 1),
      end_date:   Date.new(2026, 1, 31)
    )

    # Teacher
    teacher = dept.teachers.find_or_create_by!(
      email: "professor@#{university.domain || 'university.edu'}"
    ) do |t|
      t.first_name = "Prof."
      t.last_name  = university.name.split.first
    end

    # Degree
    degree = dept.degrees.find_or_create_by!(
      name: "BSc Computer Science",
      code: "BSC-CS"
    ) do |d|
      d.duration_years = 3
      d.description    = "Undergraduate degree in Computer Science"
    end

    # Courses
    COURSE_TEMPLATES.first(5).each do |template|
      course = Course.find_or_initialize_by(
        code:   template[:code],
        degree: degree,
        term:   term
      )

      next unless course.new_record?

      course.assign_attributes(
        name:        template[:name],
        credits:     template[:credits],
        description: "#{template[:name]} course at #{university.name}",
        teacher:     teacher
      )

      if course.save
        attach_schedule(course)
      end
    end
  end

  def attach_schedule(course)
    days = DAYS.sample(2)
    days.each do |day|
      hour = [ 9, 10, 11, 14, 15, 16 ].sample
      Schedule.find_or_create_by!(
        course:      course,
        day_of_week: day
      ) do |s|
        s.start_time = Time.new(2000, 1, 1, hour, 0)
        s.end_time   = Time.new(2000, 1, 1, hour + 2, 0)
        s.room       = "Room #{rand(100..500)}"
      end
    end
  end
end
