class SyncUniversitiesJob < ApplicationJob
  queue_as :default

  COUNTRIES = %w[Portugal Spain France Germany Netherlands].freeze

  def perform
    Rails.logger.info "[SyncUniversitiesJob] Starting..."
    results = { created: 0, skipped: 0, failed: 0 }

    COUNTRIES.each do |country|
      fetch_universities_for(country, results)
    end

    Rails.logger.info "[SyncUniversitiesJob] Done — #{results}"
  end

  private

  def fetch_universities_for(country, results)
    response = HTTParty.get(
      "http://universities.hipolabs.com/search",
      query: { country: country },
      timeout: 10
    )

    unless response.success?
      Rails.logger.warn "[SyncUniversitiesJob] Failed for #{country}: #{response.code}"
      return
    end

    response.parsed_response.each do |uni|
      sync_university(uni, country, results)
    end

  rescue HTTParty::Error, Timeout::Error => e
    Rails.logger.error "[SyncUniversitiesJob] Network error for #{country}: #{e.message}"
  end

  def sync_university(data, country, results)
    name    = data["name"]&.strip
    domain  = data["domains"]&.first
    website = data["web_pages"]&.first

    return results[:skipped] += 1 if name.blank?

    # find_or_create so we don't duplicate
    uni = University.find_or_initialize_by(name: name)
    uni.assign_attributes(
      country: country,
      domain:  domain,
      website: website
    )

    if uni.save
      uni.previously_new_record? ? results[:created] += 1 : results[:skipped] += 1
    else
      Rails.logger.warn "[SyncUniversitiesJob] Could not save #{name}: #{uni.errors.full_messages}"
      results[:failed] += 1
    end
  end
end