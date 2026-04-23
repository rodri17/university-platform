module Api
  module V1
    class DegreesController < Api::BaseController
      def index
        degrees = Degree.includes(:department, :courses)
        if params[:term_id].present?
          degrees = degrees.joins(:courses).where(courses: { term_id: params[:term_id] }).distinct
        end
        render json: degrees.as_json(include: [ :department, :courses ])
      end

      def show
        degree = Degree.find(params[:id])
        render json: degrees.as_json(include: [ :department, :courses ])
      end
    end
  end
end
