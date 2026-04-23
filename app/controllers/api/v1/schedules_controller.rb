module Api
  module V1
    class SchedulesController < Api::BaseController
      def index
        schedules = Schedule.includes(course: [ :teacher, :degree, :term ]).all
        schedules = schedules.joins(:course).where(courses: { term_id: params[:term_id] })     if params[:term_id].present?
        schedules = schedules.joins(:course).where(courses: { degree_id: params[:degree_id] }) if params[:degree_id].present?
        render json: schedules.as_json(include: { course: { include: [ :teacher, :degree, :term ] } })
      end
    end
  end
end
