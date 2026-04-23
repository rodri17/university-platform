# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# ============================================================
# UNIVERSITIES
# ============================================================
mit = University.create!(
  name: "MIT Europe",
  country: "Portugal",
  domain: "mit.eu",
  website: "https://www.mit.eu"
)

eth = University.create!(
  name: "ETH Zürich",
  country: "Switzerland",
  domain: "ethz.ch",
  website: "https://www.ethz.ch"
)

# ============================================================
# DEPARTMENTS
# ============================================================
cs  = Department.create!(name: "Computer Science", code: "CS",  university: mit)
ds  = Department.create!(name: "Data Science",     code: "DS",  university: mit)
eng = Department.create!(name: "Engineering",      code: "ENG", university: eth)

# ============================================================
# TERMS
# ============================================================
t1 = Term.create!(name: "Autumn 2025",  season: "Autumn", year: 2025, start_date: "2025-09-01", end_date: "2026-01-15", university: mit)
t2 = Term.create!(name: "Spring 2026",  season: "Spring", year: 2026, start_date: "2026-02-01", end_date: "2026-06-30", university: mit)
t3 = Term.create!(name: "Autumn 2025",  season: "Autumn", year: 2025, start_date: "2025-09-01", end_date: "2026-01-20", university: eth)

# ============================================================
# STUDENTS
# ============================================================
alice = Student.create!(first_name: "Alice", last_name: "Silva",  email: "alice@mit.eu",  university: mit)
bob   = Student.create!(first_name: "Bob",   last_name: "Costa",  email: "bob@mit.eu",    university: mit)
carol = Student.create!(first_name: "Carol", last_name: "Müller", email: "carol@ethz.ch", university: eth)

# ============================================================
# TEACHERS
# ============================================================
prof_ana  = Teacher.create!(first_name: "Ana",  last_name: "Ferreira", email: "ana@mit.eu",   department: cs)
prof_joao = Teacher.create!(first_name: "João", last_name: "Mendes",   email: "joao@mit.eu",  department: ds)
prof_hans = Teacher.create!(first_name: "Hans", last_name: "Weber",    email: "hans@ethz.ch", department: eng)

# ============================================================
# DEGREES
# ============================================================
bsc_cs  = Degree.create!(
  name: "BSc Computer Science",
  code: "BSC-CS",
  duration_years: 3,
  description: "Undergraduate degree covering software engineering, algorithms and systems.",
  department: cs
)

msc_ds = Degree.create!(
  name: "MSc Data Science",
  code: "MSC-DS",
  duration_years: 2,
  description: "Postgraduate degree focused on machine learning, statistics and big data.",
  department: ds
)

bsc_eng = Degree.create!(
  name: "BSc Engineering",
  code: "BSC-ENG",
  duration_years: 4,
  description: "Undergraduate engineering degree with focus on systems and applied physics.",
  department: eng
)

# ============================================================
# COURSES
# ============================================================
web = Course.create!(
  name: "Web Development",
  code: "CS101",
  description: "HTML, CSS, JavaScript and Ruby on Rails.",
  credits: 6,
  degree: bsc_cs,
  teacher: prof_ana,
  term: t1
)

db_course = Course.create!(
  name: "Databases",
  code: "CS102",
  description: "SQL, NoSQL, and data modeling fundamentals.",
  credits: 5,
  degree: bsc_cs,
  teacher: prof_joao,
  term: t1
)

ml = Course.create!(
  name: "Machine Learning",
  code: "DS201",
  description: "Supervised and unsupervised learning, model evaluation.",
  credits: 7,
  degree: msc_ds,
  teacher: prof_joao,
  term: t1
)

# ============================================================
# SCHEDULES
# ============================================================
Schedule.create!(day_of_week: "Monday",    start_time: "09:00", end_time: "11:00", room: "A101", course: web)
Schedule.create!(day_of_week: "Thursday",  start_time: "09:00", end_time: "11:00", room: "A101", course: web)
Schedule.create!(day_of_week: "Wednesday", start_time: "14:00", end_time: "16:00", room: "B202", course: db_course)
Schedule.create!(day_of_week: "Friday",    start_time: "10:00", end_time: "12:00", room: "C303", course: ml)

# ============================================================
# ENROLLMENTS
# ============================================================
e_alice_web = Enrollment.create!(student: alice, course: web,       enrolled_at: "2025-08-20", status: "active")
e_alice_db  = Enrollment.create!(student: alice, course: db_course, enrolled_at: "2025-08-20", status: "completed", final_grade: 17.5)
e_bob_web   = Enrollment.create!(student: bob,   course: web,       enrolled_at: "2025-08-21", status: "active")
e_bob_ml    = Enrollment.create!(student: bob,   course: ml,        enrolled_at: "2025-08-21", status: "dropped")
e_carol_ml  = Enrollment.create!(student: carol, course: ml,        enrolled_at: "2025-08-22", status: "active")

# ============================================================
# ASSIGNMENTS
# ============================================================
a1 = Assignment.create!(
  title: "Build a CRUD app",
  description: "Build a basic Rails CRUD application with at least 2 models.",
  due_date: "2025-11-01 23:59:00",
  max_points: 20,
  course: web
)

a2 = Assignment.create!(
  title: "ER Diagram",
  description: "Design an entity-relationship diagram for a given business case.",
  due_date: "2025-10-15 23:59:00",
  max_points: 20,
  course: db_course
)

a3 = Assignment.create!(
  title: "ML Model Report",
  description: "Train a classifier and write a report on your results.",
  due_date: "2025-11-20 23:59:00",
  max_points: 20,
  course: ml
)

# ============================================================
# SUBMISSIONS
# ============================================================
sub1 = Submission.create!(
  student: alice,
  assignment: a1,
  submitted_at: "2025-10-30 18:45:00",
  content: "https://github.com/alice/crud-app",
  status: "graded"
)

sub2 = Submission.create!(
  student: alice,
  assignment: a2,
  submitted_at: "2025-10-16 09:00:00",  # one day late
  content: "Attached ER diagram PDF.",
  status: "late"
)

sub3 = Submission.create!(
  student: bob,
  assignment: a1,
  submitted_at: "2025-11-01 22:00:00",
  content: "https://github.com/bob/my-rails-app",
  status: "submitted"
)

sub4 = Submission.create!(
  student: carol,
  assignment: a3,
  submitted_at: "2025-11-18 14:30:00",
  content: "https://github.com/carol/ml-report",
  status: "graded"
)

# ============================================================
# GRADES
# ============================================================
Grade.create!(submission: sub1, score: 18.5, feedback: "Great work, clean code and well structured.")
Grade.create!(submission: sub2, score: 14.0, feedback: "Good diagram but submitted late. Watch deadlines.")
Grade.create!(submission: sub4, score: 19.0, feedback: "Excellent analysis and very thorough report.")

puts "Seed complete!"
puts "  Universities : #{University.count}"
puts "  Departments  : #{Department.count}"
puts "  Students     : #{Student.count}"
puts "  Teachers     : #{Teacher.count}"
puts "  Courses      : #{Course.count}"
puts "  Enrollments  : #{Enrollment.count}"
puts "  Submissions  : #{Submission.count}"
puts "  Grades       : #{Grade.count}"
