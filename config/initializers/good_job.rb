Rails.application.configure do
  config.good_job.execution_mode          = :async
  config.good_job.max_threads             = 4
  config.good_job.poll_interval           = 30
  config.good_job.enable_cron             = true

  config.good_job.cron = {
    sync_universities: {
      cron:  "0 6 * * *",         # every day at 06:00
      class: "SyncUniversitiesJob",
      description: "Fetch universities from external API and sync to DB"
    },
    sync_courses: {
      cron:  "30 6 * * *",        # every day at 06:30 (after universities)
      class: "SyncCoursesJob",
      description: "Refresh course data from external API"
    }
  }
end